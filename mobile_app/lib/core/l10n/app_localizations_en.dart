// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Learn Finnish';

  @override
  String get loginTitle => 'Sign In';

  @override
  String get loginSubtitle => 'Continue learning';

  @override
  String get loginWithGoogle => 'Continue with Google';

  @override
  String get studyPlans => 'Study Plans';

  @override
  String get weeks => 'Weeks';

  @override
  String get week => 'Week';

  @override
  String get days => 'Days';

  @override
  String get day => 'Day';

  @override
  String get activities => 'Activities';

  @override
  String get lesson => 'Lesson';

  @override
  String get exercise => 'Exercise';

  @override
  String get grammar => 'Grammar';

  @override
  String get vocabulary => 'Vocabulary';

  @override
  String get markAsDone => 'Mark as Done';

  @override
  String get lessonCompleted => 'Lesson completed!';

  @override
  String get submitExercise => 'Submit';

  @override
  String get retryExercise => 'Try Again';

  @override
  String get completeExercise => 'Complete Exercise';

  @override
  String get exerciseResult => 'Result';

  @override
  String get score => 'Score';

  @override
  String correctAnswers(int correct, int total) {
    return '$correct/$total correct';
  }

  @override
  String get done => 'Done';

  @override
  String get inProgress => 'In Progress';

  @override
  String get todo => 'To Do';

  @override
  String get settings => 'Settings';

  @override
  String get secondaryLanguage => 'Secondary Language';

  @override
  String get languageVietnamese => 'Tiếng Việt';

  @override
  String get languageEnglish => 'English';

  @override
  String get signOut => 'Sign Out';

  @override
  String get profile => 'Profile';

  @override
  String get home => 'Home';

  @override
  String get progress => 'Progress';

  @override
  String get completed => 'Completed';

  @override
  String get continueBtn => 'Continue';

  @override
  String get back => 'Back';

  @override
  String get roadmap => 'Learning Path';

  @override
  String get loading => 'Loading...';

  @override
  String get error => 'Error';

  @override
  String get retry => 'Retry';
}
