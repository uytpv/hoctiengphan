const admin = require('firebase-admin');

// Configure emulator
process.env.FIRESTORE_EMULATOR_HOST = 'localhost:8080';
process.env.FIREBASE_AUTH_EMULATOR_HOST = 'localhost:9099';

if (!admin.apps.length) {
  admin.initializeApp({
    projectId: 'hoctiengphan-dev'
  });
}

const db = admin.firestore();

async function patchEmulator() {
  console.log('🔄 Đang cấu hình tài khoản Admin...');

  const email = 'traphucvinhuy012022@gmail.com';
  const password = 'password123'; // Mật khẩu mặc định cho Admin
  let adminUid;

  try {
    const userRecord = await admin.auth().getUserByEmail(email);
    adminUid = userRecord.uid;
    console.log(`ℹ️ Tài khoản đã tồn tại với UID: ${adminUid}`);
    // Cập nhật mật khẩu để chắc chắn đăng nhập được
    await admin.auth().updateUser(adminUid, { password });
  } catch (error) {
    const userRecord = await admin.auth().createUser({
      email,
      password,
      displayName: 'Admin Uy',
    });
    adminUid = userRecord.uid;
    console.log(`✅ Khởi tạo tài khoản Auth mới với UID: ${adminUid}`);
  }

  const userRef = db.collection('users').doc(adminUid);

  // Thêm Role
  await userRef.set({ 
    email,
    displayName: 'Admin Uy',
    role: 'admin' 
  }, { merge: true });
  console.log(`✅ Đã đồng bộ quyền "admin" trong Firestore cho: ${email}`);
  console.log(`🔑 Thông tin đăng nhập: Email: ${email} | Pass: ${password}`);

  // Xóa collection custom_vocabularies (trong emulator việc xóa batch từng document)
  const customVocabsSnapshot = await userRef.collection('custom_vocabularies').get();
  if (!customVocabsSnapshot.empty) {
    const batch = db.batch();
    customVocabsSnapshot.docs.forEach(doc => {
      batch.delete(doc.ref);
    });
    await batch.commit();
    console.log('✅ Đã dọn dẹp custom_vocabularies cũ');
  }

  // Tạo notebook sample
  const notebookVocRef = userRef.collection('notebook_vocabularies').doc('dummy_voc_id');
  await notebookVocRef.set({
    vocabularyId: "dummy_voc_id",
    status: "learned",
    addedAt: admin.firestore.FieldValue.serverTimestamp()
  });
  console.log('✅ Đã tạo notebook_vocabularies mẫu');
  
  console.log('🎉 Hoàn tất vá lỗi Emulator Dữ liệu Live!');
}

patchEmulator().catch(console.error);
