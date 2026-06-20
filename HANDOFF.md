# Project Handoff: Opi Suomea (Học Tiếng Phần)
**Date:** 2026-06-20 (Current Session)
**Status:** Restructuring Completed, Data Migrated, Deployed to Production

---

## 🎯 Production Deployment Status
All components have been compiled, built, and successfully deployed to Firebase production:
- **Admin CMS Tool (Flutter Web)**: Deployed to [https://hoc-tieng-phan.web.app](https://hoc-tieng-phan.web.app)
- **Student Mobile App (Flutter Web)**: Deployed to [https://htpfe.web.app](https://htpfe.web.app)
- **Database (Cloud Firestore)**: Successfully migrated all local emulator collections to production using the migration script.
- **Security Rules**: Deployed latest `firestore.rules` and `storage.rules` to production.

---

## ✅ Work Completed in This Session
### 1. Architectural Restructuring (Interactive Document-Centric)
- **Model Re-design**: Redesigned `Lesson` structure to support embedding vocabulary, audio, exercises, and videos as inline shortcodes (`[vocab:id|text]`, `[audio:url]`, `[exercise:id]`, `[video:id]`) directly in the Markdown text.
- **Custom Markdown AST Syntax**: Refactored the raw regex parser in both Admin Tool and Mobile App to use a standard AST `InlineSyntax` class extending `markdown.InlineSyntax`. This allows Flutter's markdown renderer to correctly map shortcodes to beautiful, interactive custom inline widgets instead of displaying raw HTML/text.
- **Firestore Schema Synchronization**: Restructured `Lessons`, `Activities`, `Grammars`, and `Exercises` collections to align with the new model and verified static compilation (`flutter analyze` with 0 errors).

### 2. Audio & TTS Pronunciation Integration
- **Native TTS Fallback**: Integrated the `flutter_tts` package. In both the Student App's vocabulary bottom sheet and the Admin CMS preview, clicking a vocabulary word plays high-quality Finnish (`fi-FI`) audio natively. If an audio file MP3 is missing, the system uses TTS as a fallback.
- **Interactive Speakers**: Updated speaker buttons to toggle icons dynamically (Volume 🔊 to Stop ⏹️), allowing users to immediately stop audio playback.
- **Admin Vocabulary Audio**: Replaced placeholders in `VocabularyListScreen` with working audio buttons (`_VocabListPlayButton`) to test Finnish pronunciations directly from the manager table.

### 3. Bugs Fixed
- **Mobile Load Error**: Fixed a critical firestore query error in the Mobile App's `StudyPlanRepository` where student progress tracking was looking up the wrong collection path. Progress is verified to track correctly under `user_progress/{uid}/plans/{planId}`.
- **Firestore Timestamp mapping**: Resolved a runtime crash in Admin Tool's `lesson_repository.dart` where Firestore `Timestamp` values were not correctly converted to Dart's `DateTime` instances.

### 4. Database Migration
- Successfully executed `backend/migrate-emulator-to-production.js`, clearing and fully syncing the production Firestore with:
  - 1,888 vocabularies
  - 73 lessons
  - 63 categories
  - 80 activities
  - 94 grammars
  - 240 exercises
  - 50 study plan weeks / plans

---

## 🏗️ Technical Architecture & Schema
- **Database**: Cloud Firestore (Production ID: `hoc-tieng-phan`).
- **Main Collections**:
  - `vocabularies`: Vocabulary metadata and fallback audio.
  - `lessons`: Markdown-centric content containing shortcodes.
  - `activities`: Intermediate wrappers linking weekly study plan days to lessons or exercises.
  - `exercises`: Multi-format quizzes (`multipleChoice`, `fillInBlanks`, `trueFalse`).
  - `study_plans` / `study_plan_weeks`: Lộ trình học theo tuần cho học viên.
  - `user_progress`: Student progress tracker map.

---

## 🚀 Immediate Next Steps (For Next Session)
1. **TTS Platform Check**:
   - Verify the `flutter_tts` package initialization on actual Android/iOS emulators. If a `MissingPluginException` occurs, execute `flutter run` afresh from the terminal to build and link native packages.
2. **Audio File Upload Support**:
   - Implement the feature in the Admin CMS to allow uploading custom MP3 recordings directly to Firebase Storage.
3. **Database Performance Hardening**:
   - Monitor database queries on production to see if any custom Firestore indexes are required as traffic grows.
   - Implement pagination/lazy-loading for the Admin Tool tables (Students, Vocabulary) to optimize read costs.
