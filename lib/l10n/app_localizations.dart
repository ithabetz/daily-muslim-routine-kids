import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';

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
  static const List<Locale> supportedLocales = <Locale>[Locale('ar')];

  /// The title of the application
  ///
  /// In ar, this message translates to:
  /// **'الروتين الإسلامي اليومي - للأطفال'**
  String get appTitle;

  /// No description provided for @ok.
  ///
  /// In ar, this message translates to:
  /// **'موافق'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In ar, this message translates to:
  /// **'حفظ'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In ar, this message translates to:
  /// **'حذف'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In ar, this message translates to:
  /// **'تعديل'**
  String get edit;

  /// No description provided for @clear.
  ///
  /// In ar, this message translates to:
  /// **'مسح'**
  String get clear;

  /// No description provided for @refresh.
  ///
  /// In ar, this message translates to:
  /// **'تحديث'**
  String get refresh;

  /// No description provided for @loading.
  ///
  /// In ar, this message translates to:
  /// **'جاري التحميل...'**
  String get loading;

  /// No description provided for @noData.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد بيانات متاحة'**
  String get noData;

  /// No description provided for @error.
  ///
  /// In ar, this message translates to:
  /// **'خطأ'**
  String get error;

  /// No description provided for @success.
  ///
  /// In ar, this message translates to:
  /// **'نجح'**
  String get success;

  /// No description provided for @yes.
  ///
  /// In ar, this message translates to:
  /// **'نعم'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In ar, this message translates to:
  /// **'لا'**
  String get no;

  /// No description provided for @welcomeBack.
  ///
  /// In ar, this message translates to:
  /// **'مرحباً بعودتك'**
  String get welcomeBack;

  /// No description provided for @signInToContinue.
  ///
  /// In ar, this message translates to:
  /// **'سجل دخولك لمواصلة رحلتك التعليمية'**
  String get signInToContinue;

  /// No description provided for @email.
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني'**
  String get email;

  /// No description provided for @password.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور'**
  String get password;

  /// No description provided for @forgotPassword.
  ///
  /// In ar, this message translates to:
  /// **'نسيت كلمة المرور؟'**
  String get forgotPassword;

  /// No description provided for @signIn.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get signIn;

  /// No description provided for @dontHaveAccount.
  ///
  /// In ar, this message translates to:
  /// **'ليس لديك حساب؟'**
  String get dontHaveAccount;

  /// No description provided for @signUp.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء حساب'**
  String get signUp;

  /// No description provided for @welcomeToApp.
  ///
  /// In ar, this message translates to:
  /// **'مرحباً بك في الروتين الإسلامي اليومي - للأطفال!'**
  String get welcomeToApp;

  /// No description provided for @setupLocationDesc.
  ///
  /// In ar, this message translates to:
  /// **'دعنا نحدد موقعك للحصول على أوقات الصلاة الدقيقة'**
  String get setupLocationDesc;

  /// No description provided for @detectMyLocation.
  ///
  /// In ar, this message translates to:
  /// **'تحديد موقعي'**
  String get detectMyLocation;

  /// No description provided for @or.
  ///
  /// In ar, this message translates to:
  /// **'أو'**
  String get or;

  /// No description provided for @enterYourCity.
  ///
  /// In ar, this message translates to:
  /// **'أدخل اسم مدينتك'**
  String get enterYourCity;

  /// No description provided for @continueButton.
  ///
  /// In ar, this message translates to:
  /// **'متابعة'**
  String get continueButton;

  /// No description provided for @unableToAccessLocation.
  ///
  /// In ar, this message translates to:
  /// **'غير قادر على الوصول للموقع'**
  String get unableToAccessLocation;

  /// No description provided for @unableToDetermineCity.
  ///
  /// In ar, this message translates to:
  /// **'غير قادر على تحديد المدينة'**
  String get unableToDetermineCity;

  /// No description provided for @pleaseEnterCityName.
  ///
  /// In ar, this message translates to:
  /// **'يرجى إدخال اسم مدينتك'**
  String get pleaseEnterCityName;

  /// No description provided for @createAccount.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء حساب'**
  String get createAccount;

  /// No description provided for @beginYourDailyRoutine.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ رحلتك التعليمية'**
  String get beginYourDailyRoutine;

  /// No description provided for @fullName.
  ///
  /// In ar, this message translates to:
  /// **'الاسم الكامل'**
  String get fullName;

  /// No description provided for @confirmPassword.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد كلمة المرور'**
  String get confirmPassword;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In ar, this message translates to:
  /// **'لديك حساب بالفعل؟'**
  String get alreadyHaveAccount;

  /// No description provided for @signInButton.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get signInButton;

  /// No description provided for @pleaseEnterName.
  ///
  /// In ar, this message translates to:
  /// **'يرجى إدخال اسمك'**
  String get pleaseEnterName;

  /// No description provided for @pleaseEnterEmail.
  ///
  /// In ar, this message translates to:
  /// **'يرجى إدخال بريدك الإلكتروني'**
  String get pleaseEnterEmail;

  /// No description provided for @pleaseEnterValidEmail.
  ///
  /// In ar, this message translates to:
  /// **'يرجى إدخال بريد إلكتروني صحيح'**
  String get pleaseEnterValidEmail;

  /// No description provided for @pleaseEnterPassword.
  ///
  /// In ar, this message translates to:
  /// **'يرجى إدخال كلمة المرور'**
  String get pleaseEnterPassword;

  /// No description provided for @passwordMinLength.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور يجب أن تكون 6 أحرف على الأقل'**
  String get passwordMinLength;

  /// No description provided for @pleaseConfirmPassword.
  ///
  /// In ar, this message translates to:
  /// **'يرجى تأكيد كلمة المرور'**
  String get pleaseConfirmPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In ar, this message translates to:
  /// **'كلمات المرور غير متطابقة'**
  String get passwordsDoNotMatch;

  /// No description provided for @passwordsDontMatch.
  ///
  /// In ar, this message translates to:
  /// **'كلمات المرور غير متطابقة'**
  String get passwordsDontMatch;

  /// No description provided for @gender.
  ///
  /// In ar, this message translates to:
  /// **'الجنس'**
  String get gender;

  /// No description provided for @male.
  ///
  /// In ar, this message translates to:
  /// **'ولد'**
  String get male;

  /// No description provided for @female.
  ///
  /// In ar, this message translates to:
  /// **'بنت'**
  String get female;

  /// No description provided for @pleaseSelectGender.
  ///
  /// In ar, this message translates to:
  /// **'يرجى اختيار الجنس'**
  String get pleaseSelectGender;

  /// No description provided for @dailyRoutine.
  ///
  /// In ar, this message translates to:
  /// **'صلوات اليومية'**
  String get dailyRoutine;

  /// No description provided for @quranKareem.
  ///
  /// In ar, this message translates to:
  /// **'قرآن الكريم'**
  String get quranKareem;

  /// No description provided for @dailyRoutineDescription.
  ///
  /// In ar, this message translates to:
  /// **'تعلم الصلوات الخمس اليومية والأذكار'**
  String get dailyRoutineDescription;

  /// No description provided for @quranDescription.
  ///
  /// In ar, this message translates to:
  /// **'تعلم جزء عم مع السور الجميلة'**
  String get quranDescription;

  /// No description provided for @fajr.
  ///
  /// In ar, this message translates to:
  /// **'الفجر'**
  String get fajr;

  /// No description provided for @dhuhr.
  ///
  /// In ar, this message translates to:
  /// **'الظهر'**
  String get dhuhr;

  /// No description provided for @asr.
  ///
  /// In ar, this message translates to:
  /// **'العصر'**
  String get asr;

  /// No description provided for @maghrib.
  ///
  /// In ar, this message translates to:
  /// **'المغرب'**
  String get maghrib;

  /// No description provided for @isha.
  ///
  /// In ar, this message translates to:
  /// **'العشاء'**
  String get isha;

  /// No description provided for @prayedOnTime.
  ///
  /// In ar, this message translates to:
  /// **'صليت في الوقت'**
  String get prayedOnTime;

  /// No description provided for @inMosque.
  ///
  /// In ar, this message translates to:
  /// **'في المسجد'**
  String get inMosque;

  /// No description provided for @prayedOutOfTime.
  ///
  /// In ar, this message translates to:
  /// **'صليت خارج الوقت'**
  String get prayedOutOfTime;

  /// No description provided for @morningAzkar.
  ///
  /// In ar, this message translates to:
  /// **'أذكار الصباح'**
  String get morningAzkar;

  /// No description provided for @eveningAzkar.
  ///
  /// In ar, this message translates to:
  /// **'أذكار المساء'**
  String get eveningAzkar;

  /// No description provided for @tasbih.
  ///
  /// In ar, this message translates to:
  /// **'التسبيح (100 مرة)'**
  String get tasbih;

  /// No description provided for @istighfar.
  ///
  /// In ar, this message translates to:
  /// **'الاستغفار (100 مرة)'**
  String get istighfar;

  /// No description provided for @salatAlaNabi.
  ///
  /// In ar, this message translates to:
  /// **'الصلاة على النبي (100 مرة)'**
  String get salatAlaNabi;

  /// No description provided for @quranReading.
  ///
  /// In ar, this message translates to:
  /// **'قراءة القرآن'**
  String get quranReading;

  /// No description provided for @quranListening.
  ///
  /// In ar, this message translates to:
  /// **'الاستماع للقرآن'**
  String get quranListening;

  /// No description provided for @duha.
  ///
  /// In ar, this message translates to:
  /// **'صلاة الضحى'**
  String get duha;

  /// No description provided for @qiyam.
  ///
  /// In ar, this message translates to:
  /// **'قيام الليل'**
  String get qiyam;

  /// No description provided for @duhaDescription.
  ///
  /// In ar, this message translates to:
  /// **'صلاة الصباح بعد الشروق'**
  String get duhaDescription;

  /// No description provided for @qiyamDescription.
  ///
  /// In ar, this message translates to:
  /// **'صلاة الليل قبل الفجر'**
  String get qiyamDescription;

  /// No description provided for @memorized.
  ///
  /// In ar, this message translates to:
  /// **'محفوظة'**
  String get memorized;

  /// No description provided for @notMemorized.
  ///
  /// In ar, this message translates to:
  /// **'لم تحفظ'**
  String get notMemorized;

  /// No description provided for @meccan.
  ///
  /// In ar, this message translates to:
  /// **'مكية'**
  String get meccan;

  /// No description provided for @medinan.
  ///
  /// In ar, this message translates to:
  /// **'مدنية'**
  String get medinan;

  /// No description provided for @settings.
  ///
  /// In ar, this message translates to:
  /// **'الإعدادات'**
  String get settings;

  /// No description provided for @account.
  ///
  /// In ar, this message translates to:
  /// **'الحساب'**
  String get account;

  /// No description provided for @location.
  ///
  /// In ar, this message translates to:
  /// **'الموقع'**
  String get location;

  /// No description provided for @about.
  ///
  /// In ar, this message translates to:
  /// **'حول'**
  String get about;

  /// No description provided for @version.
  ///
  /// In ar, this message translates to:
  /// **'الإصدار'**
  String get version;

  /// No description provided for @appVersion.
  ///
  /// In ar, this message translates to:
  /// **'1.0.0'**
  String get appVersion;

  /// No description provided for @aboutApp.
  ///
  /// In ar, this message translates to:
  /// **'تطبيق للأطفال لتعلم الممارسات الإسلامية'**
  String get aboutApp;

  /// No description provided for @city.
  ///
  /// In ar, this message translates to:
  /// **'المدينة'**
  String get city;

  /// No description provided for @notSet.
  ///
  /// In ar, this message translates to:
  /// **'غير محدد'**
  String get notSet;

  /// No description provided for @changeLocation.
  ///
  /// In ar, this message translates to:
  /// **'تغيير الموقع'**
  String get changeLocation;

  /// No description provided for @cityName.
  ///
  /// In ar, this message translates to:
  /// **'اسم المدينة'**
  String get cityName;

  /// No description provided for @locationUpdated.
  ///
  /// In ar, this message translates to:
  /// **'تم تحديث الموقع'**
  String get locationUpdated;

  /// No description provided for @clearAllData.
  ///
  /// In ar, this message translates to:
  /// **'مسح جميع البيانات'**
  String get clearAllData;

  /// No description provided for @clearAllDataQuestion.
  ///
  /// In ar, this message translates to:
  /// **'مسح جميع البيانات؟'**
  String get clearAllDataQuestion;

  /// No description provided for @clearDataWarningAuth.
  ///
  /// In ar, this message translates to:
  /// **'سيتم مسح جميع البيانات المحلية. البيانات السحابية ستبقى آمنة.'**
  String get clearDataWarningAuth;

  /// No description provided for @clearDataWarningNoAuth.
  ///
  /// In ar, this message translates to:
  /// **'سيتم مسح جميع البيانات المحلية.'**
  String get clearDataWarningNoAuth;

  /// No description provided for @localDataCleared.
  ///
  /// In ar, this message translates to:
  /// **'تم مسح البيانات المحلية'**
  String get localDataCleared;

  /// No description provided for @profile.
  ///
  /// In ar, this message translates to:
  /// **'الملف الشخصي'**
  String get profile;

  /// No description provided for @user.
  ///
  /// In ar, this message translates to:
  /// **'المستخدم'**
  String get user;

  /// No description provided for @accountInformation.
  ///
  /// In ar, this message translates to:
  /// **'معلومات الحساب'**
  String get accountInformation;

  /// No description provided for @displayNameLabel.
  ///
  /// In ar, this message translates to:
  /// **'اسم العرض'**
  String get displayNameLabel;

  /// No description provided for @emailLabel.
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني'**
  String get emailLabel;

  /// No description provided for @memberSince.
  ///
  /// In ar, this message translates to:
  /// **'عضو منذ'**
  String get memberSince;

  /// No description provided for @logout.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج'**
  String get logout;

  /// No description provided for @areYouSureLogout.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد من تسجيل الخروج؟'**
  String get areYouSureLogout;

  /// No description provided for @deleteAccount.
  ///
  /// In ar, this message translates to:
  /// **'حذف الحساب'**
  String get deleteAccount;

  /// No description provided for @deleteAccountWarning.
  ///
  /// In ar, this message translates to:
  /// **'سيتم حذف حسابك وجميع البيانات نهائياً. لا يمكن التراجع عن هذا الإجراء.'**
  String get deleteAccountWarning;

  /// No description provided for @profileUpdatedSuccessfully.
  ///
  /// In ar, this message translates to:
  /// **'تم تحديث الملف الشخصي بنجاح'**
  String get profileUpdatedSuccessfully;

  /// No description provided for @failedToUpdateProfile.
  ///
  /// In ar, this message translates to:
  /// **'فشل في تحديث الملف الشخصي'**
  String get failedToUpdateProfile;

  /// No description provided for @noUserDataAvailable.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد بيانات مستخدم متاحة'**
  String get noUserDataAvailable;

  /// No description provided for @pleaseEnterEmailAddress.
  ///
  /// In ar, this message translates to:
  /// **'يرجى إدخال عنوان بريدك الإلكتروني'**
  String get pleaseEnterEmailAddress;

  /// No description provided for @passwordResetEmailSent.
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال بريد إعادة تعيين كلمة المرور'**
  String get passwordResetEmailSent;

  /// No description provided for @dontHaveAccountQuestion.
  ///
  /// In ar, this message translates to:
  /// **'ليس لديك حساب؟'**
  String get dontHaveAccountQuestion;

  /// No description provided for @alreadyHaveAccountQuestion.
  ///
  /// In ar, this message translates to:
  /// **'لديك حساب بالفعل؟'**
  String get alreadyHaveAccountQuestion;

  /// No description provided for @authenticating.
  ///
  /// In ar, this message translates to:
  /// **'جاري المصادقة...'**
  String get authenticating;

  /// No description provided for @restoringYourData.
  ///
  /// In ar, this message translates to:
  /// **'جاري استعادة بياناتك...'**
  String get restoringYourData;

  /// No description provided for @savingDataLocally.
  ///
  /// In ar, this message translates to:
  /// **'جاري حفظ البيانات محلياً...'**
  String get savingDataLocally;

  /// No description provided for @updatingProfile.
  ///
  /// In ar, this message translates to:
  /// **'جاري تحديث الملف الشخصي...'**
  String get updatingProfile;

  /// No description provided for @dataRestoredSuccessfully.
  ///
  /// In ar, this message translates to:
  /// **'تم استعادة البيانات بنجاح'**
  String get dataRestoredSuccessfully;

  /// No description provided for @appSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'تعلم الصلوات والقرآن للأطفال'**
  String get appSubtitle;

  /// No description provided for @completeYourPrayer.
  ///
  /// In ar, this message translates to:
  /// **'أكمل صلاتك:'**
  String get completeYourPrayer;

  /// No description provided for @greatJobPrayerCompleted.
  ///
  /// In ar, this message translates to:
  /// **'ممتاز! تمت الصلاة! 🎉'**
  String get greatJobPrayerCompleted;

  /// No description provided for @timeNotSet.
  ///
  /// In ar, this message translates to:
  /// **'الوقت غير محدد'**
  String get timeNotSet;

  /// No description provided for @timeNotDetermined.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم تحديد الوقت'**
  String get timeNotDetermined;

  /// No description provided for @prayerTimeTitle.
  ///
  /// In ar, this message translates to:
  /// **'وقت الصلاة'**
  String get prayerTimeTitle;

  /// No description provided for @prayerTimeBody.
  ///
  /// In ar, this message translates to:
  /// **'حان وقت صلاة {prayer}'**
  String prayerTimeBody(Object prayer);

  /// No description provided for @prayerReminderTitle.
  ///
  /// In ar, this message translates to:
  /// **'تذكير الصلاة'**
  String get prayerReminderTitle;

  /// No description provided for @prayerReminderBody.
  ///
  /// In ar, this message translates to:
  /// **'هل صليت {prayer}؟'**
  String prayerReminderBody(Object prayer);

  /// No description provided for @prayerNotificationsChannel.
  ///
  /// In ar, this message translates to:
  /// **'إشعارات الصلاة'**
  String get prayerNotificationsChannel;

  /// No description provided for @prayerNotificationsDescription.
  ///
  /// In ar, this message translates to:
  /// **'إشعارات لأوقات الصلاة'**
  String get prayerNotificationsDescription;

  /// No description provided for @instantNotificationsChannel.
  ///
  /// In ar, this message translates to:
  /// **'الإشعارات الفورية'**
  String get instantNotificationsChannel;

  /// No description provided for @instantNotificationsDescription.
  ///
  /// In ar, this message translates to:
  /// **'الإشعارات الفورية'**
  String get instantNotificationsDescription;

  /// No description provided for @dateFormat.
  ///
  /// In ar, this message translates to:
  /// **'MMM d, y'**
  String get dateFormat;

  /// No description provided for @detailedDateFormat.
  ///
  /// In ar, this message translates to:
  /// **'EEEE, MMMM d, y'**
  String get detailedDateFormat;

  /// No description provided for @shortDateFormat.
  ///
  /// In ar, this message translates to:
  /// **'MMM d'**
  String get shortDateFormat;

  /// No description provided for @historyAndReports.
  ///
  /// In ar, this message translates to:
  /// **'التاريخ والتقارير'**
  String get historyAndReports;

  /// No description provided for @verses.
  ///
  /// In ar, this message translates to:
  /// **'آيات'**
  String get verses;

  /// No description provided for @tahmid.
  ///
  /// In ar, this message translates to:
  /// **'التحميد (100 مرة)'**
  String get tahmid;

  /// No description provided for @laIlahaIllaAllah.
  ///
  /// In ar, this message translates to:
  /// **'لا إله إلا الله (100 مرة)'**
  String get laIlahaIllaAllah;

  /// No description provided for @takbir.
  ///
  /// In ar, this message translates to:
  /// **'التكبير (100 مرة)'**
  String get takbir;

  /// No description provided for @laHawlaWaLaQuwwata.
  ///
  /// In ar, this message translates to:
  /// **'لا حول ولا قوة إلا بالله (100 مرة)'**
  String get laHawlaWaLaQuwwata;

  /// No description provided for @morningAzkarDescription.
  ///
  /// In ar, this message translates to:
  /// **'أذكار الصباح'**
  String get morningAzkarDescription;

  /// No description provided for @eveningAzkarDescription.
  ///
  /// In ar, this message translates to:
  /// **'أذكار المساء'**
  String get eveningAzkarDescription;

  /// No description provided for @quranReadingDescription.
  ///
  /// In ar, this message translates to:
  /// **'قراءة القرآن اليومية'**
  String get quranReadingDescription;

  /// No description provided for @quranListeningDescription.
  ///
  /// In ar, this message translates to:
  /// **'الاستماع للقرآن اليومي'**
  String get quranListeningDescription;

  /// No description provided for @istighfarDescription.
  ///
  /// In ar, this message translates to:
  /// **'الاستغفار'**
  String get istighfarDescription;

  /// No description provided for @salatAlaNabiDescription.
  ///
  /// In ar, this message translates to:
  /// **'الصلاة على النبي'**
  String get salatAlaNabiDescription;

  /// No description provided for @tasbihDescription.
  ///
  /// In ar, this message translates to:
  /// **'تسبيح الله'**
  String get tasbihDescription;

  /// No description provided for @tahmidDescription.
  ///
  /// In ar, this message translates to:
  /// **'حمد الله'**
  String get tahmidDescription;

  /// No description provided for @laIlahaIllaAllahDescription.
  ///
  /// In ar, this message translates to:
  /// **'إعلان الإيمان'**
  String get laIlahaIllaAllahDescription;

  /// No description provided for @takbirDescription.
  ///
  /// In ar, this message translates to:
  /// **'إعلان العظمة'**
  String get takbirDescription;

  /// No description provided for @laHawlaWaLaQuwwataDescription.
  ///
  /// In ar, this message translates to:
  /// **'طلب القوة'**
  String get laHawlaWaLaQuwwataDescription;

  /// No description provided for @salatAlDuha.
  ///
  /// In ar, this message translates to:
  /// **'صلاة الضحى'**
  String get salatAlDuha;

  /// No description provided for @qiyamAlLayl.
  ///
  /// In ar, this message translates to:
  /// **'قيام الليل'**
  String get qiyamAlLayl;

  /// No description provided for @salatAlDuhaDescription.
  ///
  /// In ar, this message translates to:
  /// **'صلاة الصباح بعد الشروق'**
  String get salatAlDuhaDescription;

  /// No description provided for @qiyamAlLaylDescription.
  ///
  /// In ar, this message translates to:
  /// **'صلاة الليل قبل الفجر'**
  String get qiyamAlLaylDescription;

  /// No description provided for @excellentMessage.
  ///
  /// In ar, this message translates to:
  /// **'ممتاز! أنت رائع! 🌟'**
  String get excellentMessage;

  /// No description provided for @greatJobMessage.
  ///
  /// In ar, this message translates to:
  /// **'أحسنت! استمر هكذا! 👏'**
  String get greatJobMessage;

  /// No description provided for @goodProgressMessage.
  ///
  /// In ar, this message translates to:
  /// **'جيد جداً! تابع التقدم! 😊'**
  String get goodProgressMessage;

  /// No description provided for @keepTryingMessage.
  ///
  /// In ar, this message translates to:
  /// **'لا بأس، حاول مرة أخرى! 💪'**
  String get keepTryingMessage;

  /// No description provided for @startPrayerMessage.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ يومك بالصلاة! 🤲'**
  String get startPrayerMessage;

  /// No description provided for @startJourneyMessage.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ رحلتك الجميلة! 🌈'**
  String get startJourneyMessage;

  /// No description provided for @fard.
  ///
  /// In ar, this message translates to:
  /// **'الفرض'**
  String get fard;

  /// No description provided for @sunnah.
  ///
  /// In ar, this message translates to:
  /// **'السنة'**
  String get sunnah;

  /// No description provided for @mandatory.
  ///
  /// In ar, this message translates to:
  /// **'إجباري'**
  String get mandatory;

  /// No description provided for @recommended.
  ///
  /// In ar, this message translates to:
  /// **'مستحب'**
  String get recommended;

  /// No description provided for @welcomeGreeting.
  ///
  /// In ar, this message translates to:
  /// **'مرحباً! أهلاً وسهلاً'**
  String get welcomeGreeting;

  /// No description provided for @letsLearnTogether.
  ///
  /// In ar, this message translates to:
  /// **'مرحباً! دعنا نتعلم معاً! 🌟'**
  String get letsLearnTogether;

  /// No description provided for @continueLearning.
  ///
  /// In ar, this message translates to:
  /// **'استمر في التعلم والنمو! 🌈'**
  String get continueLearning;

  /// No description provided for @letsStart.
  ///
  /// In ar, this message translates to:
  /// **'لنبدأ! 🚀'**
  String get letsStart;

  /// No description provided for @syncWithCloud.
  ///
  /// In ar, this message translates to:
  /// **'مزامنة مع السحابة'**
  String get syncWithCloud;

  /// No description provided for @syncWithCloudDescription.
  ///
  /// In ar, this message translates to:
  /// **'تحميل البيانات من السحابة'**
  String get syncWithCloudDescription;

  /// No description provided for @syncSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تم المزامنة بنجاح!'**
  String get syncSuccess;

  /// No description provided for @syncFailed.
  ///
  /// In ar, this message translates to:
  /// **'فشل في المزامنة:'**
  String get syncFailed;

  /// No description provided for @offlineMode.
  ///
  /// In ar, this message translates to:
  /// **'غير متصل'**
  String get offlineMode;

  /// No description provided for @syncing.
  ///
  /// In ar, this message translates to:
  /// **'جاري المزامنة...'**
  String get syncing;

  /// No description provided for @completeSunnahPrayer.
  ///
  /// In ar, this message translates to:
  /// **'أكمل صلاة السنة:'**
  String get completeSunnahPrayer;

  /// No description provided for @completeAzkar.
  ///
  /// In ar, this message translates to:
  /// **'أكمل الأذكار:'**
  String get completeAzkar;

  /// No description provided for @prayedSunnah.
  ///
  /// In ar, this message translates to:
  /// **'صليت السنة'**
  String get prayedSunnah;

  /// No description provided for @completedAzkar.
  ///
  /// In ar, this message translates to:
  /// **'أكملت الأذكار'**
  String get completedAzkar;

  /// No description provided for @excellentPrayerCompleted.
  ///
  /// In ar, this message translates to:
  /// **'ممتاز! تم إكمال الصلاة! 🎉'**
  String get excellentPrayerCompleted;

  /// No description provided for @excellentSunnahCompleted.
  ///
  /// In ar, this message translates to:
  /// **'ممتاز! تم إكمال صلاة السنة! 🎉'**
  String get excellentSunnahCompleted;

  /// No description provided for @excellentAzkarCompleted.
  ///
  /// In ar, this message translates to:
  /// **'ممتاز! تم إكمال الأذكار! 🎉'**
  String get excellentAzkarCompleted;

  /// No description provided for @surahMemorized.
  ///
  /// In ar, this message translates to:
  /// **'تم حفظ السورة! 🎉 رائع!'**
  String get surahMemorized;

  /// No description provided for @surahUnmemorized.
  ///
  /// In ar, this message translates to:
  /// **'تم إلغاء حفظ السورة'**
  String get surahUnmemorized;

  /// No description provided for @continueMemorizing.
  ///
  /// In ar, this message translates to:
  /// **'استمر في الحفظ! أنت رائع!'**
  String get continueMemorizing;

  /// No description provided for @nextPrayer.
  ///
  /// In ar, this message translates to:
  /// **'الصلاة القادمة'**
  String get nextPrayer;

  /// No description provided for @inHoursAndMinutes.
  ///
  /// In ar, this message translates to:
  /// **'في {hours} ساعة و {minutes} دقيقة'**
  String inHoursAndMinutes(Object hours, Object minutes);

  /// No description provided for @inMinutes.
  ///
  /// In ar, this message translates to:
  /// **'في {minutes} دقيقة'**
  String inMinutes(Object minutes);

  /// No description provided for @points.
  ///
  /// In ar, this message translates to:
  /// **'النقاط'**
  String get points;

  /// No description provided for @fardLabel.
  ///
  /// In ar, this message translates to:
  /// **'الفرض'**
  String get fardLabel;

  /// No description provided for @sunnahLabel.
  ///
  /// In ar, this message translates to:
  /// **'السنة'**
  String get sunnahLabel;

  /// No description provided for @azkarLabel.
  ///
  /// In ar, this message translates to:
  /// **'الأذكار'**
  String get azkarLabel;

  /// No description provided for @todayProgress.
  ///
  /// In ar, this message translates to:
  /// **'تقدمك اليوم'**
  String get todayProgress;

  /// No description provided for @fiveDailyPrayers.
  ///
  /// In ar, this message translates to:
  /// **'الصلوات الخمس'**
  String get fiveDailyPrayers;

  /// No description provided for @sunnahAndRawatib.
  ///
  /// In ar, this message translates to:
  /// **'السنن والرواتب'**
  String get sunnahAndRawatib;

  /// No description provided for @azkarSection.
  ///
  /// In ar, this message translates to:
  /// **'الأذكار'**
  String get azkarSection;

  /// No description provided for @juzAmma.
  ///
  /// In ar, this message translates to:
  /// **'جزء عم'**
  String get juzAmma;

  /// No description provided for @fromPeopleToNews.
  ///
  /// In ar, this message translates to:
  /// **'من الناس إلى النبأ'**
  String get fromPeopleToNews;

  /// No description provided for @memorizationProgress.
  ///
  /// In ar, this message translates to:
  /// **'تقدمك في الحفظ'**
  String get memorizationProgress;

  /// No description provided for @surahsMemorized.
  ///
  /// In ar, this message translates to:
  /// **'{memorized} من {total} سورة محفوظة'**
  String surahsMemorized(Object memorized, Object total);

  /// No description provided for @percentComplete.
  ///
  /// In ar, this message translates to:
  /// **'{percentage}% مكتمل'**
  String percentComplete(Object percentage);
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
      <String>['ar'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
