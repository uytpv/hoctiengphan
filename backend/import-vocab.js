const fs = require('fs');
const path = require('path');
const admin = require('firebase-admin');

// 1. Cấu hình Emulator
process.env.FIRESTORE_EMULATOR_HOST = 'localhost:8080';
process.env.FIREBASE_AUTH_EMULATOR_HOST = 'localhost:9099';

if (!admin.apps.length) {
  admin.initializeApp({
    projectId: 'hoctiengphan-dev'
  });
}

const db = admin.firestore();

async function importVocabularies() {
  console.log('📖 Đang đọc dữ liệu từ file initialVocabularyData.js...');
  
  const filePath = path.join(__dirname, '../docs/initialVocabularyData.js');
  const fileContent = fs.readFileSync(filePath, 'utf-8');
  
  // Trích xuất mảng dữ liệu bằng Regex hoặc eval (vì file là export JS)
  const startIndex = fileContent.indexOf('[');
  const endIndex = fileContent.lastIndexOf(']') + 1;
  const arrayString = fileContent.substring(startIndex, endIndex);
  
  let vocabularyData;
  try {
    // Sử dụng Function để parse mảng an toàn hơn eval trực tiếp
    vocabularyData = new Function(`return ${arrayString}`)();
  } catch (e) {
    console.error("❌ Lỗi khi phân tích dữ liệu tệp:", e);
    return;
  }

  console.log(`✅ Khởi tạo: tìm thấy ${vocabularyData.length} từ vựng.`);

  // 2. Chuẩn bị Map cho Lessons và Categories (để tránh trùng lặp)
  const lessonsMap = new Map(); // Name -> ID
  const categoriesMap = new Map(); // Name -> ID

  // 3. Quy trình xử lý IDs
  console.log('🏗️ Đang xử lý cấu trúc Lessons và Categories...');

  // Tạo IDs trước để tham chiếu
  for (const item of vocabularyData) {
    let lessonName, categoryName;

    if (item.category.includes(':')) {
      const parts = item.category.split(':');
      lessonName = parts[0].trim();
      categoryName = parts[1].trim();
    } else {
      lessonName = "Sanasto Laajennus"; // Mặc định cho các từ bổ sung
      categoryName = item.category.trim();
    }

    if (!lessonsMap.has(lessonName)) {
      lessonsMap.set(lessonName, db.collection('lessons').doc().id);
    }
    if (!categoriesMap.has(categoryName)) {
      categoriesMap.set(categoryName, db.collection('categories').doc().id);
    }

    // Gán ID vào item để xử lý sau
    item._lessonId = lessonsMap.get(lessonName);
    item._categoryId = categoriesMap.get(categoryName);
    item._lessonName = lessonName;
    item._categoryName = categoryName;
  }

  // 4. Batch Write: Lessons
  console.log(`📤 Đang nạp ${lessonsMap.size} lessons...`);
  let batch = db.batch();
  lessonsMap.forEach((id, name) => {
    batch.set(db.collection('lessons').doc(id), { name, createdAt: admin.firestore.FieldValue.serverTimestamp() });
  });
  await batch.commit();

  // 5. Batch Write: Categories
  console.log(`📤 Đang nạp ${categoriesMap.size} categories...`);
  batch = db.batch();
  categoriesMap.forEach((id, name) => {
    batch.set(db.collection('categories').doc(id), { name, createdAt: admin.firestore.FieldValue.serverTimestamp() });
  });
  await batch.commit();

  // 6. Batch Write: Vocabularies
  console.log(`📤 Đang nạp ${vocabularyData.length} vocabularies (chia theo lô 500)...`);
  let count = 0;
  batch = db.batch();

  for (const item of vocabularyData) {
    const vocabRef = db.collection('vocabularies').doc();
    
    batch.set(vocabRef, {
      finnish: item.finnish,
      pronunciation: item.pronunciation,
      english: item.english,
      vietnamese: item.vietnamese,
      isGlobal: true,
      lessonId: item._lessonId, // 1-M
      categoryIds: [item._categoryId], // M-M (theo yêu cầu một từ có thể nhiều category, ở đây tạm lấy 1 từ file)
      createdAt: admin.firestore.FieldValue.serverTimestamp()
    });

    count++;
    if (count % 500 === 0) {
      await batch.commit();
      batch = db.batch();
      console.log(`...đã nạp ${count} từ.`);
    }
  }

  if (count % 500 !== 0) {
    await batch.commit();
  }

  console.log('🎉 THÀNH CÔNG! Toàn bộ từ vựng đã được tổ chức lại theo cấu trúc mới.');
}

importVocabularies().catch(console.error);
