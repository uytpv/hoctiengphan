const admin = require('firebase-admin');

// 1. Cấu hình để kết nối tới Emulator
// Chú ý: Cổng (port) phải khớp với config trong firebase.json
process.env.FIRESTORE_EMULATOR_HOST = 'localhost:8080';
process.env.FIREBASE_AUTH_EMULATOR_HOST = 'localhost:9099';

const PROJECT_ID = 'hoc-tieng-phan'; // Thay đổi nếu project id khác

if (!admin.apps.length) {
    admin.initializeApp({
        projectId: PROJECT_ID
    });
}

const auth = admin.auth();
const db = admin.firestore();

async function createAdminUser(email, password) {
    console.log(`🚀 Đang tạo tài khoản Admin: ${email}...`);

    try {
        let userRecord;
        try {
            // Kiểm tra xem user đã tồn tại chưa
            userRecord = await auth.getUserByEmail(email);
            console.log('ℹ️  User đã tồn tại trong Auth. Đang cập nhật mật khẩu...');
            await auth.updateUser(userRecord.uid, { password: password });
        } catch (error) {
            if (error.code === 'auth/user-not-found') {
                // Nếu chưa có thì tạo mới
                userRecord = await auth.createUser({
                    email: email,
                    password: password,
                    displayName: 'Quản trị viên',
                    emailVerified: true
                });
                console.log('✅ Đã tạo user mới trong Auth.');
            } else {
                throw error;
            }
        }

        // Tạo/Cập nhật document trong Firestore collection 'users'
        await db.collection('users').doc(userRecord.uid).set({
            email: email,
            displayName: 'Quản trị viên',
            role: 'admin',
            updatedAt: admin.firestore.FieldValue.serverTimestamp()
        }, { merge: true });

        console.log(`
✨ HOÀN THÀNH! ✨
----------------------------------------
Tài khoản: ${email}
Mật khẩu: ${password}
Vai trò: admin (Đã cập nhật trong Firestore)
----------------------------------------
Bây giờ bạn có thể dùng tài khoản này để login vào Admin Tool.
        `);

    } catch (error) {
        console.error('❌ Lỗi:', error);
    }
}

// Chạy script với email và password mong muốn
const email = process.argv[2] || 'admin@hoctiengphan.com';
const password = process.argv[3] || 'admin123456';

createAdminUser(email, password);
