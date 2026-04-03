const admin = require('firebase-admin');

process.env.FIRESTORE_EMULATOR_HOST = 'localhost:8080';

admin.initializeApp({
  projectId: 'hoctiengphan-dev'
});

const db = admin.firestore();

async function test() {
  const lessonSnapshot = await db.collection('lessons').get();
  console.log(`Lessons IDs and names:`);
  lessonSnapshot.docs.forEach(doc => {
      console.log(`${doc.id} => ${doc.data().name}`);
  });
}

test();
