import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
    Locale('ar'),
    Locale('en')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Daily Muslim Routine - Kids'**
  String get appTitle;

  /// The subtitle of the application
  ///
  /// In en, this message translates to:
  /// **'Daily Muslim Routine - Kids'**
  String get appSubtitle;

  /// No description provided for @appTitleBilingual.
  ///
  /// In en, this message translates to:
  /// **'Daily Muslim Routine - Kids'**
  String get appTitleBilingual;

  /// The description of the application
  ///
  /// In en, this message translates to:
  /// **'Learn prayers and Quran for kids'**
  String get appDescription;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get noData;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @trackYourPractices.
  ///
  /// In en, this message translates to:
  /// **'Learn prayers and Quran'**
  String get trackYourPractices;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @signInToContinue.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue your learning journey'**
  String get signInToContinue;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @welcomeToApp.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Daily Muslim Routine - Kids!'**
  String get welcomeToApp;

  /// No description provided for @setupLocationDesc.
  ///
  /// In en, this message translates to:
  /// **'Let\'s set up your location to get accurate prayer times'**
  String get setupLocationDesc;

  /// No description provided for @detectMyLocation.
  ///
  /// In en, this message translates to:
  /// **'Detect My Location'**
  String get detectMyLocation;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// No description provided for @enterYourCity.
  ///
  /// In en, this message translates to:
  /// **'Enter your city name'**
  String get enterYourCity;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @unableToAccessLocation.
  ///
  /// In en, this message translates to:
  /// **'Unable to access location'**
  String get unableToAccessLocation;

  /// No description provided for @unableToDetermineCity.
  ///
  /// In en, this message translates to:
  /// **'Unable to determine city'**
  String get unableToDetermineCity;

  /// No description provided for @pleaseEnterCityName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your city name'**
  String get pleaseEnterCityName;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @beginYourDailyRoutine.
  ///
  /// In en, this message translates to:
  /// **'Begin your learning journey'**
  String get beginYourDailyRoutine;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @signInButton.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInButton;

  /// No description provided for @pleaseEnterName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get pleaseEnterName;

  /// No description provided for @pleaseEnterEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get pleaseEnterEmail;

  /// No description provided for @pleaseEnterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get pleaseEnterValidEmail;

  /// No description provided for @pleaseEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get pleaseEnterPassword;

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordMinLength;

  /// No description provided for @pleaseConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get pleaseConfirmPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @passwordsDontMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords don\'t match'**
  String get passwordsDontMatch;

  /// No description provided for @dailyRoutine.
  ///
  /// In en, this message translates to:
  /// **'Daily Prayers'**
  String get dailyRoutine;

  /// No description provided for @quranKareem.
  ///
  /// In en, this message translates to:
  /// **'Holy Quran'**
  String get quranKareem;

  /// No description provided for @dailyRoutineDescription.
  ///
  /// In en, this message translates to:
  /// **'Learn the five daily prayers and dhikr'**
  String get dailyRoutineDescription;

  /// No description provided for @quranDescription.
  ///
  /// In en, this message translates to:
  /// **'Learn Juz Amma with beautiful surahs'**
  String get quranDescription;

  /// No description provided for @fajr.
  ///
  /// In en, this message translates to:
  /// **'Fajr'**
  String get fajr;

  /// No description provided for @dhuhr.
  ///
  /// In en, this message translates to:
  /// **'Dhuhr'**
  String get dhuhr;

  /// No description provided for @asr.
  ///
  /// In en, this message translates to:
  /// **'Asr'**
  String get asr;

  /// No description provided for @maghrib.
  ///
  /// In en, this message translates to:
  /// **'Maghrib'**
  String get maghrib;

  /// No description provided for @isha.
  ///
  /// In en, this message translates to:
  /// **'Isha'**
  String get isha;

  /// No description provided for @prayerTime.
  ///
  /// In en, this message translates to:
  /// **'Prayer Time'**
  String get prayerTime;

  /// No description provided for @prayedOnTime.
  ///
  /// In en, this message translates to:
  /// **'Prayed on time'**
  String get prayedOnTime;

  /// No description provided for @inMosque.
  ///
  /// In en, this message translates to:
  /// **'In mosque'**
  String get inMosque;

  /// No description provided for @prayedOutOfTime.
  ///
  /// In en, this message translates to:
  /// **'Prayed out of time'**
  String get prayedOutOfTime;

  /// No description provided for @nextPrayer.
  ///
  /// In en, this message translates to:
  /// **'Next Prayer'**
  String get nextPrayer;

  /// No description provided for @prayerReminder.
  ///
  /// In en, this message translates to:
  /// **'Prayer Reminder'**
  String get prayerReminder;

  /// No description provided for @morningAzkar.
  ///
  /// In en, this message translates to:
  /// **'Morning Azkar'**
  String get morningAzkar;

  /// No description provided for @eveningAzkar.
  ///
  /// In en, this message translates to:
  /// **'Evening Azkar'**
  String get eveningAzkar;

  /// No description provided for @dailyAzkar.
  ///
  /// In en, this message translates to:
  /// **'Daily Azkar'**
  String get dailyAzkar;

  /// No description provided for @tasbih.
  ///
  /// In en, this message translates to:
  /// **'Tasbih (100x)'**
  String get tasbih;

  /// No description provided for @istighfar.
  ///
  /// In en, this message translates to:
  /// **'Istighfar (100x)'**
  String get istighfar;

  /// No description provided for @salatAlaNabi.
  ///
  /// In en, this message translates to:
  /// **'Salat ala Nabi (100x)'**
  String get salatAlaNabi;

  /// No description provided for @subhanAllah.
  ///
  /// In en, this message translates to:
  /// **'Subhan Allah (100x)'**
  String get subhanAllah;

  /// No description provided for @alhamdulillah.
  ///
  /// In en, this message translates to:
  /// **'Alhamdulillah (100x)'**
  String get alhamdulillah;

  /// No description provided for @allahuAkbar.
  ///
  /// In en, this message translates to:
  /// **'Allahu Akbar (100x)'**
  String get allahuAkbar;

  /// No description provided for @quranReading.
  ///
  /// In en, this message translates to:
  /// **'Quran Reading'**
  String get quranReading;

  /// No description provided for @quranListening.
  ///
  /// In en, this message translates to:
  /// **'Quran Listening'**
  String get quranListening;

  /// No description provided for @sunnahPrayers.
  ///
  /// In en, this message translates to:
  /// **'Sunnah Prayers'**
  String get sunnahPrayers;

  /// No description provided for @duha.
  ///
  /// In en, this message translates to:
  /// **'Duha Prayer'**
  String get duha;

  /// No description provided for @qiyam.
  ///
  /// In en, this message translates to:
  /// **'Qiyam al-Layl'**
  String get qiyam;

  /// No description provided for @duhaDescription.
  ///
  /// In en, this message translates to:
  /// **'Morning prayer after sunrise'**
  String get duhaDescription;

  /// No description provided for @qiyamDescription.
  ///
  /// In en, this message translates to:
  /// **'Night prayer before Fajr'**
  String get qiyamDescription;

  /// No description provided for @quranMemorization.
  ///
  /// In en, this message translates to:
  /// **'Quran Memorization'**
  String get quranMemorization;

  /// No description provided for @juzAmma.
  ///
  /// In en, this message translates to:
  /// **'Juz Amma'**
  String get juzAmma;

  /// No description provided for @memorized.
  ///
  /// In en, this message translates to:
  /// **'Memorized'**
  String get memorized;

  /// No description provided for @notMemorized.
  ///
  /// In en, this message translates to:
  /// **'Not memorized'**
  String get notMemorized;

  /// No description provided for @memorizationProgress.
  ///
  /// In en, this message translates to:
  /// **'Memorization Progress'**
  String get memorizationProgress;

  /// No description provided for @surahNumber.
  ///
  /// In en, this message translates to:
  /// **'Surah {number}'**
  String surahNumber(Object number);

  /// No description provided for @verseCount.
  ///
  /// In en, this message translates to:
  /// **'{count} verses'**
  String verseCount(Object count);

  /// No description provided for @meccan.
  ///
  /// In en, this message translates to:
  /// **'Meccan'**
  String get meccan;

  /// No description provided for @medinan.
  ///
  /// In en, this message translates to:
  /// **'Medinan'**
  String get medinan;

  /// No description provided for @totalScore.
  ///
  /// In en, this message translates to:
  /// **'Total Score'**
  String get totalScore;

  /// No description provided for @fardScore.
  ///
  /// In en, this message translates to:
  /// **'Fard Score'**
  String get fardScore;

  /// No description provided for @sunnahScore.
  ///
  /// In en, this message translates to:
  /// **'Sunnah Score'**
  String get sunnahScore;

  /// No description provided for @wirdScore.
  ///
  /// In en, this message translates to:
  /// **'Wird Score'**
  String get wirdScore;

  /// No description provided for @points.
  ///
  /// In en, this message translates to:
  /// **'points'**
  String get points;

  /// No description provided for @percentage.
  ///
  /// In en, this message translates to:
  /// **'percentage'**
  String get percentage;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'1.0.0'**
  String get appVersion;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'A kids\' app for learning Islamic practices'**
  String get aboutApp;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @notSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get notSet;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @languageChanged.
  ///
  /// In en, this message translates to:
  /// **'Language changed'**
  String get languageChanged;

  /// No description provided for @changeLocation.
  ///
  /// In en, this message translates to:
  /// **'Change Location'**
  String get changeLocation;

  /// No description provided for @cityName.
  ///
  /// In en, this message translates to:
  /// **'City Name'**
  String get cityName;

  /// No description provided for @locationUpdated.
  ///
  /// In en, this message translates to:
  /// **'Location updated'**
  String get locationUpdated;

  /// No description provided for @clearAllData.
  ///
  /// In en, this message translates to:
  /// **'Clear All Data'**
  String get clearAllData;

  /// No description provided for @clearAllDataQuestion.
  ///
  /// In en, this message translates to:
  /// **'Clear All Data?'**
  String get clearAllDataQuestion;

  /// No description provided for @clearDataWarningAuth.
  ///
  /// In en, this message translates to:
  /// **'This will clear all your local data. Your cloud data will remain safe.'**
  String get clearDataWarningAuth;

  /// No description provided for @clearDataWarningNoAuth.
  ///
  /// In en, this message translates to:
  /// **'This will clear all your local data.'**
  String get clearDataWarningNoAuth;

  /// No description provided for @localDataCleared.
  ///
  /// In en, this message translates to:
  /// **'Local data cleared'**
  String get localDataCleared;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @accountInformation.
  ///
  /// In en, this message translates to:
  /// **'Account Information'**
  String get accountInformation;

  /// No description provided for @displayNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Display Name'**
  String get displayNameLabel;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @memberSince.
  ///
  /// In en, this message translates to:
  /// **'Member Since'**
  String get memberSince;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @areYouSureLogout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get areYouSureLogout;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @deleteAccountWarning.
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete your account and all data. This action cannot be undone.'**
  String get deleteAccountWarning;

  /// No description provided for @profileUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdatedSuccessfully;

  /// No description provided for @failedToUpdateProfile.
  ///
  /// In en, this message translates to:
  /// **'Failed to update profile'**
  String get failedToUpdateProfile;

  /// No description provided for @noUserDataAvailable.
  ///
  /// In en, this message translates to:
  /// **'No user data available'**
  String get noUserDataAvailable;

  /// No description provided for @pleaseEnterEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email address'**
  String get pleaseEnterEmailAddress;

  /// No description provided for @passwordResetEmailSent.
  ///
  /// In en, this message translates to:
  /// **'Password reset email sent'**
  String get passwordResetEmailSent;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @networkError.
  ///
  /// In en, this message translates to:
  /// **'Network error. Please check your connection.'**
  String get networkError;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred'**
  String get unknownError;

  /// No description provided for @dontHaveAccountQuestion.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccountQuestion;

  /// No description provided for @alreadyHaveAccountQuestion.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccountQuestion;

  /// No description provided for @authenticating.
  ///
  /// In en, this message translates to:
  /// **'Authenticating...'**
  String get authenticating;

  /// No description provided for @restoringYourData.
  ///
  /// In en, this message translates to:
  /// **'Restoring your data...'**
  String get restoringYourData;

  /// No description provided for @savingDataLocally.
  ///
  /// In en, this message translates to:
  /// **'Saving data locally...'**
  String get savingDataLocally;

  /// No description provided for @updatingProfile.
  ///
  /// In en, this message translates to:
  /// **'Updating profile...'**
  String get updatingProfile;

  /// No description provided for @dataRestoredSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Data restored successfully'**
  String get dataRestoredSuccessfully;

  /// No description provided for @failedToRestoreData.
  ///
  /// In en, this message translates to:
  /// **'Failed to restore data'**
  String get failedToRestoreData;

  /// No description provided for @prayerTimeTitle.
  ///
  /// In en, this message translates to:
  /// **'Prayer Time'**
  String get prayerTimeTitle;

  /// No description provided for @prayerTimeBody.
  ///
  /// In en, this message translates to:
  /// **'It\'s time for {prayer} prayer'**
  String prayerTimeBody(Object prayer);

  /// No description provided for @prayerReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Prayer Reminder'**
  String get prayerReminderTitle;

  /// No description provided for @prayerReminderBody.
  ///
  /// In en, this message translates to:
  /// **'Have you prayed {prayer}?'**
  String prayerReminderBody(Object prayer);

  /// No description provided for @prayerNotificationsChannel.
  ///
  /// In en, this message translates to:
  /// **'Prayer Notifications'**
  String get prayerNotificationsChannel;

  /// No description provided for @prayerNotificationsDescription.
  ///
  /// In en, this message translates to:
  /// **'Notifications for prayer times'**
  String get prayerNotificationsDescription;

  /// No description provided for @instantNotificationsChannel.
  ///
  /// In en, this message translates to:
  /// **'Instant Notifications'**
  String get instantNotificationsChannel;

  /// No description provided for @instantNotificationsDescription.
  ///
  /// In en, this message translates to:
  /// **'Instant notifications'**
  String get instantNotificationsDescription;

  /// No description provided for @dateFormat.
  ///
  /// In en, this message translates to:
  /// **'MMM d, y'**
  String get dateFormat;

  /// No description provided for @detailedDateFormat.
  ///
  /// In en, this message translates to:
  /// **'EEEE, MMMM d, y'**
  String get detailedDateFormat;

  /// No description provided for @shortDateFormat.
  ///
  /// In en, this message translates to:
  /// **'MMM d'**
  String get shortDateFormat;

  /// No description provided for @historyAndReports.
  ///
  /// In en, this message translates to:
  /// **'History & Reports'**
  String get historyAndReports;

  /// No description provided for @verses.
  ///
  /// In en, this message translates to:
  /// **'verses'**
  String get verses;

  /// No description provided for @egyptianPound.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get egyptianPound;

  /// No description provided for @monthlyProgress.
  ///
  /// In en, this message translates to:
  /// **'Monthly Progress'**
  String get monthlyProgress;

  /// No description provided for @dailyTarget.
  ///
  /// In en, this message translates to:
  /// **'Daily Target'**
  String get dailyTarget;

  /// No description provided for @khatmahProgress.
  ///
  /// In en, this message translates to:
  /// **'Khatmah Progress'**
  String get khatmahProgress;

  /// No description provided for @tahmid.
  ///
  /// In en, this message translates to:
  /// **'Tahmid (100x)'**
  String get tahmid;

  /// No description provided for @laIlahaIllaAllah.
  ///
  /// In en, this message translates to:
  /// **'La Ilaha Illa Allah (100x)'**
  String get laIlahaIllaAllah;

  /// No description provided for @takbir.
  ///
  /// In en, this message translates to:
  /// **'Takbir (100x)'**
  String get takbir;

  /// No description provided for @laHawlaWaLaQuwwata.
  ///
  /// In en, this message translates to:
  /// **'La Hawla Wa La Quwwata (100x)'**
  String get laHawlaWaLaQuwwata;

  /// No description provided for @morningAzkarDescription.
  ///
  /// In en, this message translates to:
  /// **'Morning remembrance'**
  String get morningAzkarDescription;

  /// No description provided for @eveningAzkarDescription.
  ///
  /// In en, this message translates to:
  /// **'Evening remembrance'**
  String get eveningAzkarDescription;

  /// No description provided for @quranReadingDescription.
  ///
  /// In en, this message translates to:
  /// **'Daily Quran reading'**
  String get quranReadingDescription;

  /// No description provided for @quranListeningDescription.
  ///
  /// In en, this message translates to:
  /// **'Daily Quran listening'**
  String get quranListeningDescription;

  /// No description provided for @istighfarDescription.
  ///
  /// In en, this message translates to:
  /// **'Seeking forgiveness'**
  String get istighfarDescription;

  /// No description provided for @salatAlaNabiDescription.
  ///
  /// In en, this message translates to:
  /// **'Praying for the Prophet'**
  String get salatAlaNabiDescription;

  /// No description provided for @tasbihDescription.
  ///
  /// In en, this message translates to:
  /// **'Glorifying Allah'**
  String get tasbihDescription;

  /// No description provided for @tahmidDescription.
  ///
  /// In en, this message translates to:
  /// **'Praising Allah'**
  String get tahmidDescription;

  /// No description provided for @laIlahaIllaAllahDescription.
  ///
  /// In en, this message translates to:
  /// **'Declaring faith'**
  String get laIlahaIllaAllahDescription;

  /// No description provided for @takbirDescription.
  ///
  /// In en, this message translates to:
  /// **'Declaring greatness'**
  String get takbirDescription;

  /// No description provided for @laHawlaWaLaQuwwataDescription.
  ///
  /// In en, this message translates to:
  /// **'Seeking strength'**
  String get laHawlaWaLaQuwwataDescription;

  /// No description provided for @salatAlDuha.
  ///
  /// In en, this message translates to:
  /// **'Salat al-Duha'**
  String get salatAlDuha;

  /// No description provided for @qiyamAlLayl.
  ///
  /// In en, this message translates to:
  /// **'Qiyam al-Layl'**
  String get qiyamAlLayl;

  /// No description provided for @salatAlDuhaDescription.
  ///
  /// In en, this message translates to:
  /// **'Morning prayer after sunrise'**
  String get salatAlDuhaDescription;

  /// No description provided for @qiyamAlLaylDescription.
  ///
  /// In en, this message translates to:
  /// **'Night prayer before Fajr'**
  String get qiyamAlLaylDescription;

  /// No description provided for @fard.
  ///
  /// In en, this message translates to:
  /// **'Fard'**
  String get fard;

  /// No description provided for @sunnah.
  ///
  /// In en, this message translates to:
  /// **'Sunnah'**
  String get sunnah;

  /// No description provided for @wird.
  ///
  /// In en, this message translates to:
  /// **'Wird'**
  String get wird;

  /// No description provided for @sadaqat.
  ///
  /// In en, this message translates to:
  /// **'Sadaqat'**
  String get sadaqat;

  /// No description provided for @muhasabatAlNafsTracker.
  ///
  /// In en, this message translates to:
  /// **'Self-Accountability'**
  String get muhasabatAlNafsTracker;

  /// No description provided for @mandatory.
  ///
  /// In en, this message translates to:
  /// **'Mandatory'**
  String get mandatory;

  /// No description provided for @recommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get recommended;

  /// No description provided for @dailyDevotion.
  ///
  /// In en, this message translates to:
  /// **'Daily Devotion'**
  String get dailyDevotion;

  /// No description provided for @charity.
  ///
  /// In en, this message translates to:
  /// **'Charity'**
  String get charity;

  /// No description provided for @selfAccountability.
  ///
  /// In en, this message translates to:
  /// **'Self-Accountability'**
  String get selfAccountability;
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
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
