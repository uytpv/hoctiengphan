# CLAUDE.md - Hướng dẫn Phát triển Opi Suomea

## 1. Tổng quan dự án
**Opi Suomea** (Học tiếng Phần Lan) là hệ thống học ngoại ngữ dành cho người Việt, được thiết kế theo kiến trúc hiện đại, tập trung vào trải nghiệm người dùng Mobile và quản trị nội dung linh hoạt (CMS).
- **Mục tiêu**: Cung cấp lộ trình học theo tuần, quản lý từ vựng, ngữ pháp và bài tập tương tác.
- **Thành phần**: Mobile App (Flutter), Web Admin (Flutter Web), Backend API (NestJS).

## 2. Tech Stack
- **Frontend (Mobile & Admin)**: 
  - Framework: Flutter 3.x (Dart 3.x)
  - Quản lý trạng thái: `flutter_riverpod`
  - Điều hướng: `go_router` (ShellRoute cho Admin)
  - Data Models: `freezed`, `json_serializable`
- **Backend**:
  - Framework: NestJS (Node.js/TypeScript)
  - Integration: Firebase Admin SDK
- **Database & Services**:
  - Cloud Firestore (NoSQL), Firebase Authentication, Firebase Storage.
  - Setup: Firebase Emulators cho môi trường local.

## 3. Quy tắc Thiết kế
- **Feature-First Architecture**: Cấu trúc thư mục theo tính năng (ví dụ: `vocabulary`, `roadmap`). Mỗi feature có domain, data, và presentation layer riêng.
- **Immutability**: Sử dụng `@freezed` cho tất cả các class Model để đảm bảo tính bất biến và hỗ trợ `.copyWith()`.
- **Database Optimization**: Nhóm dữ liệu roadmap/tiến trình theo tuần (weekly documents) để tối ưu chi phí Read/Write trên Firestore.
- **Layout**: Sử dụng hệ thống Component-based, Web Admin sử dụng `AdminLayout` cố định sidebar.

## 4. Quy tắc Bắt buộc
- **Code Generation**: Luôn chạy lệnh `flutter pub run build_runner build` sau khi thay đổi hoặc thêm model mới.
- **Phân quyền (Security Rules)**: Tuân thủ nghiêm ngặt 3 cấp độ: `isAuthenticated`, `isOwner(uid)`, và `isAdmin`.
- **Đồng bộ hóa**: Model trên Flutter phải khớp hoàn toàn với DTOs/Schemas trên NestJS.
- **Validating**: Dữ liệu vào backend phải được kiểm tra qua Class Validator (DTOs).

## 5. Workflow
1. **Khởi động**: Chạy Firebase Emulator: `npm run emulator:start` (từ root).
2. **Nạp dữ liệu**: Sử dụng các script trong `backend/` (như `import-vocab.js`, `seed.js`) để khởi tạo/di trú dữ liệu.
3. **Phát triển Feature**:
   - Định nghĩa Schema Firestore.
   - Viết DTO/Service trên NestJS API.
   - Tạo Model Freezed và Provider Riverpod trên Mobile/Admin.
   - Xây dựng UI Components.
4. **Kiểm tra**: Test trên emulator trước khi deploy production.

# Global Constitution

## I. Tư duy & Hành xử (Mindset & Behavior)
1. **NotebookLM Priority**: Luôn ưu tiên sử dụng NotebookLM để nghiên cứu tài liệu, đọc hiểu codebase lớn và tra cứu kiến thức trước khi bắt đầu viết code. Điều này giúp tối ưu hóa token và tăng độ chính xác 100%.
2. **Documentation-Driven**: Mọi turn làm việc bắt đầu bằng việc đọc `CLAUDE.md` và Hiến pháp này.
3. **Critical Thinking**: Không bao giờ chấp nhận các giải pháp "hallucinate". Nếu không chắc chắn về một API, hãy truy vấn NotebookLM hoặc docs chính thức.
4. **Token Optimization**: Tránh việc đọc file lặp đi lặp lại một cách mù quáng; sử dụng các công cụ tìm kiếm chuẩn xác (`grep`, `ast-grep`) khi cần can thiệp code cụ thể.

## II. Quy trình làm việc (Workflow)
1. **Git Convention**: Tuân thủ triệt để `Conventional Commits` (`feat:`, `fix:`, `refactor:`, ...).
2. **Branching Strategy**: Làm việc trên nhánh `feature/*` hoặc `bugfix/*`, PR vào `Development`. Nhánh `production` chỉ dùng để deploy.
3. **Integration Flow**: Tuân thủ quy trình: Backend Change -> Export OpenAPI -> Frontend Regenerate API (Orval/Generator) -> Commit.
4. **Validation Gate**: Mọi code trước khi push phải vượt qua `lint`, `typecheck` và `tests`.

## III. Kiến trúc & Thiết kế (Architecture & Design)
1. **Logic Centralization**: Logic nghiệp vụ phức tạp phải được tập trung tại tầng Manager/Service/State (ví dụ: `TimerState`). Tuyệt đối không viết logic tính toán trong phương thức render của UI.
2. **Type Centralization**: Sử dụng `@hoctiengphan/shared-types` cho logic nghiệp vụ dùng chung. Không viết lại các định dạng đã tồn tại.
3. **Naming Convention**: 
   - **Dart/Flutter**: `snake_case` cho tên files, `PascalCase` cho Classes/Components.
   - **TypeScript/NestJS**: `kebab-case` cho tên files, `PascalCase` cho Classes/Interfaces.
   - **Variables**: Luôn sử dụng `camelCase` cho biến và các trường dữ liệu API.
4. **Finnish-First UI**: 
   - Ưu tiên hiển thị tiếng Phần Lan ở vị trí nổi bật nhất. 
   - Tiếng Việt/Anh đóng vai trò hỗ trợ (subtext, tooltip hoặc toggle). 
   - Localization logic phải được tách biệt rõ ràng (Rule III.1).
5. **Human-Centric Data**: 
   - Thiết kế schema dữ liệu (Vocabulary, Exercise) hướng tới việc nhập liệu thủ công dễ dàng (User-friendly JSON/Markdown).

## V. Flutter Admin Tool Patterns
1. **Import Strategy**: Luôn sử dụng package imports (`package:admin_tool/features/...`) thay vì relative imports cho các features để tránh lỗi khi di chuyển file.
2. **Rich Text Management**: Sử dụng `flutter_quill` cho các trường nội dung dài (ví dụ: `readingText`). Lưu trữ dưới dạng JSON Delta để giữ nguyên định dạng.
3. **Data Schema Patterns**: 
   - `activities` đóng vai trò là container, liên kết tới `lessons` hoặc `exercises` qua `type` và `contentId`.
   - `Exercises` hỗ trợ nhiều `type` (`multipleChoice`, `fillInBlanks`, `trueFalse`) trong cùng một collection.
4. **UI Hardening**:
   - Sử dụng `initialValue` cho `DropdownButtonFormField` thay vì `value` để tránh lỗi state khi rebuild.
   - Luôn sử dụng `Freezed` `.copyWith()` để cập nhật state trong Provider.
5. **Lint Standards**: 
   - Tắt `invalid_annotation_target` trong `analysis_options.yaml` khi làm việc với `freezed` và `json_serializable`.
   - Luôn sử dụng ngoặc nhọn `{}` cho các câu lệnh điều kiện (Standard Flutter Lint).