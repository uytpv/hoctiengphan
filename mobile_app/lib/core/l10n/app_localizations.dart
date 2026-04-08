import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fi.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fi'),
    Locale('vi')
  ];

  /// App name
  ///
  /// In fi, this message translates to:
  /// **'Opi Suomea'**
  String get appName;

  /// Login screen title
  ///
  /// In fi, this message translates to:
  /// **'Kirjaudu sisään'**
  String get loginTitle;

  /// Login screen subtitle
  ///
  /// In fi, this message translates to:
  /// **'Jatka oppimista'**
  String get loginSubtitle;

  /// Google sign-in button
  ///
  /// In fi, this message translates to:
  /// **'Jatka Googlella'**
  String get loginWithGoogle;

  /// Study plans screen title
  ///
  /// In fi, this message translates to:
  /// **'Opiskelusuunnitelmat'**
  String get studyPlans;

  /// Weeks label
  ///
  /// In fi, this message translates to:
  /// **'Viikkoa'**
  String get weeks;

  /// Week singular
  ///
  /// In fi, this message translates to:
  /// **'Viikko'**
  String get week;

  /// Days label
  ///
  /// In fi, this message translates to:
  /// **'Päivää'**
  String get days;

  /// Day singular
  ///
  /// In fi, this message translates to:
  /// **'Päivä'**
  String get day;

  /// Activities label
  ///
  /// In fi, this message translates to:
  /// **'Harjoitusta'**
  String get activities;

  /// Lesson
  ///
  /// In fi, this message translates to:
  /// **'Oppitunti'**
  String get lesson;

  /// Exercise
  ///
  /// In fi, this message translates to:
  /// **'Harjoitus'**
  String get exercise;

  /// Grammar
  ///
  /// In fi, this message translates to:
  /// **'Kielioppi'**
  String get grammar;

  /// Vocabulary
  ///
  /// In fi, this message translates to:
  /// **'Sanasto'**
  String get vocabulary;

  /// Mark as done button
  ///
  /// In fi, this message translates to:
  /// **'Merkitse valmiiksi'**
  String get markAsDone;

  /// Lesson completed message
  ///
  /// In fi, this message translates to:
  /// **'Oppitunti suoritettu!'**
  String get lessonCompleted;

  /// Submit exercise button
  ///
  /// In fi, this message translates to:
  /// **'Lähetä vastaukset'**
  String get submitExercise;

  /// Retry exercise button
  ///
  /// In fi, this message translates to:
  /// **'Yritä uudelleen'**
  String get retryExercise;

  /// Complete exercise button
  ///
  /// In fi, this message translates to:
  /// **'Merkitse valmiiksi'**
  String get completeExercise;

  /// Exercise result title
  ///
  /// In fi, this message translates to:
  /// **'Tulos'**
  String get exerciseResult;

  /// Score label
  ///
  /// In fi, this message translates to:
  /// **'Pisteet'**
  String get score;

  /// Correct answers count
  ///
  /// In fi, this message translates to:
  /// **'{correct}/{total} oikein'**
  String correctAnswers(int correct, int total);

  /// Done status
  ///
  /// In fi, this message translates to:
  /// **'Valmis'**
  String get done;

  /// In progress status
  ///
  /// In fi, this message translates to:
  /// **'Kesken'**
  String get inProgress;

  /// Todo status
  ///
  /// In fi, this message translates to:
  /// **'Tekemättä'**
  String get todo;

  /// Settings title
  ///
  /// In fi, this message translates to:
  /// **'Asetukset'**
  String get settings;

  /// Secondary language label
  ///
  /// In fi, this message translates to:
  /// **'Toinen kieli'**
  String get secondaryLanguage;

  /// Vietnamese language option
  ///
  /// In fi, this message translates to:
  /// **'Tiếng Việt'**
  String get languageVietnamese;

  /// English language option
  ///
  /// In fi, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// Sign out button
  ///
  /// In fi, this message translates to:
  /// **'Kirjaudu ulos'**
  String get signOut;

  /// Profile label
  ///
  /// In fi, this message translates to:
  /// **'Profiili'**
  String get profile;

  /// Home tab
  ///
  /// In fi, this message translates to:
  /// **'Koti'**
  String get home;

  /// Progress tab
  ///
  /// In fi, this message translates to:
  /// **'Edistyminen'**
  String get progress;

  /// Completed label
  ///
  /// In fi, this message translates to:
  /// **'Suoritettu'**
  String get completed;

  /// Continue button
  ///
  /// In fi, this message translates to:
  /// **'Jatka'**
  String get continueBtn;

  /// Back button
  ///
  /// In fi, this message translates to:
  /// **'Takaisin'**
  String get back;

  /// Roadmap/learning path
  ///
  /// In fi, this message translates to:
  /// **'Oppimispolku'**
  String get roadmap;

  /// Loading message
  ///
  /// In fi, this message translates to:
  /// **'Ladataan...'**
  String get loading;

  /// Error label
  ///
  /// In fi, this message translates to:
  /// **'Virhe'**
  String get error;

  /// Retry button
  ///
  /// In fi, this message translates to:
  /// **'Yritä uudelleen'**
  String get retry;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fi', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fi':
      return AppLocalizationsFi();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
