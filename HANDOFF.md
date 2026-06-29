# Project Handoff: Opi Suomea (Học Tiếng Phần)
**Date:** 2026-06-21 (Current Session)
**Status:** Feature Completed, Deployed to Production, Bug Fixes & Mobile Responsive Layouts Completed

---

## 🎯 Production Deployment Status
All components have been compiled, built, and successfully deployed to Firebase production:
- **Admin CMS Tool (Flutter Web)**: Deployed to [https://hoc-tieng-phan.web.app](https://hoc-tieng-phan.web.app) (Site Target: `hoc-tieng-phan`)
- **Student Mobile App (Flutter Web)**: Deployed to [https://htpfe.web.app](https://htpfe.web.app) (Site Target: `htpfe`)
- **Security Rules**: Deployed latest `firestore.rules` and `storage.rules` to production.

---

## ✅ Work Completed in This Session

### 1. Grammar Embed & Preview Integration
- **Markdown Grammar Editor**: Refactored the Grammar form inside `grammar_form_dialog.dart` to support direct Markdown input, allowing admins to write tables and lists easily.
- **Embedded Grammar Shortcode**: Added a toolbar button inside `lesson_edit_screen.dart` to select and embed Grammar articles using `[grammar:id]` syntax.
- **AST Parser Integration**: Custom `GrammarSyntax` was added to `markdown_preview.dart` (Admin CMS) and `markdown_content_renderer.dart` (Student App) to render the embedded grammar as a premium-styled card (with audio and tables).

### 2. Rule Enforcement (Hiến pháp Dự án)
- **Database Safety Rule**: Created `.agents/AGENTS.md` (Workspace Rules) and updated `CLAUDE.md` to append the mandatory rule: **"TUYỆT ĐỐI KHÔNG tự động đồng bộ/di trú dữ liệu (Firestore, Auth, Storage, v.v.) từ dev local lên production nếu chưa có yêu cầu cụ thể từ USER."**
- Guaranteed database safety: No local database sync or seeding script was run during this deployment.

### 3. Critical Bug Fixes
- **Web Audio Upload Fix**: Fixed the `Null check operator used on a null value` error on Web when picking `.mp3` files by adding `withData: true` to the `FilePicker.pickFiles()` calls in `grammar_form_dialog.dart`, `lesson_edit_screen.dart`, and `vocabulary_form_dialog.dart`.
- **Text Size Adjustment**: Increased base font sizes in `MarkdownStyleSheet` across both apps (Body to 18, Headings up to 28, and Tables to 16) to make Finnish dialogues and conjugation tables highly readable.

### 4. Responsive Mobile Roadmap Layout
- **Mobile Drill-Down Flow**: Solved the severely squished 3-column Row layout (Weeks -> Days -> Lessons) on mobile devices (width < 600px) which made text display vertically.
- **Flow Steps**:
  - Step 1: Shows Week list as full-width cards. Selecting a week loads the day list.
  - Step 2: Shows Day list (Mon-Sun) as full-width cards. Clicking Back returns to Weeks.
  - Step 3: Shows Activity list (lessons/exercises) full width. Clicking Back returns to Days.
- Modified: [study_plan_detail_screen.dart](file:///c:/Users/UY/works/hoctiengphan/mobile_app/lib/features/study_plan/presentation/study_plan_detail_screen.dart).

---

## 🚀 Future Steps & Notes
1. **Local Emulator Testing**:
   - Run `npm run emulator:start` in root to test local features with emulator data safely.
2. **Review User Feedback**:
   - Check user feedback for the newly deployed mobile responsive roadmap and the grammar editor.
