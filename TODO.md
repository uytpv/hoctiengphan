# Opi Suomea Project TODO

## 🔴 Tiêu chuẩn Codebase (Cần khắc phục ngay)
- [x] **Type Centralization**: Thiết lập và sử dụng `@hoctiengphan/shared-types` cho cả Backend và Frontend.
- [x] **Naming Convention**: Chuẩn hóa tên Files sang `snake_case` cho Dart (mobile_app) và `snake_case` cho backend, tuân thủ best practices của từng ngôn ngữ.
- [ ] **Integration Flow**: Thiết lập xuất OpenAPI từ NestJS và tự động generate API cho Flutter/Admin Tool (Rule II.3).
- [ ] **Strict Typing**: Kiểm tra và loại bỏ `any` trong logic nghiệp vụ, thay thế bằng interfaces từ shared-types (Rule IV.2).
- [ ] **Logic Centralization**: Review lại `mobile_app` để đảm bảo logic timer/validation không bị leak vào Widget (Rule III.1).

## ## Exercise & Testing Module
- [ ] Implement the backend logic for submitting exercise answers.
- [ ] Build the mobile/student-facing UI for taking exercises (multiple-choice, fill-in-blanks, true-false).
- [ ] Create the scoring and results system (as seen in `demo.jsx`).
- [ ] Add support for "Test/Quiz" mode where results are saved to a user's profile.
- [ ] Implement feedback/explanation display after answer submission.

## CMS Enhancements
- [x] Decouple Grammar and Exercise into standalone Firestore collections.
- [x] Redesign Lesson Edit UI with 5 tabs.
- [x] Add a search/filter by Chapter/Kappale for Vocabulary.
- [x] Implement safe-delete confirmation dialogs for Vocabulary and Study Plan items.
- [ ] Support Audio upload (MP3) for Vocabulary directly to Firebase Storage.
- [ ] Implement Chapter/Lesson filtering for Exercises.

## Student & Progress Tracking
- [x] Implement UserProfile and Enrollment models.
- [x] Build Student Management table with progress bars.
- [ ] Implement actual progress update logic when a student completes an activity in the mobile app.
- [ ] Add pagination for Student and Vocabulary lists (Performance).

## Security & DevOps
- [ ] Formalize Admin Provisioning (script or Firebase Function to set `role: 'admin'`).
- [ ] Configure GitHub Actions for CI/CD (Flutter build, Firebase deployment).
- [ ] Standardize UI Language (consistent Vietnamese/English localization).

## Data Migration
- [ ] Data migration script for legacy embedded lesson content.
- [ ] Cleanup dummy/seed data before moving to official production instance.