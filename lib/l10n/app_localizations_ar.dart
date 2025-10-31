// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get error_no_internet_connection => 'لا يوجد اتصال بالإنترنت';

  @override
  String get error_no_internet_connection_desc =>
      'يرجى التحقق من اتصالك بالإنترنت والمحاولة مرة أخرى';

  @override
  String get error_connection_timeout => 'انتهت مهلة الاتصال';

  @override
  String get error_connection_timeout_desc =>
      'استغرق الاتصال وقتاً طويلاً. يرجى المحاولة مرة أخرى';

  @override
  String get error_receive_timeout => 'انتهت مهلة الاستقبال';

  @override
  String get error_receive_timeout_desc =>
      'استغرق الخادم وقتاً طويلاً للرد. يرجى المحاولة مرة أخرى';

  @override
  String get error_send_timeout => 'انتهت مهلة الإرسال';

  @override
  String get error_send_timeout_desc =>
      'فشل في إرسال البيانات إلى الخادم. يرجى المحاولة مرة أخرى';

  @override
  String get error_server_error => 'خطأ في الخادم';

  @override
  String get error_server_error_desc =>
      'حدث خطأ في الخادم. يرجى المحاولة لاحقاً';

  @override
  String get error_internal_server_error => 'خطأ داخلي في الخادم';

  @override
  String get error_internal_server_error_desc =>
      'واجه الخادم خطأ داخلي. يرجى المحاولة لاحقاً';

  @override
  String get error_bad_gateway => 'بوابة سيئة';

  @override
  String get error_bad_gateway_desc =>
      'تلقى الخادم استجابة غير صالحة. يرجى المحاولة لاحقاً';

  @override
  String get error_service_unavailable => 'الخدمة غير متاحة';

  @override
  String get error_service_unavailable_desc =>
      'الخدمة غير متاحة مؤقتاً. يرجى المحاولة لاحقاً';

  @override
  String get error_gateway_timeout => 'انتهت مهلة البوابة';

  @override
  String get error_gateway_timeout_desc =>
      'انتهت مهلة البوابة. يرجى المحاولة لاحقاً';

  @override
  String get error_bad_request => 'طلب خاطئ';

  @override
  String get error_bad_request_desc =>
      'يحتوي الطلب على بيانات غير صالحة. يرجى التحقق من المدخلات';

  @override
  String get error_unauthorized => 'غير مصرح للوصول';

  @override
  String get error_unauthorized_desc =>
      'أنت غير مصرح للوصول إلى هذا المورد. يرجى تسجيل الدخول مرة أخرى';

  @override
  String get error_forbidden => 'الوصول مرفوض';

  @override
  String get error_forbidden_desc => 'ليس لديك إذن للوصول إلى هذا المورد';

  @override
  String get error_not_found => 'غير موجود';

  @override
  String get error_not_found_desc => 'المورد المطلوب غير موجود';

  @override
  String get error_method_not_allowed => 'الطريقة غير مسموحة';

  @override
  String get error_method_not_allowed_desc =>
      'هذه الطريقة غير مسموحة لهذا المورد';

  @override
  String get error_not_acceptable => 'غير مقبول';

  @override
  String get error_not_acceptable_desc => 'الطلب غير مقبول';

  @override
  String get error_request_timeout => 'انتهت مهلة الطلب';

  @override
  String get error_request_timeout_desc =>
      'انتهت مهلة الطلب. يرجى المحاولة مرة أخرى';

  @override
  String get error_conflict => 'تعارض';

  @override
  String get error_conflict_desc => 'يوجد تعارض مع الحالة الحالية للمورد';

  @override
  String get error_gone => 'المورد غير متاح';

  @override
  String get error_gone_desc => 'المورد المطلوب لم يعد متاحاً';

  @override
  String get error_length_required => 'الطول مطلوب';

  @override
  String get error_length_required_desc => 'يجب أن يحدد الطلب طول المحتوى';

  @override
  String get error_precondition_failed => 'فشل الشرط المسبق';

  @override
  String get error_precondition_failed_desc => 'فشل شرط مسبق واحد أو أكثر';

  @override
  String get error_payload_too_large => 'الحمولة كبيرة جداً';

  @override
  String get error_payload_too_large_desc => 'حمولة الطلب كبيرة جداً';

  @override
  String get error_uri_too_long => 'الرابط طويل جداً';

  @override
  String get error_uri_too_long_desc => 'رابط الطلب طويل جداً';

  @override
  String get error_unsupported_media_type => 'نوع الوسائط غير مدعوم';

  @override
  String get error_unsupported_media_type_desc => 'نوع الوسائط غير مدعوم';

  @override
  String get error_range_not_satisfiable => 'النطاق غير قابل للتحقيق';

  @override
  String get error_range_not_satisfiable_desc => 'لا يمكن تحقيق النطاق المطلوب';

  @override
  String get error_expectation_failed => 'فشل التوقع';

  @override
  String get error_expectation_failed_desc =>
      'لا يمكن تلبية التوقع المحدد في حقل رأس الطلب';

  @override
  String get error_too_many_requests => 'طلبات كثيرة جداً';

  @override
  String get error_too_many_requests_desc =>
      'لقد أرسلت طلبات كثيرة جداً. يرجى المحاولة لاحقاً';

  @override
  String get error_unknown => 'خطأ غير معروف';

  @override
  String get error_unknown_desc => 'حدث خطأ غير معروف. يرجى المحاولة مرة أخرى';

  @override
  String get error_cancelled => 'تم إلغاء الطلب';

  @override
  String get error_cancelled_desc => 'تم إلغاء الطلب';

  @override
  String get error_other => 'حدث خطأ';

  @override
  String get error_other_desc => 'حدث خطأ. يرجى المحاولة مرة أخرى';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get contact_support => 'اتصل بدعم';

  @override
  String get check_connection => 'تحقق من اتصالك بالإنترنت';

  @override
  String get go_back => 'العودة';

  @override
  String get appName => 'درما أي';

  @override
  String get appTagline => 'رفيق صحة بشرتك';

  @override
  String get loading => 'جاري التحميل...';

  @override
  String get onboardingTitle1 => 'تحليل البشرة بالذكاء الاصطناعي';

  @override
  String get onboardingDesc1 =>
      'احصل على تحليل فوري لحالة بشرتك باستخدام تقنيات الذكاء الاصطناعي المتقدمة';

  @override
  String get onboardingTitle2 => 'استشارة أطباء الجلد المعتمدين';

  @override
  String get onboardingDesc2 =>
      'تواصل مع أطباء جلدية متخصصين للحصول على نصائح طبية موثوقة';

  @override
  String get onboardingTitle3 => 'خطط علاجية مخصصة لبشرتك';

  @override
  String get onboardingDesc3 =>
      'استلم توصيات علاجية مخصصة تناسب نوع بشرتك وحالتها';

  @override
  String get skip => 'تخطي';

  @override
  String get next => 'التالي';

  @override
  String get previous => 'السابق';

  @override
  String get getStarted => 'ابدأ الآن';

  @override
  String get welcomeBack => 'مرحباً بعودتك';

  @override
  String get signInToContinue => 'سجل دخولك للمتابعة إلى درما أي';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get enterEmail => 'أدخل بريدك الإلكتروني';

  @override
  String get pleaseEnterEmail => 'الرجاء إدخال بريدك الإلكتروني';

  @override
  String get pleaseEnterValidEmail => 'الرجاء إدخال بريد إلكتروني صحيح';

  @override
  String get password => 'كلمة المرور';

  @override
  String get enterPassword => 'أدخل كلمة المرور';

  @override
  String get pleaseEnterPassword => 'الرجاء إدخال كلمة المرور';

  @override
  String get passwordMustBe => 'يجب أن تكون كلمة المرور 6 أحرف على الأقل';

  @override
  String get rememberMe => 'تذكرني';

  @override
  String get forgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get orContinueWith => 'أو تابع باستخدام';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get enterConfirmPassword => 'أدخل تأكيد كلمة المرور';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get signUpToGetStarted => 'سجل للبدء مع درما أي';

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get enterFullName => 'أدخل اسمك الكامل';

  @override
  String get pleaseEnterName => 'الرجاء إدخال اسمك';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get confirmYourPassword => 'تأكيد كلمة المرور';

  @override
  String get pleaseConfirmPassword => 'الرجاء تأكيد كلمة المرور';

  @override
  String get passwordsDoNotMatch => 'كلمات المرور غير متطابقة';

  @override
  String get iAgreeToThe => 'أوافق على';

  @override
  String get termsOfService => 'شروط الخدمة';

  @override
  String get and => 'و';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get pleaseAcceptTerms => 'الرجاء الموافقة على الشروط والأحكام';

  @override
  String get alreadyHaveAccount => 'لديك حساب بالفعل؟';

  @override
  String get createNewAccount => 'إنشاء حساب جديد';

  @override
  String get forgotPasswordTitle => 'نسيت كلمة المرور؟';

  @override
  String get forgotPasswordSubtitle =>
      'أدخل بريدك الإلكتروني وسنرسل لك رمز التحقق لإعادة تعيين كلمة المرور';

  @override
  String get sendVerificationCode => 'إرسال رمز التحقق';

  @override
  String get rememberPassword => 'تذكرت كلمة المرور؟';

  @override
  String get backToLogin => 'العودة لتسجيل الدخول';

  @override
  String get resetPasswordTitle => 'إعادة تعيين كلمة المرور';

  @override
  String get verifyCodeTitle => 'التحقق من الرمز';

  @override
  String get enterCodeSentTo => 'أدخل رمز التحقق المرسل إلى';

  @override
  String get verifyCodeButton => 'تحقق من الرمز';

  @override
  String get didNotReceiveCode => 'لم تستلم الرمز؟';

  @override
  String get resendCodeButton => 'إعادة الإرسال';

  @override
  String get createNewPasswordTitle => 'إنشاء كلمة مرور جديدة';

  @override
  String get enterNewPasswordFor => 'أدخل كلمة مرور جديدة لحسابك';

  @override
  String get newPassword => 'كلمة المرور الجديدة';

  @override
  String get enterNewPassword => 'أدخل كلمة المرور الجديدة';

  @override
  String get confirmNewPassword => 'تأكيد كلمة المرور';

  @override
  String get reEnterPassword => 'أعد إدخال كلمة المرور';

  @override
  String get resetPasswordButton => 'إعادة تعيين كلمة المرور';

  @override
  String get passwordRequirements => 'متطلبات كلمة المرور:';

  @override
  String get atLeast8Characters => '8 أحرف على الأقل';

  @override
  String get upperLowerCase => 'حرف كبير وحرف صغير';

  @override
  String get atLeastOneNumber => 'رقم واحد على الأقل';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get enterPhoneNumber => 'أدخل رقم هاتفك';

  @override
  String get pleaseEnterPhoneNumber => 'يرجى إدخال رقم الهاتف';

  @override
  String get pleaseEnterValidPhoneNumber => 'يرجى إدخال رقم هاتف صحيح';

  @override
  String get welcomeToDermaAI => 'انضم إلينا وابدأ رحلتك في العناية بالبشرة';

  @override
  String get accountVerification => 'تأكيد الحساب';

  @override
  String get verifyOtpCode => 'تأكيد رمز التحقق';

  @override
  String get otpSentToEmail => 'تم إرسال رمز التحقق إلى بريدك الإلكتروني';

  @override
  String get otpSentToPhone => 'تم إرسال رمز التحقق إلى رقم هاتفك';

  @override
  String get emailVerification => 'البريد الإلكتروني';

  @override
  String get phoneVerification => 'رقم الهاتف';

  @override
  String get verifyCode => 'تأكيد الرمز';

  @override
  String get resendCode => 'إعادة إرسال الرمز';

  @override
  String get codeValidFor5Minutes => 'الرمز صالح لمدة 5 دقائق فقط';

  @override
  String helloUser(Object name) {
    return 'مرحباً، $name!';
  }

  @override
  String get findYourDoctor => 'ابحث عن طبيبك';

  @override
  String get howCanWeHelp => 'كيف يمكننا مساعدة بشرتك اليوم؟';

  @override
  String get skinHelpPrompt => 'كيف يمكننا مساعدة بشرتك اليوم؟';

  @override
  String get aiSkinDiagnosis => 'تشخيص البشرة بالذكاء الاصطناعي';

  @override
  String get takeSkinPhoto =>
      'التقط صورة لحالة بشرتك واحصل على تشخيص فوري بالذكاء الاصطناعي';

  @override
  String get startDiagnosis => 'ابدأ التشخيص';

  @override
  String get quickAccess => 'وصول سريع';

  @override
  String get findDoctors => 'البحث عن أطباء';

  @override
  String get appointments => 'المواعيد';

  @override
  String get myDiagnoses => 'تشخيصاتي';

  @override
  String get skinTips => 'نصائح للبشرة';

  @override
  String get topDermatologists => 'أفضل أطباء الجلدية';

  @override
  String get seeAll => 'عرض الكل';

  @override
  String get recentDiagnoses => 'التشخيصات الأخيرة';

  @override
  String get description => 'الوصف';

  @override
  String get symptoms => 'الأعراض';

  @override
  String get treatments => 'العلاجات';

  @override
  String get high => 'مرتفع';

  @override
  String get medium => 'متوسط';

  @override
  String get low => 'منخفض';

  @override
  String get unknown => 'غير معروف';

  @override
  String get diagnosisDescription =>
      'التقط أو ارفع صورة لحالة بشرتك للحصول على تحليل فوري بالذكاء الاصطناعي وتوصيات العلاج.';

  @override
  String get aiPoweredSkinDiagnosis => 'تشخيص البشرة بالذكاء الاصطناعي';

  @override
  String get uploadOrTakePhoto => 'ارفع أو التقط صورة';

  @override
  String get photoGuidelines =>
      'للحصول على تشخيص دقيق، تأكد من أن الصورة واضحة وجيدة الإضاءة وتركز على المنطقة المصابة.';

  @override
  String get takePhoto => 'التقط صورة';

  @override
  String get uploadPhoto => 'ارفع صورة';

  @override
  String get analyzingSkinCondition => 'جاري تحليل حالة بشرتك...';

  @override
  String get changePhoto => 'تغيير الصورة';

  @override
  String get analyze => 'تحليل';

  @override
  String get diagnosisResult => 'نتيجة التشخيص';

  @override
  String get similarCases => 'حالات مشابهة';

  @override
  String get saveToMyRecords => 'حفظ في سجلاتي';

  @override
  String get diagnosisSaved => 'تم حفظ التشخيص في سجلاتك';

  @override
  String get shareWithDoctor => 'مشاركة مع طبيب';

  @override
  String get aiDiagnosis => 'تشخيص الذكاء الاصطناعي';

  @override
  String get confidence => 'الثقة';

  @override
  String get diagnosedOn => 'تم التشخيص في';

  @override
  String get imageAnalysis => 'تحليل الصورة';

  @override
  String get commonSymptoms => 'الأعراض الشائعة';

  @override
  String get recommendedTreatments => 'العلاجات الموصى بها';

  @override
  String get aiDisclaimerMessage =>
      'هذا تشخيص تم إنشاؤه بواسطة الذكاء الاصطناعي. يرجى استشارة طبيب جلدية للحصول على مشورة طبية متخصصة.';

  @override
  String get bookAppointmentWithDermatologist => 'حجز موعد مع طبيب جلدية';

  @override
  String get lowSeverity => 'شدة منخفضة';

  @override
  String get mediumSeverity => 'شدة متوسطة';

  @override
  String get highSeverity => 'شدة مرتفعة';

  @override
  String get unknownSeverity => 'شدة غير معروفة';

  @override
  String get available => 'متاح';

  @override
  String get unavailable => 'غير متاح';

  @override
  String get about => 'عن الطبيب';

  @override
  String get experience => 'الخبرة';

  @override
  String get reviews => 'تقييمات';

  @override
  String get services => 'الخدمات';

  @override
  String get education => 'التعليم';

  @override
  String get patientReviews => 'تقييمات المرضى';

  @override
  String get viewAll => 'عرض الكل';

  @override
  String get bookAppointment => 'حجز موعد';

  @override
  String get pleaseSelectTimeSlot => 'الرجاء اختيار فترة زمنية';

  @override
  String get appointmentBooked => 'تم حجز الموعد';

  @override
  String get doctor => 'الطبيب';

  @override
  String get date => 'التاريخ';

  @override
  String get time => 'الوقت';

  @override
  String get ok => 'موافق';

  @override
  String get doctorConsultation => 'استشارة طبيب';

  @override
  String get skinCare => 'العناية بالبشرة';

  @override
  String get healthTips => 'نصائح صحية';

  @override
  String get ourServices => 'خدماتنا';

  @override
  String get home => 'الرئيسية';

  @override
  String get profile => 'الحساب';

  @override
  String get community => 'المجتمع';

  @override
  String get communityDescription => 'تواصل مع أطباء الجلدية وشارك تجربتك';

  @override
  String get posts => 'المنشورات';

  @override
  String get trending => 'الأكثر تداولاً';

  @override
  String get following => 'المتابعون';

  @override
  String get communityStats => 'إحصائيات المجتمع';

  @override
  String get members => 'الأعضاء';

  @override
  String get comments => 'التعليقات';

  @override
  String get shares => 'المشاركات';

  @override
  String get likes => 'الإعجابات';

  @override
  String get viewMore => 'عرض المزيد';

  @override
  String get viewLess => 'عرض أقل';

  @override
  String get savePost => 'حفظ المنشور';

  @override
  String get reportPost => 'إبلاغ';

  @override
  String get sharePost => 'مشاركة المنشور';

  @override
  String get postShared => 'تم مشاركة المنشور';

  @override
  String get searchCommunity => 'ابحث في المجتمع...';

  @override
  String get latestPosts => 'أحدث المنشورات';

  @override
  String get trendingHashtags => 'الأكثر تداولاً';

  @override
  String get newLabel => 'جديد';

  @override
  String get verifiedDoctor => 'طبيب معتمد';

  @override
  String get specialistDoctor => 'متخصص معتمد';

  @override
  String get today => 'اليوم';

  @override
  String get thisWeek => 'هذا الأسبوع';

  @override
  String get thisMonth => 'هذا الشهر';

  @override
  String get doctors => 'الأطباء';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get logoutConfirmationTitle => 'هل أنت متأكد؟';

  @override
  String get logoutConfirmationMessage => 'هل تريد تسجيل الخروج من حسابك؟';

  @override
  String get cancel => 'إلغاء';

  @override
  String get logoutSuccessMessage => 'تم تسجيل الخروج بنجاح';

  @override
  String get userLogin => 'تسجيل دخول المستخدم';

  @override
  String get doctorLogin => 'تسجيل دخول الطبيب';

  @override
  String get userWelcome => 'مرحباً بك في DermaAI';

  @override
  String get doctorWelcome => 'مرحباً بك في منصة الأطباء';

  @override
  String get user => 'مستخدم';

  @override
  String get rememberMeError => 'حدث خطأ أثناء حفظ بيانات الذاكرة';

  @override
  String get doctorTitle => 'دكتور';

  @override
  String get dashboard => 'لوحة التحكم';

  @override
  String get statistics => 'الإحصائيات';

  @override
  String get totalAppointments => 'إجمالي المواعيد';

  @override
  String get newPatients => 'مرضى جدد';

  @override
  String get returnPatients => 'مرضى عائدون';

  @override
  String get averageRating => 'متوسط التقييم';

  @override
  String get analytics => 'التحليلات';

  @override
  String get appointmentsStatus => 'حالة المواعيد';

  @override
  String get consultationsGrowth => 'نمو الاستشارات';

  @override
  String get skinConditionsDistribution => 'توزيع حالات الجلد';

  @override
  String get upcomingAppointments => 'المواعيد القادمة';

  @override
  String get patients => 'المرضى';

  @override
  String get upcoming => 'قادمة';

  @override
  String get completed => 'مكتملة';

  @override
  String get canceled => 'ملغاة';

  @override
  String get completedAppointments => 'المواعيد المكتملة';

  @override
  String get canceledAppointments => 'المواعيد الملغاة';

  @override
  String get searchPatients => 'البحث عن المرضى';

  @override
  String get personalInformation => 'المعلومات الشخصية';

  @override
  String get professionalInformation => 'المعلومات المهنية';

  @override
  String get accountSettings => 'إعدادات الحساب';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get privacySecurity => 'الخصوصية والأمان';

  @override
  String get language => 'اللغة';

  @override
  String get helpSupport => 'المساعدة والدعم';

  @override
  String get name => 'الاسم';

  @override
  String get speciality => 'التخصص';

  @override
  String get phone => 'الهاتف';

  @override
  String get languages => 'اللغات';

  @override
  String get clinicLocation => 'موقع العيادة';
}
