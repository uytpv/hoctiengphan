// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appName => 'Học Tiếng Phần Lan';

  @override
  String get loginTitle => 'Đăng nhập';

  @override
  String get loginSubtitle => 'Tiếp tục học tập';

  @override
  String get loginWithGoogle => 'Tiếp tục với Google';

  @override
  String get studyPlans => 'Kế hoạch học tập';

  @override
  String get weeks => 'Tuần';

  @override
  String get week => 'Tuần';

  @override
  String get days => 'Ngày';

  @override
  String get day => 'Ngày';

  @override
  String get activities => 'Hoạt động';

  @override
  String get lesson => 'Bài học';

  @override
  String get exercise => 'Bài tập';

  @override
  String get grammar => 'Ngữ pháp';

  @override
  String get vocabulary => 'Từ vựng';

  @override
  String get markAsDone => 'Đã học xong';

  @override
  String get lessonCompleted => 'Hoàn thành bài học!';

  @override
  String get submitExercise => 'Nộp bài';

  @override
  String get retryExercise => 'Làm lại';

  @override
  String get completeExercise => 'Hoàn thành bài tập';

  @override
  String get exerciseResult => 'Kết quả';

  @override
  String get score => 'Điểm số';

  @override
  String correctAnswers(int correct, int total) {
    return '$correct/$total câu đúng';
  }

  @override
  String get done => 'Hoàn thành';

  @override
  String get inProgress => 'Đang làm';

  @override
  String get todo => 'Chưa làm';

  @override
  String get settings => 'Cài đặt';

  @override
  String get secondaryLanguage => 'Ngôn ngữ thứ hai';

  @override
  String get languageVietnamese => 'Tiếng Việt';

  @override
  String get languageEnglish => 'English';

  @override
  String get signOut => 'Đăng xuất';

  @override
  String get profile => 'Hồ sơ';

  @override
  String get home => 'Trang chủ';

  @override
  String get progress => 'Tiến độ';

  @override
  String get completed => 'Đã hoàn thành';

  @override
  String get continueBtn => 'Tiếp tục';

  @override
  String get back => 'Quay lại';

  @override
  String get roadmap => 'Lộ trình học';

  @override
  String get loading => 'Đang tải...';

  @override
  String get error => 'Lỗi';

  @override
  String get retry => 'Thử lại';
}
