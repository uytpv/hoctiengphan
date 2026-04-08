// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get appName => 'Opi Suomea';

  @override
  String get loginTitle => 'Kirjaudu sisään';

  @override
  String get loginSubtitle => 'Jatka oppimista';

  @override
  String get loginWithGoogle => 'Jatka Googlella';

  @override
  String get studyPlans => 'Opiskelusuunnitelmat';

  @override
  String get weeks => 'Viikkoa';

  @override
  String get week => 'Viikko';

  @override
  String get days => 'Päivää';

  @override
  String get day => 'Päivä';

  @override
  String get activities => 'Harjoitusta';

  @override
  String get lesson => 'Oppitunti';

  @override
  String get exercise => 'Harjoitus';

  @override
  String get grammar => 'Kielioppi';

  @override
  String get vocabulary => 'Sanasto';

  @override
  String get markAsDone => 'Merkitse valmiiksi';

  @override
  String get lessonCompleted => 'Oppitunti suoritettu!';

  @override
  String get submitExercise => 'Lähetä vastaukset';

  @override
  String get retryExercise => 'Yritä uudelleen';

  @override
  String get completeExercise => 'Merkitse valmiiksi';

  @override
  String get exerciseResult => 'Tulos';

  @override
  String get score => 'Pisteet';

  @override
  String correctAnswers(int correct, int total) {
    return '$correct/$total oikein';
  }

  @override
  String get done => 'Valmis';

  @override
  String get inProgress => 'Kesken';

  @override
  String get todo => 'Tekemättä';

  @override
  String get settings => 'Asetukset';

  @override
  String get secondaryLanguage => 'Toinen kieli';

  @override
  String get languageVietnamese => 'Tiếng Việt';

  @override
  String get languageEnglish => 'English';

  @override
  String get signOut => 'Kirjaudu ulos';

  @override
  String get profile => 'Profiili';

  @override
  String get home => 'Koti';

  @override
  String get progress => 'Edistyminen';

  @override
  String get completed => 'Suoritettu';

  @override
  String get continueBtn => 'Jatka';

  @override
  String get back => 'Takaisin';

  @override
  String get roadmap => 'Oppimispolku';

  @override
  String get loading => 'Ladataan...';

  @override
  String get error => 'Virhe';

  @override
  String get retry => 'Yritä uudelleen';
}
