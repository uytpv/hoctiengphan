const admin = require('firebase-admin');

// Configure emulator
process.env.FIRESTORE_EMULATOR_HOST = 'localhost:8080';
process.env.FIREBASE_AUTH_EMULATOR_HOST = 'localhost:9099';

if (!admin.apps.length) {
  admin.initializeApp({
    projectId: 'hoctiengphan-dev' // Use your project ID from firebase.json/rc
  });
}

const db = admin.firestore();

async function initDatabase() {
  console.log('🚀 Đang khởi tạo cấu trúc dữ liệu Firestore...');

  const batch = db.batch();

  // 1. COLLECTION: roadmaps
  const month1Ref = db.collection('roadmaps').doc('month_1');
  batch.set(month1Ref, {
    monthId: 1,
    title: "Tháng 1: Nền tảng cơ bản (Kappale 1 & 2)",
    weeks: [
      {
        weekId: 1,
        title: "Tuần 1: Xin chào & Chào hỏi",
        days: [
          {
            dayName: "Maanantai (Thứ Hai)",
            tasks: [
              {
                id: "m1w1d1t1",
                title: "Học từ vựng cơ bản Kappale 1",
                iconType: "Users",
                detail: "Nghe và lặp lại các câu chào hỏi: Hei, Moi, Terve.",
                activityType: "vocabulary",
                lessonReferenceId: "kappale_1" // Dummy ID
              }
            ]
          }
        ]
      }
    ]
  });

  // 2. COLLECTION: vocabularies (Global)
  const voc1Ref = db.collection('vocabularies').doc();
  batch.set(voc1Ref, {
    finnish: "Hei",
    pronunciation: "/hei/",
    english: "Hello",
    vietnamese: "Xin chào",
    category: "Kappale 1",
    isGlobal: true,
    createdAt: admin.firestore.FieldValue.serverTimestamp()
  });

  const voc2Ref = db.collection('vocabularies').doc();
  batch.set(voc2Ref, {
    finnish: "Kiitos",
    pronunciation: "/kiːtos/",
    english: "Thank you",
    vietnamese: "Cảm ơn",
    authorUid: null,
    createdAt: admin.firestore.FieldValue.serverTimestamp()
  });

  // 3. COLLECTION: grammar_lessons
  const grammarRef = db.collection('grammar_lessons').doc('olla');
  batch.set(grammarRef, {
    chapter: "Kappale 1",
    title: "Động từ Olla (To be)",
    desc: "Cách chia động từ quan trọng nhất trong tiếng Phần.",
    content: "<h3>Động từ Olla</h3><p>Minä olen, Sinä olet...</p>"
  });

  // 4. COLLECTION: users (Sample User)
  const dummyUid = "test_user_123";
  const userRef = db.collection('users').doc(dummyUid);
  batch.set(userRef, {
    email: "test@example.com",
    displayName: "Học Viên Mẫu",
    role: "admin", // <--- THEO NHƯ ĐỀ XUẤT MỚI
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    lastLogin: admin.firestore.FieldValue.serverTimestamp()
  });

  // Sub-collection: progress
  const progressRef = userRef.collection('progress').doc('roadmap_tasks');
  batch.set(progressRef, {
    completedTasks: {
      "m1w1d1t1": true
    },
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  });

  // Không còn custom_vocabularies, thay bằng notebook_vocabularies
  const notebookVocRef = userRef.collection('notebook_vocabularies').doc('dummy_voc_id');
  batch.set(notebookVocRef, {
    vocabularyId: "dummy_voc_id",
    status: "learned",
    addedAt: admin.firestore.FieldValue.serverTimestamp()
  });

  await batch.commit();
  console.log('✅ Khởi tạo thành công! Vui lòng kiểm tra lại Firestore Emulator UI.');
}

initDatabase().catch(err => {
  console.error('❌ Lỗi khởi tạo:', err);
});
