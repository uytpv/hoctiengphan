# Opi Suomea Project TODO

## Exercise & Testing Module
- [ ] Implement the backend logic for submitting exercise answers.
- [ ] Build the mobile/student-facing UI for taking exercises (multiple-choice, fill-in-blanks, true-false).
- [ ] Create the scoring and results system (as seen in `demo.jsx`).
- [ ] Add support for "Test/Quiz" mode where results are saved to a user's profile.
- [ ] Implement feedback/explanation display after answer submission.

## CMS Enhancements
- [x] Decouple Grammar and Exercise into standalone Firestore collections.
- [x] Redesign Lesson Edit UI with 5 tabs.
- [ ] Add a search/filter by Chapter/Kappale for Grammar and Exercises.
- [ ] Support Audio upload (MP3) for Vocabulary and Grammar items directly to Firebase Storage.
- [ ] Implement safe-delete confirmation dialogs for all critical records (Study Plans, Lessons).

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
