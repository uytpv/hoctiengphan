# Tổng quan Quá trình Khởi tạo Dự án "Học Tiếng Phần"

Chào bạn, hệ thống đa module của dự án **Học Tiếng Phần** đã được cài đặt và cấu trúc chính xác theo kế hoạch! Mọi thay đổi về source code đã được sinh tự động hóa qua CLI và file config. Dưới đây là những gì đã được thực hiện và hướng dẫn để bạn có thể tiếp tục.

### Kiến trúc Root

- Mọi module đều nằm vào các thư mục riêng rẽ: `mobile_app`, `admin_tool`, `backend`.
- Đã tạo ra `firebase.json` và `.firebaserc` (sử dụng *hoctiengphan-dev*) ở thư mục root chuyên biệt cho Local Emulators Suite (Auth, Firestore, Hosting Web).

### Backend (NestJS)

- Tích hợp package `firebase-admin` vào bên trong NestJS.
- Tôi đã thiết lập `FirebaseModule` và `FirebaseService` ở `backend/src/firebase/`.
- Logic đã được cấu trúc sẽ tự động can thiệp vào environment của Node.js: Khi bạn chạy server ở chế độ Development (`npm run start:dev`), Firebase Admin SDK sẽ đọc port của Auth: 9099 và Firestore: 8080.

### Frontend (Flutter Mobile & Flutter Web)

- Các thư viện bắt buộc gồm `firebase_core`, `firebase_auth`, và `cloud_firestore` đã được cài đặt vào `pubspec.yaml` của cả `mobile_app` và `admin_tool`.
- Tôi đã sửa code trong `lib/main.dart` của hai app để nó tự động sử dụng `emulator override` khi phát triển cục bộ (`kDebugMode = true`). 
- **Đặc biệt**: Mobile App được config sẵn map IP `10.0.2.2` nếu bạn chạy qua Android Emulator để kết nối đến Localhost của host machine. Web thì ưu tiên dùng `localhost`.

---

## Các thao tác cần thiết tiếp theo

> [!WARNING]
> Hiện tại, logic Flutter đang comment dòng load `DefaultFirebaseOptions`. Bạn **BẮT BUỘC** phải chạy lệnh Flutterfire CLI để kết nối App với Firebase project trên Cloud nhằm sinh ra file cấu hình `firebase_options.dart`.

1. **Sinh tuỳ chọn Firebase cho Flutter**:
   Mở terminal và trỏ vào từng thư mục (`mobile_app` và `admin_tool`), sau đó chạy:
   ```bash
   flutterfire configure --project hoctiengphan-dev
   ```
   (Sau khi có file này, bạn chỉ cần gỡ log comment chỗ `await Firebase.initializeApp(options: ...)` ở trong `main.dart`).

2. **Khởi động Firebase Emulator Suite**:
   Đứng ở root project và gõ:
   ```bash
   firebase emulators:start
   ```

3. **Khởi chạy Backend**:
   Mở 1 terminal mới trỏ vào `backend/` và gõ:
   ```bash
   npm run start:dev
   ```

4. **Chạy các ứng dụng UI**:
   - Web: `cd admin_tool && flutter run -d chrome`
   - Mobile: `cd mobile_app && flutter run` (Cần bật iOS Simulator/Android Emulator).
