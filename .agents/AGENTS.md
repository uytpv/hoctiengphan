# Hướng dẫn và Quy tắc Hoạt động của Agent (Workspace Rules)

## Quy tắc Tối thượng & Bắt buộc (Hiến pháp Dự án)

1. **KHÔNG TỰ ĐỘNG ĐỒNG BỘ DỮ LIỆU LÊN PRODUCTION**:
   - **TUYỆT ĐỐI KHÔNG** chạy các tập lệnh hoặc lệnh đồng bộ, nhập hoặc di trú dữ liệu (Firestore, Auth, Storage, v.v.) từ môi trường local dev/emulator lên production (ví dụ: các file `seed-production.js`, `migrate_to_production.js`, `migrate-emulator-to-production.js`, hoặc bất kỳ thao tác ghi dữ liệu dev lên database production nào) trừ khi có yêu cầu cụ thể rõ ràng bằng văn bản của USER.
   - Khi deploy ứng dụng lên production, chỉ thực hiện build và deploy code (Firebase Hosting, Security Rules, v.v.) mà không được đụng chạm hoặc làm thay đổi/ghi đè dữ liệu hiện tại trên Firestore Production.
   - Đây là luật hiến pháp bắt buộc, bất kỳ sự vi phạm nào đều bị coi là lỗi nghiêm trọng.
