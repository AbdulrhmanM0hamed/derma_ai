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
    Locale('en'),
    Locale('ar'),
  ];

  /// No description provided for @error_no_internet_connection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get error_no_internet_connection;

  /// No description provided for @error_no_internet_connection_desc.
  ///
  /// In en, this message translates to:
  /// **'Please check your internet connection and try again'**
  String get error_no_internet_connection_desc;

  /// No description provided for @error_connection_timeout.
  ///
  /// In en, this message translates to:
  /// **'Connection timeout'**
  String get error_connection_timeout;

  /// No description provided for @error_connection_timeout_desc.
  ///
  /// In en, this message translates to:
  /// **'The connection took too long to establish. Please try again'**
  String get error_connection_timeout_desc;

  /// No description provided for @error_receive_timeout.
  ///
  /// In en, this message translates to:
  /// **'Receive timeout'**
  String get error_receive_timeout;

  /// No description provided for @error_receive_timeout_desc.
  ///
  /// In en, this message translates to:
  /// **'The server took too long to respond. Please try again'**
  String get error_receive_timeout_desc;

  /// No description provided for @error_send_timeout.
  ///
  /// In en, this message translates to:
  /// **'Send timeout'**
  String get error_send_timeout;

  /// No description provided for @error_send_timeout_desc.
  ///
  /// In en, this message translates to:
  /// **'Failed to send data to the server. Please try again'**
  String get error_send_timeout_desc;

  /// No description provided for @error_server_error.
  ///
  /// In en, this message translates to:
  /// **'Server error'**
  String get error_server_error;

  /// No description provided for @error_server_error_desc.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong on the server. Please try again later'**
  String get error_server_error_desc;

  /// No description provided for @error_internal_server_error.
  ///
  /// In en, this message translates to:
  /// **'Internal server error'**
  String get error_internal_server_error;

  /// No description provided for @error_internal_server_error_desc.
  ///
  /// In en, this message translates to:
  /// **'The server encountered an internal error. Please try again later'**
  String get error_internal_server_error_desc;

  /// No description provided for @error_bad_gateway.
  ///
  /// In en, this message translates to:
  /// **'Bad gateway'**
  String get error_bad_gateway;

  /// No description provided for @error_bad_gateway_desc.
  ///
  /// In en, this message translates to:
  /// **'The server received an invalid response. Please try again later'**
  String get error_bad_gateway_desc;

  /// No description provided for @error_service_unavailable.
  ///
  /// In en, this message translates to:
  /// **'Service unavailable'**
  String get error_service_unavailable;

  /// No description provided for @error_service_unavailable_desc.
  ///
  /// In en, this message translates to:
  /// **'The service is temporarily unavailable. Please try again later'**
  String get error_service_unavailable_desc;

  /// No description provided for @error_gateway_timeout.
  ///
  /// In en, this message translates to:
  /// **'Gateway timeout'**
  String get error_gateway_timeout;

  /// No description provided for @error_gateway_timeout_desc.
  ///
  /// In en, this message translates to:
  /// **'The gateway timed out. Please try again later'**
  String get error_gateway_timeout_desc;

  /// No description provided for @error_bad_request.
  ///
  /// In en, this message translates to:
  /// **'Bad request'**
  String get error_bad_request;

  /// No description provided for @error_bad_request_desc.
  ///
  /// In en, this message translates to:
  /// **'The request contains invalid data. Please check your input'**
  String get error_bad_request_desc;

  /// No description provided for @error_unauthorized.
  ///
  /// In en, this message translates to:
  /// **'Unauthorized'**
  String get error_unauthorized;

  /// No description provided for @error_unauthorized_desc.
  ///
  /// In en, this message translates to:
  /// **'You are not authorized to access this resource. Please login again'**
  String get error_unauthorized_desc;

  /// No description provided for @error_forbidden.
  ///
  /// In en, this message translates to:
  /// **'Access denied'**
  String get error_forbidden;

  /// No description provided for @error_forbidden_desc.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have permission to access this resource'**
  String get error_forbidden_desc;

  /// No description provided for @error_not_found.
  ///
  /// In en, this message translates to:
  /// **'Not found'**
  String get error_not_found;

  /// No description provided for @error_not_found_desc.
  ///
  /// In en, this message translates to:
  /// **'The requested resource was not found'**
  String get error_not_found_desc;

  /// No description provided for @error_method_not_allowed.
  ///
  /// In en, this message translates to:
  /// **'Method not allowed'**
  String get error_method_not_allowed;

  /// No description provided for @error_method_not_allowed_desc.
  ///
  /// In en, this message translates to:
  /// **'This method is not allowed for this resource'**
  String get error_method_not_allowed_desc;

  /// No description provided for @error_not_acceptable.
  ///
  /// In en, this message translates to:
  /// **'Not acceptable'**
  String get error_not_acceptable;

  /// No description provided for @error_not_acceptable_desc.
  ///
  /// In en, this message translates to:
  /// **'The request is not acceptable'**
  String get error_not_acceptable_desc;

  /// No description provided for @error_request_timeout.
  ///
  /// In en, this message translates to:
  /// **'Request timeout'**
  String get error_request_timeout;

  /// No description provided for @error_request_timeout_desc.
  ///
  /// In en, this message translates to:
  /// **'The request timed out. Please try again'**
  String get error_request_timeout_desc;

  /// No description provided for @error_conflict.
  ///
  /// In en, this message translates to:
  /// **'Conflict'**
  String get error_conflict;

  /// No description provided for @error_conflict_desc.
  ///
  /// In en, this message translates to:
  /// **'There is a conflict with the current state of the resource'**
  String get error_conflict_desc;

  /// No description provided for @error_gone.
  ///
  /// In en, this message translates to:
  /// **'Resource gone'**
  String get error_gone;

  /// No description provided for @error_gone_desc.
  ///
  /// In en, this message translates to:
  /// **'The requested resource is no longer available'**
  String get error_gone_desc;

  /// No description provided for @error_length_required.
  ///
  /// In en, this message translates to:
  /// **'Length required'**
  String get error_length_required;

  /// No description provided for @error_length_required_desc.
  ///
  /// In en, this message translates to:
  /// **'The request must specify the content length'**
  String get error_length_required_desc;

  /// No description provided for @error_precondition_failed.
  ///
  /// In en, this message translates to:
  /// **'Precondition failed'**
  String get error_precondition_failed;

  /// No description provided for @error_precondition_failed_desc.
  ///
  /// In en, this message translates to:
  /// **'One or more preconditions failed'**
  String get error_precondition_failed_desc;

  /// No description provided for @error_payload_too_large.
  ///
  /// In en, this message translates to:
  /// **'Payload too large'**
  String get error_payload_too_large;

  /// No description provided for @error_payload_too_large_desc.
  ///
  /// In en, this message translates to:
  /// **'The request payload is too large'**
  String get error_payload_too_large_desc;

  /// No description provided for @error_uri_too_long.
  ///
  /// In en, this message translates to:
  /// **'URI too long'**
  String get error_uri_too_long;

  /// No description provided for @error_uri_too_long_desc.
  ///
  /// In en, this message translates to:
  /// **'The request URI is too long'**
  String get error_uri_too_long_desc;

  /// No description provided for @error_unsupported_media_type.
  ///
  /// In en, this message translates to:
  /// **'Unsupported media type'**
  String get error_unsupported_media_type;

  /// No description provided for @error_unsupported_media_type_desc.
  ///
  /// In en, this message translates to:
  /// **'The media type is not supported'**
  String get error_unsupported_media_type_desc;

  /// No description provided for @error_range_not_satisfiable.
  ///
  /// In en, this message translates to:
  /// **'Range not satisfiable'**
  String get error_range_not_satisfiable;

  /// No description provided for @error_range_not_satisfiable_desc.
  ///
  /// In en, this message translates to:
  /// **'The requested range cannot be satisfied'**
  String get error_range_not_satisfiable_desc;

  /// No description provided for @error_expectation_failed.
  ///
  /// In en, this message translates to:
  /// **'Expectation failed'**
  String get error_expectation_failed;

  /// No description provided for @error_expectation_failed_desc.
  ///
  /// In en, this message translates to:
  /// **'The expectation given in the request header field could not be met'**
  String get error_expectation_failed_desc;

  /// No description provided for @error_too_many_requests.
  ///
  /// In en, this message translates to:
  /// **'Too many requests'**
  String get error_too_many_requests;

  /// No description provided for @error_too_many_requests_desc.
  ///
  /// In en, this message translates to:
  /// **'You have sent too many requests. Please try again later'**
  String get error_too_many_requests_desc;

  /// No description provided for @error_unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown error'**
  String get error_unknown;

  /// No description provided for @error_unknown_desc.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred. Please try again'**
  String get error_unknown_desc;

  /// No description provided for @error_cancelled.
  ///
  /// In en, this message translates to:
  /// **'Request cancelled'**
  String get error_cancelled;

  /// No description provided for @error_cancelled_desc.
  ///
  /// In en, this message translates to:
  /// **'The request was cancelled'**
  String get error_cancelled_desc;

  /// No description provided for @error_other.
  ///
  /// In en, this message translates to:
  /// **'Error occurred'**
  String get error_other;

  /// No description provided for @error_other_desc.
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Please try again'**
  String get error_other_desc;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @contact_support.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get contact_support;

  /// No description provided for @check_connection.
  ///
  /// In en, this message translates to:
  /// **'Check your internet connection'**
  String get check_connection;

  /// No description provided for @go_back.
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get go_back;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'DermaAI'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Your Skin Health Companion'**
  String get appTagline;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'AI Skin Analysis'**
  String get onboardingTitle1;

  /// No description provided for @onboardingDesc1.
  ///
  /// In en, this message translates to:
  /// **'Get an instant analysis of your skin condition using advanced AI techniques'**
  String get onboardingDesc1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Consult Certified Dermatologists'**
  String get onboardingTitle2;

  /// No description provided for @onboardingDesc2.
  ///
  /// In en, this message translates to:
  /// **'Connect with specialized dermatologists for reliable medical advice'**
  String get onboardingDesc2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'Personalized Treatment Plans'**
  String get onboardingTitle3;

  /// No description provided for @onboardingDesc3.
  ///
  /// In en, this message translates to:
  /// **'Receive customized treatment recommendations tailored to your skin type and condition'**
  String get onboardingDesc3;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @signInToContinue.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue to DermaAI'**
  String get signInToContinue;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterEmail;

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

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterPassword;

  /// No description provided for @pleaseEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get pleaseEnterPassword;

  /// No description provided for @passwordMustBe.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordMustBe;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'Or continue with'**
  String get orContinueWith;

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

  /// No description provided for @enterConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter confirm password'**
  String get enterConfirmPassword;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @signUpToGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Sign up to get started with DermaAI'**
  String get signUpToGetStarted;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @enterFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get enterFullName;

  /// No description provided for @pleaseEnterName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get pleaseEnterName;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @confirmYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get confirmYourPassword;

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

  /// No description provided for @iAgreeToThe.
  ///
  /// In en, this message translates to:
  /// **'I agree to the'**
  String get iAgreeToThe;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @pleaseAcceptTerms.
  ///
  /// In en, this message translates to:
  /// **'Please accept the terms and conditions'**
  String get pleaseAcceptTerms;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @createNewAccount.
  ///
  /// In en, this message translates to:
  /// **'Create New Account'**
  String get createNewAccount;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and we\'ll send you a verification code to reset your password'**
  String get forgotPasswordSubtitle;

  /// No description provided for @sendVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Send Verification Code'**
  String get sendVerificationCode;

  /// No description provided for @rememberPassword.
  ///
  /// In en, this message translates to:
  /// **'Remember your password?'**
  String get rememberPassword;

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to Login'**
  String get backToLogin;

  /// No description provided for @resetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPasswordTitle;

  /// No description provided for @verifyCodeTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify Code'**
  String get verifyCodeTitle;

  /// No description provided for @enterCodeSentTo.
  ///
  /// In en, this message translates to:
  /// **'Enter the verification code sent to'**
  String get enterCodeSentTo;

  /// No description provided for @verifyCodeButton.
  ///
  /// In en, this message translates to:
  /// **'Verify Code'**
  String get verifyCodeButton;

  /// No description provided for @didNotReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code?'**
  String get didNotReceiveCode;

  /// No description provided for @resendCodeButton.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resendCodeButton;

  /// No description provided for @createNewPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Create New Password'**
  String get createNewPasswordTitle;

  /// No description provided for @enterNewPasswordFor.
  ///
  /// In en, this message translates to:
  /// **'Enter a new password for your account'**
  String get enterNewPasswordFor;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @enterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter new password'**
  String get enterNewPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmNewPassword;

  /// No description provided for @reEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Re-enter password'**
  String get reEnterPassword;

  /// No description provided for @resetPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPasswordButton;

  /// No description provided for @passwordRequirements.
  ///
  /// In en, this message translates to:
  /// **'Password Requirements:'**
  String get passwordRequirements;

  /// No description provided for @atLeast8Characters.
  ///
  /// In en, this message translates to:
  /// **'At least 8 characters'**
  String get atLeast8Characters;

  /// No description provided for @upperLowerCase.
  ///
  /// In en, this message translates to:
  /// **'Upper and lower case letters'**
  String get upperLowerCase;

  /// No description provided for @atLeastOneNumber.
  ///
  /// In en, this message translates to:
  /// **'At least one number'**
  String get atLeastOneNumber;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get enterPhoneNumber;

  /// No description provided for @pleaseEnterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter phone number'**
  String get pleaseEnterPhoneNumber;

  /// No description provided for @pleaseEnterValidPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get pleaseEnterValidPhoneNumber;

  /// No description provided for @welcomeToDermaAI.
  ///
  /// In en, this message translates to:
  /// **'join us and start your skin care journey'**
  String get welcomeToDermaAI;

  /// No description provided for @accountVerification.
  ///
  /// In en, this message translates to:
  /// **'Account Verification'**
  String get accountVerification;

  /// No description provided for @verifyOtpCode.
  ///
  /// In en, this message translates to:
  /// **'Verify OTP Code'**
  String get verifyOtpCode;

  /// No description provided for @otpSentToEmail.
  ///
  /// In en, this message translates to:
  /// **'Verification code sent to your email'**
  String get otpSentToEmail;

  /// No description provided for @otpSentToPhone.
  ///
  /// In en, this message translates to:
  /// **'Verification code sent to your phone'**
  String get otpSentToPhone;

  /// No description provided for @emailVerification.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailVerification;

  /// No description provided for @phoneVerification.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phoneVerification;

  /// No description provided for @verifyCode.
  ///
  /// In en, this message translates to:
  /// **'Verify Code'**
  String get verifyCode;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get resendCode;

  /// No description provided for @codeValidFor5Minutes.
  ///
  /// In en, this message translates to:
  /// **'Code is valid for 5 minutes only'**
  String get codeValidFor5Minutes;

  /// No description provided for @helloUser.
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}!'**
  String helloUser(Object name);

  /// No description provided for @findYourDoctor.
  ///
  /// In en, this message translates to:
  /// **'Find Your Doctor'**
  String get findYourDoctor;

  /// No description provided for @howCanWeHelp.
  ///
  /// In en, this message translates to:
  /// **'How can we help your skin today?'**
  String get howCanWeHelp;

  /// No description provided for @skinHelpPrompt.
  ///
  /// In en, this message translates to:
  /// **'How can we help your skin today?'**
  String get skinHelpPrompt;

  /// No description provided for @aiSkinDiagnosis.
  ///
  /// In en, this message translates to:
  /// **'AI Skin Diagnosis'**
  String get aiSkinDiagnosis;

  /// No description provided for @takeSkinPhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a photo of your skin condition and get an instant AI-powered diagnosis'**
  String get takeSkinPhoto;

  /// No description provided for @startDiagnosis.
  ///
  /// In en, this message translates to:
  /// **'Start Diagnosis'**
  String get startDiagnosis;

  /// No description provided for @quickAccess.
  ///
  /// In en, this message translates to:
  /// **'Quick Access'**
  String get quickAccess;

  /// No description provided for @findDoctors.
  ///
  /// In en, this message translates to:
  /// **'Find Doctors'**
  String get findDoctors;

  /// No description provided for @appointments.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get appointments;

  /// No description provided for @myDiagnoses.
  ///
  /// In en, this message translates to:
  /// **'My Diagnoses'**
  String get myDiagnoses;

  /// No description provided for @skinTips.
  ///
  /// In en, this message translates to:
  /// **'Skin Tips'**
  String get skinTips;

  /// No description provided for @topDermatologists.
  ///
  /// In en, this message translates to:
  /// **'Top Dermatologists'**
  String get topDermatologists;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @recentDiagnoses.
  ///
  /// In en, this message translates to:
  /// **'Recent Diagnoses'**
  String get recentDiagnoses;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @symptoms.
  ///
  /// In en, this message translates to:
  /// **'Symptoms'**
  String get symptoms;

  /// No description provided for @treatments.
  ///
  /// In en, this message translates to:
  /// **'Treatments'**
  String get treatments;

  /// No description provided for @high.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get high;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @low.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get low;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @diagnosisDescription.
  ///
  /// In en, this message translates to:
  /// **'Take or upload a photo of your skin condition for instant AI analysis and treatment recommendations.'**
  String get diagnosisDescription;

  /// No description provided for @aiPoweredSkinDiagnosis.
  ///
  /// In en, this message translates to:
  /// **'AI-Powered Skin Diagnosis'**
  String get aiPoweredSkinDiagnosis;

  /// No description provided for @uploadOrTakePhoto.
  ///
  /// In en, this message translates to:
  /// **'Upload or Take a Photo'**
  String get uploadOrTakePhoto;

  /// No description provided for @photoGuidelines.
  ///
  /// In en, this message translates to:
  /// **'For accurate diagnosis, ensure the photo is clear, well-lit, and focused on the affected area.'**
  String get photoGuidelines;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get takePhoto;

  /// No description provided for @uploadPhoto.
  ///
  /// In en, this message translates to:
  /// **'Upload Photo'**
  String get uploadPhoto;

  /// No description provided for @analyzingSkinCondition.
  ///
  /// In en, this message translates to:
  /// **'Analyzing your skin condition...'**
  String get analyzingSkinCondition;

  /// No description provided for @changePhoto.
  ///
  /// In en, this message translates to:
  /// **'Change Photo'**
  String get changePhoto;

  /// No description provided for @analyze.
  ///
  /// In en, this message translates to:
  /// **'Analyze'**
  String get analyze;

  /// No description provided for @diagnosisResult.
  ///
  /// In en, this message translates to:
  /// **'Diagnosis Result'**
  String get diagnosisResult;

  /// No description provided for @similarCases.
  ///
  /// In en, this message translates to:
  /// **'Similar Cases'**
  String get similarCases;

  /// No description provided for @saveToMyRecords.
  ///
  /// In en, this message translates to:
  /// **'Save to My Records'**
  String get saveToMyRecords;

  /// No description provided for @diagnosisSaved.
  ///
  /// In en, this message translates to:
  /// **'Diagnosis saved to your records'**
  String get diagnosisSaved;

  /// No description provided for @shareWithDoctor.
  ///
  /// In en, this message translates to:
  /// **'Share with Doctor'**
  String get shareWithDoctor;

  /// No description provided for @aiDiagnosis.
  ///
  /// In en, this message translates to:
  /// **'AI Diagnosis'**
  String get aiDiagnosis;

  /// No description provided for @confidence.
  ///
  /// In en, this message translates to:
  /// **'Confidence'**
  String get confidence;

  /// No description provided for @diagnosedOn.
  ///
  /// In en, this message translates to:
  /// **'Diagnosed on'**
  String get diagnosedOn;

  /// No description provided for @imageAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Image Analysis'**
  String get imageAnalysis;

  /// No description provided for @commonSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Common Symptoms'**
  String get commonSymptoms;

  /// No description provided for @recommendedTreatments.
  ///
  /// In en, this message translates to:
  /// **'Recommended Treatments'**
  String get recommendedTreatments;

  /// No description provided for @aiDisclaimerMessage.
  ///
  /// In en, this message translates to:
  /// **'This is an AI-generated diagnosis. Please consult with a dermatologist for professional medical advice.'**
  String get aiDisclaimerMessage;

  /// No description provided for @bookAppointmentWithDermatologist.
  ///
  /// In en, this message translates to:
  /// **'Book Appointment with Dermatologist'**
  String get bookAppointmentWithDermatologist;

  /// No description provided for @lowSeverity.
  ///
  /// In en, this message translates to:
  /// **'Low Severity'**
  String get lowSeverity;

  /// No description provided for @mediumSeverity.
  ///
  /// In en, this message translates to:
  /// **'Medium Severity'**
  String get mediumSeverity;

  /// No description provided for @highSeverity.
  ///
  /// In en, this message translates to:
  /// **'High Severity'**
  String get highSeverity;

  /// No description provided for @unknownSeverity.
  ///
  /// In en, this message translates to:
  /// **'Unknown Severity'**
  String get unknownSeverity;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @unavailable.
  ///
  /// In en, this message translates to:
  /// **'Unavailable'**
  String get unavailable;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @experience.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get experience;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get education;

  /// No description provided for @patientReviews.
  ///
  /// In en, this message translates to:
  /// **'Patient Reviews'**
  String get patientReviews;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @bookAppointment.
  ///
  /// In en, this message translates to:
  /// **'Book Appointment'**
  String get bookAppointment;

  /// No description provided for @pleaseSelectTimeSlot.
  ///
  /// In en, this message translates to:
  /// **'Please select a time slot'**
  String get pleaseSelectTimeSlot;

  /// No description provided for @appointmentBooked.
  ///
  /// In en, this message translates to:
  /// **'Appointment Booked'**
  String get appointmentBooked;

  /// No description provided for @doctor.
  ///
  /// In en, this message translates to:
  /// **'Doctor'**
  String get doctor;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @doctorConsultation.
  ///
  /// In en, this message translates to:
  /// **'Doctor Consultation'**
  String get doctorConsultation;

  /// No description provided for @skinCare.
  ///
  /// In en, this message translates to:
  /// **'Skin Care'**
  String get skinCare;

  /// No description provided for @healthTips.
  ///
  /// In en, this message translates to:
  /// **'Health Tips'**
  String get healthTips;

  /// No description provided for @ourServices.
  ///
  /// In en, this message translates to:
  /// **'Our Services'**
  String get ourServices;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @community.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get community;

  /// No description provided for @communityDescription.
  ///
  /// In en, this message translates to:
  /// **'Connect with dermatologists and share your experience'**
  String get communityDescription;

  /// No description provided for @posts.
  ///
  /// In en, this message translates to:
  /// **'Posts'**
  String get posts;

  /// No description provided for @trending.
  ///
  /// In en, this message translates to:
  /// **'Trending'**
  String get trending;

  /// No description provided for @following.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get following;

  /// No description provided for @communityStats.
  ///
  /// In en, this message translates to:
  /// **'Community Stats'**
  String get communityStats;

  /// No description provided for @members.
  ///
  /// In en, this message translates to:
  /// **'Members'**
  String get members;

  /// No description provided for @comments.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get comments;

  /// No description provided for @shares.
  ///
  /// In en, this message translates to:
  /// **'Shares'**
  String get shares;

  /// No description provided for @likes.
  ///
  /// In en, this message translates to:
  /// **'Likes'**
  String get likes;

  /// No description provided for @viewMore.
  ///
  /// In en, this message translates to:
  /// **'View More'**
  String get viewMore;

  /// No description provided for @viewLess.
  ///
  /// In en, this message translates to:
  /// **'View Less'**
  String get viewLess;

  /// No description provided for @savePost.
  ///
  /// In en, this message translates to:
  /// **'Save Post'**
  String get savePost;

  /// No description provided for @reportPost.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get reportPost;

  /// No description provided for @sharePost.
  ///
  /// In en, this message translates to:
  /// **'Share Post'**
  String get sharePost;

  /// No description provided for @postShared.
  ///
  /// In en, this message translates to:
  /// **'Post shared'**
  String get postShared;

  /// No description provided for @searchCommunity.
  ///
  /// In en, this message translates to:
  /// **'Search community...'**
  String get searchCommunity;

  /// No description provided for @latestPosts.
  ///
  /// In en, this message translates to:
  /// **'Latest Posts'**
  String get latestPosts;

  /// No description provided for @trendingHashtags.
  ///
  /// In en, this message translates to:
  /// **'Trending Hashtags'**
  String get trendingHashtags;

  /// No description provided for @newLabel.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newLabel;

  /// No description provided for @verifiedDoctor.
  ///
  /// In en, this message translates to:
  /// **'Verified Doctor'**
  String get verifiedDoctor;

  /// No description provided for @specialistDoctor.
  ///
  /// In en, this message translates to:
  /// **'Certified Specialist'**
  String get specialistDoctor;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @thisWeek.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get thisWeek;

  /// No description provided for @thisMonth.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get thisMonth;

  /// No description provided for @doctors.
  ///
  /// In en, this message translates to:
  /// **'Doctors'**
  String get doctors;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logoutConfirmationTitle.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get logoutConfirmationTitle;

  /// No description provided for @logoutConfirmationMessage.
  ///
  /// In en, this message translates to:
  /// **'Do you want to logout from your account?'**
  String get logoutConfirmationMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @logoutSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Logged out successfully'**
  String get logoutSuccessMessage;

  /// No description provided for @userLogin.
  ///
  /// In en, this message translates to:
  /// **'User Login'**
  String get userLogin;

  /// No description provided for @doctorLogin.
  ///
  /// In en, this message translates to:
  /// **'Doctor Login'**
  String get doctorLogin;

  /// No description provided for @userWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to DermaAI'**
  String get userWelcome;

  /// No description provided for @doctorWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Doctors Platform'**
  String get doctorWelcome;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @rememberMeError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while saving remember me data'**
  String get rememberMeError;

  /// No description provided for @doctorTitle.
  ///
  /// In en, this message translates to:
  /// **'Doctor'**
  String get doctorTitle;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @totalAppointments.
  ///
  /// In en, this message translates to:
  /// **'Total Appointments'**
  String get totalAppointments;

  /// No description provided for @newPatients.
  ///
  /// In en, this message translates to:
  /// **'New Patients'**
  String get newPatients;

  /// No description provided for @returnPatients.
  ///
  /// In en, this message translates to:
  /// **'Return Patients'**
  String get returnPatients;

  /// No description provided for @averageRating.
  ///
  /// In en, this message translates to:
  /// **'Average Rating'**
  String get averageRating;

  /// No description provided for @analytics.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get analytics;

  /// No description provided for @appointmentsStatus.
  ///
  /// In en, this message translates to:
  /// **'Appointments Status'**
  String get appointmentsStatus;

  /// No description provided for @consultationsGrowth.
  ///
  /// In en, this message translates to:
  /// **'Consultations Growth'**
  String get consultationsGrowth;

  /// No description provided for @skinConditionsDistribution.
  ///
  /// In en, this message translates to:
  /// **'Skin Conditions Distribution'**
  String get skinConditionsDistribution;

  /// No description provided for @upcomingAppointments.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Appointments'**
  String get upcomingAppointments;

  /// No description provided for @patients.
  ///
  /// In en, this message translates to:
  /// **'Patients'**
  String get patients;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @canceled.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get canceled;

  /// No description provided for @completedAppointments.
  ///
  /// In en, this message translates to:
  /// **'Completed Appointments'**
  String get completedAppointments;

  /// No description provided for @canceledAppointments.
  ///
  /// In en, this message translates to:
  /// **'Canceled Appointments'**
  String get canceledAppointments;

  /// No description provided for @searchPatients.
  ///
  /// In en, this message translates to:
  /// **'Search patients'**
  String get searchPatients;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// No description provided for @professionalInformation.
  ///
  /// In en, this message translates to:
  /// **'Professional Information'**
  String get professionalInformation;

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get accountSettings;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @privacySecurity.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security'**
  String get privacySecurity;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @helpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupport;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @speciality.
  ///
  /// In en, this message translates to:
  /// **'Speciality'**
  String get speciality;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @languages.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get languages;

  /// No description provided for @clinicLocation.
  ///
  /// In en, this message translates to:
  /// **'Clinic Location'**
  String get clinicLocation;

  /// No description provided for @dailyTip.
  ///
  /// In en, this message translates to:
  /// **'Daily Tip'**
  String get dailyTip;

  /// No description provided for @allHealthTips.
  ///
  /// In en, this message translates to:
  /// **'All Health Tips'**
  String get allHealthTips;

  /// No description provided for @medicalArticles.
  ///
  /// In en, this message translates to:
  /// **'Medical Articles'**
  String get medicalArticles;

  /// No description provided for @diseaseInformation.
  ///
  /// In en, this message translates to:
  /// **'Disease Information'**
  String get diseaseInformation;

  /// No description provided for @loadMore.
  ///
  /// In en, this message translates to:
  /// **'Load More'**
  String get loadMore;

  /// No description provided for @errorLoadingTips.
  ///
  /// In en, this message translates to:
  /// **'Error loading tips'**
  String get errorLoadingTips;

  /// No description provided for @noTipsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No tips available'**
  String get noTipsAvailable;

  /// No description provided for @readMore.
  ///
  /// In en, this message translates to:
  /// **'Read More'**
  String get readMore;

  /// No description provided for @readLess.
  ///
  /// In en, this message translates to:
  /// **'Read Less'**
  String get readLess;

  /// No description provided for @bookmark.
  ///
  /// In en, this message translates to:
  /// **'Bookmark'**
  String get bookmark;

  /// No description provided for @bookmarked.
  ///
  /// In en, this message translates to:
  /// **'Bookmarked'**
  String get bookmarked;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @tipShared.
  ///
  /// In en, this message translates to:
  /// **'Tip shared'**
  String get tipShared;

  /// No description provided for @sunProtection.
  ///
  /// In en, this message translates to:
  /// **'Sun Protection'**
  String get sunProtection;

  /// No description provided for @defaultTipDescription.
  ///
  /// In en, this message translates to:
  /// **'Use sunscreen daily even on cloudy days. UV rays penetrate clouds and cause skin damage.'**
  String get defaultTipDescription;

  /// No description provided for @skinCareRoutine.
  ///
  /// In en, this message translates to:
  /// **'Skin Care Routine'**
  String get skinCareRoutine;

  /// No description provided for @hydration.
  ///
  /// In en, this message translates to:
  /// **'Hydration'**
  String get hydration;

  /// No description provided for @nutrition.
  ///
  /// In en, this message translates to:
  /// **'Nutrition'**
  String get nutrition;

  /// No description provided for @sleepAndSkin.
  ///
  /// In en, this message translates to:
  /// **'Sleep and Skin'**
  String get sleepAndSkin;

  /// No description provided for @stressManagement.
  ///
  /// In en, this message translates to:
  /// **'Stress Management'**
  String get stressManagement;

  /// No description provided for @exerciseAndSkin.
  ///
  /// In en, this message translates to:
  /// **'Exercise and Skin'**
  String get exerciseAndSkin;

  /// No description provided for @skinProtection.
  ///
  /// In en, this message translates to:
  /// **'Skin Protection'**
  String get skinProtection;

  /// No description provided for @naturalRemedies.
  ///
  /// In en, this message translates to:
  /// **'Natural Remedies'**
  String get naturalRemedies;

  /// No description provided for @skinTypes.
  ///
  /// In en, this message translates to:
  /// **'Skin Types'**
  String get skinTypes;

  /// No description provided for @commonSkinProblems.
  ///
  /// In en, this message translates to:
  /// **'Common Skin Problems'**
  String get commonSkinProblems;

  /// No description provided for @seasonalSkinCare.
  ///
  /// In en, this message translates to:
  /// **'Seasonal Skin Care'**
  String get seasonalSkinCare;

  /// No description provided for @antiAging.
  ///
  /// In en, this message translates to:
  /// **'Anti-Aging'**
  String get antiAging;

  /// No description provided for @acneTreatment.
  ///
  /// In en, this message translates to:
  /// **'Acne Treatment'**
  String get acneTreatment;

  /// No description provided for @sensitiveSkiCare.
  ///
  /// In en, this message translates to:
  /// **'Sensitive Skin Care'**
  String get sensitiveSkiCare;

  /// No description provided for @skinHygiene.
  ///
  /// In en, this message translates to:
  /// **'Skin Hygiene'**
  String get skinHygiene;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @contactInformation.
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get contactInformation;

  /// No description provided for @emergencyContact.
  ///
  /// In en, this message translates to:
  /// **'Emergency Contact'**
  String get emergencyContact;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirth;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @nationality.
  ///
  /// In en, this message translates to:
  /// **'Nationality'**
  String get nationality;

  /// No description provided for @emergencyContactName.
  ///
  /// In en, this message translates to:
  /// **'Emergency Contact Name'**
  String get emergencyContactName;

  /// No description provided for @emergencyContactPhone.
  ///
  /// In en, this message translates to:
  /// **'Emergency Contact Phone'**
  String get emergencyContactPhone;

  /// No description provided for @emergencyContactRelationship.
  ///
  /// In en, this message translates to:
  /// **'Relationship'**
  String get emergencyContactRelationship;

  /// No description provided for @timezone.
  ///
  /// In en, this message translates to:
  /// **'Timezone'**
  String get timezone;

  /// No description provided for @languagePreference.
  ///
  /// In en, this message translates to:
  /// **'Language Preference'**
  String get languagePreference;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get arabic;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @profileUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Profile update failed'**
  String get profileUpdateFailed;

  /// No description provided for @profileUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdatedSuccessfully;

  /// No description provided for @changeProfilePicture.
  ///
  /// In en, this message translates to:
  /// **'Change Profile Picture'**
  String get changeProfilePicture;

  /// No description provided for @uploadPicture.
  ///
  /// In en, this message translates to:
  /// **'Upload Picture'**
  String get uploadPicture;

  /// No description provided for @deletePicture.
  ///
  /// In en, this message translates to:
  /// **'Delete Picture'**
  String get deletePicture;

  /// No description provided for @chooseImageSource.
  ///
  /// In en, this message translates to:
  /// **'Choose Image Source'**
  String get chooseImageSource;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @pictureUploadedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Picture uploaded successfully'**
  String get pictureUploadedSuccessfully;

  /// No description provided for @pictureDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Picture deleted successfully'**
  String get pictureDeletedSuccessfully;

  /// No description provided for @pictureUploadFailed.
  ///
  /// In en, this message translates to:
  /// **'Picture upload failed'**
  String get pictureUploadFailed;

  /// No description provided for @pictureDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Picture delete failed'**
  String get pictureDeleteFailed;

  /// No description provided for @confirmDeletePicture.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete your profile picture?'**
  String get confirmDeletePicture;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @pleaseSelectDateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Please select date of birth'**
  String get pleaseSelectDateOfBirth;

  /// No description provided for @pleaseSelectGender.
  ///
  /// In en, this message translates to:
  /// **'Please select gender'**
  String get pleaseSelectGender;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// No description provided for @selectGender.
  ///
  /// In en, this message translates to:
  /// **'Select Gender'**
  String get selectGender;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @medicalLicenseNumber.
  ///
  /// In en, this message translates to:
  /// **'Medical License Number'**
  String get medicalLicenseNumber;

  /// No description provided for @enterMedicalLicenseNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter medical license number'**
  String get enterMedicalLicenseNumber;

  /// No description provided for @pleaseEnterMedicalLicenseNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter medical license number'**
  String get pleaseEnterMedicalLicenseNumber;

  /// No description provided for @invalidLicenseFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid format. Use: MED-12345-2025'**
  String get invalidLicenseFormat;

  /// No description provided for @licenseYearCannotBeFuture.
  ///
  /// In en, this message translates to:
  /// **'License year cannot be in the future'**
  String get licenseYearCannotBeFuture;

  /// No description provided for @licenseTooOld.
  ///
  /// In en, this message translates to:
  /// **'License is too old'**
  String get licenseTooOld;

  /// No description provided for @loadingData.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loadingData;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @dataLoadError.
  ///
  /// In en, this message translates to:
  /// **'Error loading data'**
  String get dataLoadError;

  /// No description provided for @retryButton.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryButton;

  /// No description provided for @patientId.
  ///
  /// In en, this message translates to:
  /// **'Patient ID'**
  String get patientId;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @notSpecified.
  ///
  /// In en, this message translates to:
  /// **'Not Specified'**
  String get notSpecified;

  /// No description provided for @notAvailable.
  ///
  /// In en, this message translates to:
  /// **'Not Available'**
  String get notAvailable;

  /// No description provided for @recentAppointments.
  ///
  /// In en, this message translates to:
  /// **'Recent Appointments'**
  String get recentAppointments;

  /// No description provided for @viewAllButton.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAllButton;

  /// No description provided for @videoCall.
  ///
  /// In en, this message translates to:
  /// **'Video Call'**
  String get videoCall;

  /// No description provided for @clinicVisit.
  ///
  /// In en, this message translates to:
  /// **'Clinic Visit'**
  String get clinicVisit;

  /// No description provided for @personalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInfo;

  /// No description provided for @myAppointments.
  ///
  /// In en, this message translates to:
  /// **'My Appointments'**
  String get myAppointments;

  /// No description provided for @savedDoctors.
  ///
  /// In en, this message translates to:
  /// **'Saved Doctors'**
  String get savedDoctors;

  /// No description provided for @appointmentsCount.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get appointmentsCount;

  /// No description provided for @ratingsCount.
  ///
  /// In en, this message translates to:
  /// **'Ratings'**
  String get ratingsCount;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @accountSection.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get accountSection;

  /// No description provided for @editProfileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Update your personal information'**
  String get editProfileSubtitle;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @changePasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Update your password'**
  String get changePasswordSubtitle;

  /// No description provided for @changeEmail.
  ///
  /// In en, this message translates to:
  /// **'Change Email'**
  String get changeEmail;

  /// No description provided for @changeEmailSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Update your email address'**
  String get changeEmailSubtitle;

  /// No description provided for @securitySection.
  ///
  /// In en, this message translates to:
  /// **'Security & Privacy'**
  String get securitySection;

  /// No description provided for @biometricAuth.
  ///
  /// In en, this message translates to:
  /// **'Biometric Authentication'**
  String get biometricAuth;

  /// No description provided for @biometricAuthSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use fingerprint or face recognition'**
  String get biometricAuthSubtitle;

  /// No description provided for @locationServices.
  ///
  /// In en, this message translates to:
  /// **'Location Services'**
  String get locationServices;

  /// No description provided for @locationServicesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Allow access to your location'**
  String get locationServicesSubtitle;

  /// No description provided for @privacyPolicySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Read our privacy policy'**
  String get privacyPolicySubtitle;

  /// No description provided for @termsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get termsOfUse;

  /// No description provided for @termsOfUseSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Review terms and conditions'**
  String get termsOfUseSubtitle;

  /// No description provided for @appearanceSection.
  ///
  /// In en, this message translates to:
  /// **'Appearance & Language'**
  String get appearanceSection;

  /// No description provided for @languageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose app language'**
  String get languageSubtitle;

  /// No description provided for @themeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose app theme'**
  String get themeSubtitle;

  /// No description provided for @fontSize.
  ///
  /// In en, this message translates to:
  /// **'Font Size'**
  String get fontSize;

  /// No description provided for @fontSizeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Customize text size'**
  String get fontSizeSubtitle;

  /// No description provided for @supportSection.
  ///
  /// In en, this message translates to:
  /// **'Support & Help'**
  String get supportSection;

  /// No description provided for @helpCenter.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get helpCenter;

  /// No description provided for @helpCenterSubtitle.
  ///
  /// In en, this message translates to:
  /// **'FAQs and help'**
  String get helpCenterSubtitle;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @contactUsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get help from support team'**
  String get contactUsSubtitle;

  /// No description provided for @reportProblem.
  ///
  /// In en, this message translates to:
  /// **'Report a Problem'**
  String get reportProblem;

  /// No description provided for @reportProblemSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tell us about any issues'**
  String get reportProblemSubtitle;

  /// No description provided for @rateApp.
  ///
  /// In en, this message translates to:
  /// **'Rate App'**
  String get rateApp;

  /// No description provided for @rateAppSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Rate your experience'**
  String get rateAppSubtitle;

  /// No description provided for @aboutSection.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutSection;

  /// No description provided for @appInfo.
  ///
  /// In en, this message translates to:
  /// **'App Information'**
  String get appInfo;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get appVersion;

  /// No description provided for @updatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Updates'**
  String get updatesTitle;

  /// No description provided for @updatesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Check for new updates'**
  String get updatesSubtitle;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @logoutDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutDialogTitle;

  /// No description provided for @logoutDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout from your account?'**
  String get logoutDialogMessage;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @doctorAccountVerification.
  ///
  /// In en, this message translates to:
  /// **'Doctor Account Verification'**
  String get doctorAccountVerification;

  /// No description provided for @verifyDoctorAccount.
  ///
  /// In en, this message translates to:
  /// **'Verify Your Account'**
  String get verifyDoctorAccount;

  /// No description provided for @otpSentToEmailDoctor.
  ///
  /// In en, this message translates to:
  /// **'Verification code sent to'**
  String get otpSentToEmailDoctor;

  /// No description provided for @resendOtp.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resendOtp;

  /// No description provided for @resendOtpIn.
  ///
  /// In en, this message translates to:
  /// **'Resend in'**
  String get resendOtpIn;

  /// No description provided for @seconds.
  ///
  /// In en, this message translates to:
  /// **'seconds'**
  String get seconds;

  /// No description provided for @canResendIn.
  ///
  /// In en, this message translates to:
  /// **'You can resend in'**
  String get canResendIn;

  /// No description provided for @codeValidForMinutes.
  ///
  /// In en, this message translates to:
  /// **'Code is valid for 5 minutes only'**
  String get codeValidForMinutes;

  /// No description provided for @otpVerificationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Account verified successfully'**
  String get otpVerificationSuccess;

  /// No description provided for @otpResendSuccess.
  ///
  /// In en, this message translates to:
  /// **'Verification code sent successfully'**
  String get otpResendSuccess;
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
    'that was used.',
  );
}
