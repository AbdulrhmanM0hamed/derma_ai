// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get error_no_internet_connection => 'No internet connection';

  @override
  String get error_no_internet_connection_desc =>
      'Please check your internet connection and try again';

  @override
  String get error_connection_timeout => 'Connection timeout';

  @override
  String get error_connection_timeout_desc =>
      'The connection took too long to establish. Please try again';

  @override
  String get error_receive_timeout => 'Receive timeout';

  @override
  String get error_receive_timeout_desc =>
      'The server took too long to respond. Please try again';

  @override
  String get error_send_timeout => 'Send timeout';

  @override
  String get error_send_timeout_desc =>
      'Failed to send data to the server. Please try again';

  @override
  String get error_server_error => 'Server error';

  @override
  String get error_server_error_desc =>
      'Something went wrong on the server. Please try again later';

  @override
  String get error_internal_server_error => 'Internal server error';

  @override
  String get error_internal_server_error_desc =>
      'The server encountered an internal error. Please try again later';

  @override
  String get error_bad_gateway => 'Bad gateway';

  @override
  String get error_bad_gateway_desc =>
      'The server received an invalid response. Please try again later';

  @override
  String get error_service_unavailable => 'Service unavailable';

  @override
  String get error_service_unavailable_desc =>
      'The service is temporarily unavailable. Please try again later';

  @override
  String get error_gateway_timeout => 'Gateway timeout';

  @override
  String get error_gateway_timeout_desc =>
      'The gateway timed out. Please try again later';

  @override
  String get error_bad_request => 'Bad request';

  @override
  String get error_bad_request_desc =>
      'The request contains invalid data. Please check your input';

  @override
  String get error_unauthorized => 'Unauthorized';

  @override
  String get error_unauthorized_desc =>
      'You are not authorized to access this resource. Please login again';

  @override
  String get error_forbidden => 'Access denied';

  @override
  String get error_forbidden_desc =>
      'You don\'t have permission to access this resource';

  @override
  String get error_not_found => 'Not found';

  @override
  String get error_not_found_desc => 'The requested resource was not found';

  @override
  String get error_method_not_allowed => 'Method not allowed';

  @override
  String get error_method_not_allowed_desc =>
      'This method is not allowed for this resource';

  @override
  String get error_not_acceptable => 'Not acceptable';

  @override
  String get error_not_acceptable_desc => 'The request is not acceptable';

  @override
  String get error_request_timeout => 'Request timeout';

  @override
  String get error_request_timeout_desc =>
      'The request timed out. Please try again';

  @override
  String get error_conflict => 'Conflict';

  @override
  String get error_conflict_desc =>
      'There is a conflict with the current state of the resource';

  @override
  String get error_gone => 'Resource gone';

  @override
  String get error_gone_desc => 'The requested resource is no longer available';

  @override
  String get error_length_required => 'Length required';

  @override
  String get error_length_required_desc =>
      'The request must specify the content length';

  @override
  String get error_precondition_failed => 'Precondition failed';

  @override
  String get error_precondition_failed_desc =>
      'One or more preconditions failed';

  @override
  String get error_payload_too_large => 'Payload too large';

  @override
  String get error_payload_too_large_desc => 'The request payload is too large';

  @override
  String get error_uri_too_long => 'URI too long';

  @override
  String get error_uri_too_long_desc => 'The request URI is too long';

  @override
  String get error_unsupported_media_type => 'Unsupported media type';

  @override
  String get error_unsupported_media_type_desc =>
      'The media type is not supported';

  @override
  String get error_range_not_satisfiable => 'Range not satisfiable';

  @override
  String get error_range_not_satisfiable_desc =>
      'The requested range cannot be satisfied';

  @override
  String get error_expectation_failed => 'Expectation failed';

  @override
  String get error_expectation_failed_desc =>
      'The expectation given in the request header field could not be met';

  @override
  String get error_too_many_requests => 'Too many requests';

  @override
  String get error_too_many_requests_desc =>
      'You have sent too many requests. Please try again later';

  @override
  String get error_unknown => 'Unknown error';

  @override
  String get error_unknown_desc =>
      'An unknown error occurred. Please try again';

  @override
  String get error_cancelled => 'Request cancelled';

  @override
  String get error_cancelled_desc => 'The request was cancelled';

  @override
  String get error_other => 'Error occurred';

  @override
  String get error_other_desc => 'An error occurred. Please try again';

  @override
  String get retry => 'Retry';

  @override
  String get contact_support => 'Contact Support';

  @override
  String get check_connection => 'Check your internet connection';

  @override
  String get go_back => 'Go back';

  @override
  String get appName => 'DermaAI';

  @override
  String get appTagline => 'Your Skin Health Companion';

  @override
  String get loading => 'Loading...';

  @override
  String get onboardingTitle1 => 'AI Skin Analysis';

  @override
  String get onboardingDesc1 =>
      'Get an instant analysis of your skin condition using advanced AI techniques';

  @override
  String get onboardingTitle2 => 'Consult Certified Dermatologists';

  @override
  String get onboardingDesc2 =>
      'Connect with specialized dermatologists for reliable medical advice';

  @override
  String get onboardingTitle3 => 'Personalized Treatment Plans';

  @override
  String get onboardingDesc3 =>
      'Receive customized treatment recommendations tailored to your skin type and condition';

  @override
  String get skip => 'Skip';

  @override
  String get next => 'Next';

  @override
  String get previous => 'Previous';

  @override
  String get getStarted => 'Get Started';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get signInToContinue => 'Sign in to continue to DermaAI';

  @override
  String get email => 'Email';

  @override
  String get enterEmail => 'Enter your email';

  @override
  String get pleaseEnterEmail => 'Please enter your email';

  @override
  String get pleaseEnterValidEmail => 'Please enter a valid email';

  @override
  String get password => 'Password';

  @override
  String get enterPassword => 'Enter your password';

  @override
  String get pleaseEnterPassword => 'Please enter your password';

  @override
  String get passwordMustBe => 'Password must be at least 6 characters';

  @override
  String get rememberMe => 'Remember me';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get login => 'Login';

  @override
  String get orContinueWith => 'Or continue with';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get signUp => 'Sign Up';

  @override
  String get enterConfirmPassword => 'Enter confirm password';

  @override
  String get createAccount => 'Create Account';

  @override
  String get signUpToGetStarted => 'Sign up to get started with DermaAI';

  @override
  String get fullName => 'Full Name';

  @override
  String get enterFullName => 'Enter your full name';

  @override
  String get pleaseEnterName => 'Please enter your name';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get confirmYourPassword => 'Confirm your password';

  @override
  String get pleaseConfirmPassword => 'Please confirm your password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get iAgreeToThe => 'I agree to the';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get and => 'and';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get pleaseAcceptTerms => 'Please accept the terms and conditions';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get createNewAccount => 'Create New Account';

  @override
  String get forgotPasswordTitle => 'Forgot Password?';

  @override
  String get forgotPasswordSubtitle =>
      'Enter your email and we\'ll send you a verification code to reset your password';

  @override
  String get sendVerificationCode => 'Send Verification Code';

  @override
  String get rememberPassword => 'Remember your password?';

  @override
  String get backToLogin => 'Back to Login';

  @override
  String get resetPasswordTitle => 'Reset Password';

  @override
  String get verifyCodeTitle => 'Verify Code';

  @override
  String get enterCodeSentTo => 'Enter the verification code sent to';

  @override
  String get verifyCodeButton => 'Verify Code';

  @override
  String get didNotReceiveCode => 'Didn\'t receive the code?';

  @override
  String get resendCodeButton => 'Resend';

  @override
  String get createNewPasswordTitle => 'Create New Password';

  @override
  String get enterNewPasswordFor => 'Enter a new password for your account';

  @override
  String get newPassword => 'New Password';

  @override
  String get enterNewPassword => 'Enter new password';

  @override
  String get confirmNewPassword => 'Confirm Password';

  @override
  String get reEnterPassword => 'Re-enter password';

  @override
  String get resetPasswordButton => 'Reset Password';

  @override
  String get passwordRequirements => 'Password Requirements:';

  @override
  String get atLeast8Characters => 'At least 8 characters';

  @override
  String get upperLowerCase => 'Upper and lower case letters';

  @override
  String get atLeastOneNumber => 'At least one number';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get enterPhoneNumber => 'Enter your phone number';

  @override
  String get pleaseEnterPhoneNumber => 'Please enter your phone number';

  @override
  String get pleaseEnterValidPhoneNumber => 'Please enter a valid phone number';

  @override
  String get welcomeToDermaAI => 'join us and start your skin care journey';

  @override
  String get accountVerification => 'Account Verification';

  @override
  String get verifyOtpCode => 'Verify OTP Code';

  @override
  String get otpSentToEmail => 'Verification code sent to your email';

  @override
  String get otpSentToPhone => 'Verification code sent to your phone';

  @override
  String get emailVerification => 'Email';

  @override
  String get phoneVerification => 'Phone';

  @override
  String get verifyCode => 'Verify Code';

  @override
  String get resendCode => 'Resend Code';

  @override
  String get codeValidFor5Minutes => 'Code is valid for 5 minutes only';

  @override
  String helloUser(Object name) {
    return 'Hello, $name!';
  }

  @override
  String get findYourDoctor => 'Find Your Doctor';

  @override
  String get howCanWeHelp => 'How can we help your skin today?';

  @override
  String get skinHelpPrompt => 'How can we help your skin today?';

  @override
  String get aiSkinDiagnosis => 'AI Skin Diagnosis';

  @override
  String get takeSkinPhoto =>
      'Take a photo of your skin condition and get an instant AI-powered diagnosis';

  @override
  String get startDiagnosis => 'Start Diagnosis';

  @override
  String get quickAccess => 'Quick Access';

  @override
  String get findDoctors => 'Find Doctors';

  @override
  String get appointments => 'Appointments';

  @override
  String get myDiagnoses => 'My Diagnoses';

  @override
  String get skinTips => 'Skin Tips';

  @override
  String get topDermatologists => 'Top Dermatologists';

  @override
  String get seeAll => 'See All';

  @override
  String get recentDiagnoses => 'Recent Diagnoses';

  @override
  String get description => 'Description';

  @override
  String get symptoms => 'Symptoms';

  @override
  String get treatments => 'Treatments';

  @override
  String get high => 'High';

  @override
  String get medium => 'Medium';

  @override
  String get low => 'Low';

  @override
  String get unknown => 'Unknown';

  @override
  String get diagnosisDescription =>
      'Take or upload a photo of your skin condition for instant AI analysis and treatment recommendations.';

  @override
  String get aiPoweredSkinDiagnosis => 'AI-Powered Skin Diagnosis';

  @override
  String get uploadOrTakePhoto => 'Upload or Take a Photo';

  @override
  String get photoGuidelines =>
      'For accurate diagnosis, ensure the photo is clear, well-lit, and focused on the affected area.';

  @override
  String get takePhoto => 'Take Photo';

  @override
  String get uploadPhoto => 'Upload Photo';

  @override
  String get analyzingSkinCondition => 'Analyzing your skin condition...';

  @override
  String get changePhoto => 'Change Photo';

  @override
  String get analyze => 'Analyze';

  @override
  String get diagnosisResult => 'Diagnosis Result';

  @override
  String get similarCases => 'Similar Cases';

  @override
  String get saveToMyRecords => 'Save to My Records';

  @override
  String get diagnosisSaved => 'Diagnosis saved to your records';

  @override
  String get shareWithDoctor => 'Share with Doctor';

  @override
  String get aiDiagnosis => 'AI Diagnosis';

  @override
  String get confidence => 'Confidence';

  @override
  String get diagnosedOn => 'Diagnosed on';

  @override
  String get imageAnalysis => 'Image Analysis';

  @override
  String get commonSymptoms => 'Common Symptoms';

  @override
  String get recommendedTreatments => 'Recommended Treatments';

  @override
  String get aiDisclaimerMessage =>
      'This is an AI-generated diagnosis. Please consult with a dermatologist for professional medical advice.';

  @override
  String get bookAppointmentWithDermatologist =>
      'Book Appointment with Dermatologist';

  @override
  String get lowSeverity => 'Low Severity';

  @override
  String get mediumSeverity => 'Medium Severity';

  @override
  String get highSeverity => 'High Severity';

  @override
  String get unknownSeverity => 'Unknown Severity';

  @override
  String get available => 'Available';

  @override
  String get unavailable => 'Unavailable';

  @override
  String get about => 'About';

  @override
  String get experience => 'Experience';

  @override
  String get reviews => 'Reviews';

  @override
  String get services => 'Services';

  @override
  String get education => 'Education';

  @override
  String get patientReviews => 'Patient Reviews';

  @override
  String get viewAll => 'View All';

  @override
  String get bookAppointment => 'Book Appointment';

  @override
  String get pleaseSelectTimeSlot => 'Please select a time slot';

  @override
  String get appointmentBooked => 'Appointment Booked';

  @override
  String get doctor => 'Doctor';

  @override
  String get date => 'Date';

  @override
  String get time => 'Time';

  @override
  String get ok => 'OK';

  @override
  String get doctorConsultation => 'Doctor Consultation';

  @override
  String get skinCare => 'Skin Care';

  @override
  String get healthTips => 'Health Tips';

  @override
  String get ourServices => 'Our Services';

  @override
  String get home => 'Home';

  @override
  String get profile => 'Profile';

  @override
  String get community => 'Community';

  @override
  String get communityDescription =>
      'Connect with dermatologists and share your experience';

  @override
  String get posts => 'Posts';

  @override
  String get trending => 'Trending';

  @override
  String get following => 'Following';

  @override
  String get communityStats => 'Community Stats';

  @override
  String get members => 'Members';

  @override
  String get comments => 'Comments';

  @override
  String get shares => 'Shares';

  @override
  String get likes => 'Likes';

  @override
  String get viewMore => 'View More';

  @override
  String get viewLess => 'View Less';

  @override
  String get savePost => 'Save Post';

  @override
  String get reportPost => 'Report';

  @override
  String get sharePost => 'Share Post';

  @override
  String get postShared => 'Post shared';

  @override
  String get searchCommunity => 'Search community...';

  @override
  String get latestPosts => 'Latest Posts';

  @override
  String get trendingHashtags => 'Trending Hashtags';

  @override
  String get newLabel => 'New';

  @override
  String get verifiedDoctor => 'Verified Doctor';

  @override
  String get specialistDoctor => 'Certified Specialist';

  @override
  String get today => 'Today';

  @override
  String get thisWeek => 'This Week';

  @override
  String get thisMonth => 'This Month';

  @override
  String get doctors => 'Doctors';

  @override
  String get logout => 'Logout';

  @override
  String get logoutConfirmationTitle => 'Are you sure?';

  @override
  String get logoutConfirmationMessage =>
      'Do you want to logout from your account?';

  @override
  String get cancel => 'Cancel';

  @override
  String get logoutSuccessMessage => 'Logged out successfully';

  @override
  String get userLogin => 'User Login';

  @override
  String get doctorLogin => 'Doctor Login';

  @override
  String get userWelcome => 'Welcome to DermaAI';

  @override
  String get doctorWelcome => 'Welcome to Doctors Platform';

  @override
  String get user => 'User';

  @override
  String get rememberMeError =>
      'An error occurred while saving remember me data';

  @override
  String get doctorTitle => 'Doctor';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get statistics => 'Statistics';

  @override
  String get totalAppointments => 'Total Appointments';

  @override
  String get newPatients => 'New Patients';

  @override
  String get returnPatients => 'Return Patients';

  @override
  String get averageRating => 'Average Rating';

  @override
  String get analytics => 'Analytics';

  @override
  String get appointmentsStatus => 'Appointments Status';

  @override
  String get consultationsGrowth => 'Consultations Growth';

  @override
  String get skinConditionsDistribution => 'Skin Conditions Distribution';

  @override
  String get upcomingAppointments => 'Upcoming Appointments';

  @override
  String get patients => 'Patients';

  @override
  String get upcoming => 'Upcoming';

  @override
  String get completed => 'Completed';

  @override
  String get canceled => 'Canceled';

  @override
  String get completedAppointments => 'Completed Appointments';

  @override
  String get canceledAppointments => 'Canceled Appointments';

  @override
  String get searchPatients => 'Search patients';

  @override
  String get personalInformation => 'Personal Information';

  @override
  String get professionalInformation => 'Professional Information';

  @override
  String get accountSettings => 'Account Settings';

  @override
  String get notifications => 'Notifications';

  @override
  String get privacySecurity => 'Privacy & Security';

  @override
  String get language => 'Language';

  @override
  String get helpSupport => 'Help & Support';

  @override
  String get name => 'Name';

  @override
  String get speciality => 'Speciality';

  @override
  String get phone => 'Phone';

  @override
  String get languages => 'Languages';

  @override
  String get clinicLocation => 'Clinic Location';
}
