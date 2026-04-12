const admin = require('firebase-admin');
const fs = require('fs');
const path = require('path');

// ==========================================
// CONFIGURATION
// ==========================================
const SERVICE_ACCOUNT_PATH = path.join(__dirname, './hoc-tieng-phan-firebase-adminsdk-fbsvc-cbfffbc13f.json');
const PROJECT_ID = 'hoc-tieng-phan';

if (!fs.existsSync(SERVICE_ACCOUNT_PATH)) {
  console.error('❌ Service account key not found at:', SERVICE_ACCOUNT_PATH);
  process.exit(1);
}

const serviceAccount = require(SERVICE_ACCOUNT_PATH);

// 1. Initialize Production App
const prodApp = admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  projectId: PROJECT_ID
}, 'production');

// 2. Initialize Local Emulator App
// Note: We avoid setting FIRESTORE_EMULATOR_HOST globally to not affect prodApp
const localApp = admin.initializeApp({
  projectId: PROJECT_ID
}, 'local');

const localDb = localApp.firestore();
localDb.settings({
  host: '127.0.0.1:8080',
  ssl: false
});

const prodDb = prodApp.firestore();

const COLLECTIONS = [
  'vocabularies', 
  'lessons', 
  'categories', 
  'activities', 
  'grammars', 
  'exercises', 
  'study_plans', 
  'study_plan_weeks'
];

async function clearProductionCollection(collectionName) {
  console.log(`🧹 Clearing production collection: ${collectionName}...`);
  const snapshot = await prodDb.collection(collectionName).get();
  const batchSize = 500;
  const docs = snapshot.docs;
  
  for (let i = 0; i < docs.length; i += batchSize) {
    const batch = prodDb.batch();
    const chunk = docs.slice(i, i + batchSize);
    chunk.forEach(doc => batch.delete(doc.ref));
    await batch.commit();
  }
}

async function migrateCollection(collectionName) {
  console.log(`🚀 Migrating collection: ${collectionName}...`);
  
  // 1. Get data from local
  const snapshot = await localDb.collection(collectionName).get();
  console.log(`📦 Found ${snapshot.size} documents in local ${collectionName}`);

  if (snapshot.empty) {
    console.log(`⚠️ Collection ${collectionName} is empty in local. Skipping.`);
    return;
  }

  // 2. Clear production (Full overwrite to ensure sync)
  await clearProductionCollection(collectionName);

  // 3. Push to production
  const batchSize = 500;
  const docs = snapshot.docs;
  let count = 0;

  for (let i = 0; i < docs.length; i += batchSize) {
    const batch = prodDb.batch();
    const chunk = docs.slice(i, i + batchSize);
    
    chunk.forEach(doc => {
      batch.set(prodDb.collection(collectionName).doc(doc.id), doc.data());
      count++;
    });
    
    await batch.commit();
    console.log(`...pushed ${count}/${snapshot.size} docs to ${collectionName}`);
  }
  
  console.log(`✅ Finished migrating ${collectionName}\n`);
}

async function run() {
  console.log('--- STARTING DATABASE MIGRATION FROM LOCAL TO PRODUCTION ---');
  console.log('Project ID:', PROJECT_ID);
  
  try {
    for (const coll of COLLECTIONS) {
      await migrateCollection(coll);
    }
    
    console.log('🎉 ALL DATA MIGRATED SUCCESSFULLY!');
    process.exit(0);
  } catch (err) {
    console.error('❌ Migration failed:', err);
    process.exit(1);
  }
}

run();
