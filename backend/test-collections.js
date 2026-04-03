const admin = require('firebase-admin');

process.env.FIRESTORE_EMULATOR_HOST = 'localhost:8080';

admin.initializeApp({
  projectId: 'hoctiengphan-dev'
});

const db = admin.firestore();

async function test() {
  const collections = ['lesson', 'lessons', 'vocabulary', 'vocabularies'];
  for (const c of collections) {
    const snapshot = await db.collection(c).get();
    console.log(`Collection '${c}': ${snapshot.size} documents`);
    if (snapshot.size > 0) {
        console.log(`Available keys in '${c}':`, Object.keys(snapshot.docs[0].data()));
        console.log(`Sample doc from '${c}':`, snapshot.docs[0].data());
    }
  }
}

test();
