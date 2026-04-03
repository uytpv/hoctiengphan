# Kế hoạch Triển khai: Thiết lập & Khởi chạy Admin Web Tool

Do chúng ta đang làm việc với một dự án Monorepo phụ thuộc vào Firebase và có liên kết với Backend. Để chạy được Component Admin Web (`admin_tool`) mượt mà và không gặp lỗi "Thiếu thư viện/Platform cấu hình", chúng ta cần thiết lập môi trường cục bộ thông qua **4 Bước**.

## Thảo luận / Hỏi ý kiến người dùng

> [!IMPORTANT]
> - Máy tính của bạn hiện tại đã sử dụng/hoặc đã đăng nhập `firebase-tools` CLI và cài đặt `flutterfire` CLI chưa? 
> - Nếu bạn muốn tôi tự động thực thi các chuỗi dòng lệnh bên dưới thay cho bạn trong Terminal, hãy cấp quyền đồng ý. Ngược lại, tôi sẽ để bạn tự gõ lệnh chạy nhé!

---

## Các bước chuân bị khởi chạy

### Bước 1: Khởi tạo File Cấu hình Web Firebase (`firebase_options.dart`)
Ở bước trước, file `main.dart` của Cả Mobile và Admin Web đều được tôi thêm dòng khởi tạo `Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);`. Bạn chưa có tệp `firebase_options.dart` này trong bộ thư mục.

Do đó, bắt buộc phải chạy lệnh Config của Firebase (tự động móc nối project ID `hoctiengphan-dev` sang Flutter):
- Lệnh: `cd admin_tool && flutterfire configure --project hoctiengphan-dev --platforms=web`
*(Hành động này sẽ tải tệp json config và nhúng nó thành file Dart cho Web)*.

### Bước 2: Bật Firebase Emulator Dữ liệu ảo
Admin Web sẽ lấy dữ liệu từ Backend/Emulator, cho nên chúng ta phải dựng cái máy chủ Firebase ảo của Google lên (do ta đã cài Mode: 8080 và 9099 ở Bước 1).
- Lệnh: `cd hoctiengphan && firebase emulators:start`
*(Chạy và giữ trong một Terminal Tab riêng).*

### Bước 3: (Không bắt buộc) Chạy NestJS Backend
Mặc dù Web gọi được trực tiếp Firebase, nhưng nếu Admin Web có những Endpoint gọi REST API như phân quyền logic, Backend cần được mở chạy trên local port: `http://localhost:3000`.
- Lệnh: `cd backend && npm run start:dev`

### Bước 4: Khởi chạy Admin Tool trên Chrome
Sau khi tất cả Database Simulation và Auth Guards đã xanh, ta mở Ứng dụng Flutter Web.
- Lệnh: `cd admin_tool && flutter run -d chrome`

---

## Xác nhận thực thi

Bạn muốn tôi dùng quyền truy cập Terminal hệ thống để tự động khởi tạo lệnh Firebase và Build Web App giúp bạn chứ? Hay bạn chỉ muốn tôi sửa lại file nếu báo lỗi?
