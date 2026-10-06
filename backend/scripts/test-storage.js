const admin = require('firebase-admin');
const serviceAccount = require('../hoc-tieng-phan-firebase-adminsdk-fbsvc-cbfffbc13f.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  storageBucket: 'hoc-tieng-phan.firebasestorage.app'
});

async function testBucket() {
  try {
    const bucket = admin.storage().bucket();
    const [exists] = await bucket.exists();
    console.log('Bucket exists:', exists, 'Name:', bucket.name);
  } catch (err) {
    console.error('Error with hoc-tieng-phan.firebasestorage.app:', err.message);
    try {
      const bucket2 = admin.storage().bucket('hoc-tieng-phan.appspot.com');
      const [exists2] = await bucket2.exists();
      console.log('Bucket2 exists:', exists2, 'Name:', bucket2.name);
    } catch (e) {
      console.error('Error with hoc-tieng-phan.appspot.com:', e.message);
    }
  }
}

testBucket();
