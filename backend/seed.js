const fs = require('fs');
const admin = require('firebase-admin');

// Configure emulator
process.env.FIRESTORE_EMULATOR_HOST = 'localhost:8080';
process.env.FIREBASE_AUTH_EMULATOR_HOST = 'localhost:9099';

admin.initializeApp({
  projectId: 'hoctiengphan-dev'
});

const db = admin.firestore();

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

async function seedData() {
  const fileContent = fs.readFileSync('../docs/initialVocabularyData.js', 'utf-8');
  const startIndex = fileContent.indexOf('const initialVocabularyData = [');
  const endIndex = fileContent.lastIndexOf('];') + 2;
  
  if (startIndex === -1 || endIndex === 0) {
    console.log('Could not find data in docs/initialVocabularyData.js');
    return;
  }
  
  const arrayString = fileContent.substring(startIndex + 'const initialVocabularyData = '.length, endIndex);
  
  // Safe evaluation
  let vocabularyList;
  try {
    vocabularyList = Function(`return ${arrayString}`)();
  } catch(e) {
    console.error("Failed to parse initialVocabularyData.js", e);
    return;
  }
  
  console.log(`Found ${vocabularyList.length} vocabulary items. Seeding to Firestore emulator...`);
  
  // Clear old data
  await clearCollection('vocabularies');
  await clearCollection('lessons');
  
  // First, map out unique categories to create lessons
  const lessonNameMap = {}; // { 'Kappale 1: Tervehdykset': 'lesson-id' }
  const uniqueCategories = [...new Set(vocabularyList.map(item => item.category))];
  
  console.log(`Found ${uniqueCategories.length} unique lessons. Creating lesson documents...`);
  
  let batch = db.batch();
  for (const categoryName of uniqueCategories) {
    const lessonRef = db.collection('lessons').doc();
    lessonNameMap[categoryName] = lessonRef.id;
    
    // Attempt to extract chapter and title if format is "Kappale X: Title"
    batch.set(lessonRef, {
      title: categoryName, // Maps the old category name to the new title
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
  console.log('Lesson documents created with new structure.');
  
  // Now add vocabulary items
  batch = db.batch();
  let count = 0;
  const batchLimit = 500;
  
  for (const item of vocabularyList) {
    const docRef = db.collection('vocabularies').doc();
    const lessonId = lessonNameMap[item.category];
    
    // Remove category, add lessonId
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
    }
  }
  
  if (count % batchLimit !== 0) {
    await batch.commit();
  }
  
  console.log('Vocabulary seeding completed successfully!');
}

seedData().catch(console.error);

