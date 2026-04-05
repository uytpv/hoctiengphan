const fs = require('fs');
const admin = require('firebase-admin');
const path = require('path');

// 1. Cấu hình xác thực với Service Account thật
const serviceAccount = require('./hoc-tieng-phan-firebase-adminsdk-fbsvc-cbfffbc13f.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  projectId: 'hoc-tieng-phan' 
});

const db = admin.firestore();

// Hàm dọn dẹp Collection (Cẩn thận khi dùng trên Production)
async function clearCollection(collectionPath) {
  const querySnapshot = await db.collection(collectionPath).get();
  if (querySnapshot.size === 0) return;
  
  const docs = querySnapshot.docs;
  const batchLimit = 500;
  
  for (let i = 0; i < docs.length; i += batchLimit) {
    const batch = db.batch();
    const chunk = docs.slice(i, i + batchLimit);
    chunk.forEach((doc) => batch.delete(doc.ref));
    await batch.commit();
  }
  
  console.log(`Cleared collection: ${collectionPath} (${docs.length} docs)`);
}

async function migrateData() {
  console.log('--- Đang bắt đầu tiến trình DI CƯ lên PRODUCTION ---');
  
  // Đọc dữ liệu từ file local
  const dataPath = path.join(__dirname, '../docs/initialVocabularyData.js');
  const fileContent = fs.readFileSync(dataPath, 'utf-8');
  const startIndex = fileContent.indexOf('const initialVocabularyData = [');
  const endIndex = fileContent.lastIndexOf('];') + 2;
  
  if (startIndex === -1 || endIndex === 0) {
    console.log('Lỗi: Không tìm thấy dữ liệu nguồn trong docs/initialVocabularyData.js');
    return;
  }
  
  const arrayString = fileContent.substring(startIndex + 'const initialVocabularyData = '.length, endIndex);
  
  let vocabularyList;
  try {
    vocabularyList = Function(`return ${arrayString}`)();
  } catch(e) {
    console.error("Lỗi: Không thể phân tích cú pháp dữ liệu nguồn", e);
    return;
  }
  
  console.log(`>>> Tìm thấy ${vocabularyList.length} mục từ vựng.`);
  
  // TÙY CHỌN: Dọn dẹp trước khi bơm (Hãy cân nhắc nếu đã có dữ liệu thật trên Cloud)
  // await clearCollection('vocabularies');
  // await clearCollection('lessons');
  
  const lessonNameMap = {}; 
  const uniqueCategories = [...new Set(vocabularyList.map(item => item.category))];
  
  console.log(`>>> Đang khởi tạo ${uniqueCategories.length} bài học (Lessons) trên Cloud...`);
  
  let batch = db.batch();
  for (const categoryName of uniqueCategories) {
    const lessonRef = db.collection('lessons').doc();
    lessonNameMap[categoryName] = lessonRef.id;
    
    batch.set(lessonRef, {
      title: categoryName,
      description: `Mô tả nội dung cho bài học ${categoryName}`,
      lessonContent: {
        text: `Nội dung chi tiết bài học cho ${categoryName}.`,
        videoUrl: '',
        imageIds: []
      },
      grammar: {
        text: 'Nội dung ngữ pháp đang được cập nhật.',
        audioUrl: ''
      },
      speaking: {
        text: 'Nội dung luyện nói đang được cập nhật.',
        audioUrl: '',
        conversationUrl: ''
      },
      exerciseIds: []
    });
  }
  await batch.commit();
  console.log('+++ Đã tạo xong danh sách Bài học.');
  
  console.log(`>>> Đang bơm ${vocabularyList.length} từ vựng lên các Bài học tương ứng...`);
  batch = db.batch();
  let count = 0;
  const batchLimit = 500;
  
  for (const item of vocabularyList) {
    const docRef = db.collection('vocabularies').doc();
    const lessonId = lessonNameMap[item.category];
    
    const { category, ...itemData } = item;
    
    batch.set(docRef, {
      ...itemData,
      lessonId: lessonId,
      isGlobal: true,
      authorId: 'admin'
    });
    
    count++;
    if (count % batchLimit === 0) {
      await batch.commit();
      batch = db.batch();
      console.log(`... Đã bơm ${count} mục.`);
    }
  }
  
  if (count % batchLimit !== 0) {
    await batch.commit();
  }
  
  console.log(`--- HOÀN TẤT DI CƯ: ${count} từ vựng đã lên sóng PRODUCTION! ---`);
}

migrateData().catch(console.error);
