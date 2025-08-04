// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `DermaAI`
  String get appName {
    return Intl.message(
      'DermaAI',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Your Skin Health Companion`
  String get appTagline {
    return Intl.message(
      'Your Skin Health Companion',
      name: 'appTagline',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message(
      'Loading...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `AI Skin Analysis`
  String get onboardingTitle1 {
    return Intl.message(
      'AI Skin Analysis',
      name: 'onboardingTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Get an instant analysis of your skin condition using advanced AI techniques`
  String get onboardingDesc1 {
    return Intl.message(
      'Get an instant analysis of your skin condition using advanced AI techniques',
      name: 'onboardingDesc1',
      desc: '',
      args: [],
    );
  }

  /// `Consult Certified Dermatologists`
  String get onboardingTitle2 {
    return Intl.message(
      'Consult Certified Dermatologists',
      name: 'onboardingTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Connect with specialized dermatologists for reliable medical advice`
  String get onboardingDesc2 {
    return Intl.message(
      'Connect with specialized dermatologists for reliable medical advice',
      name: 'onboardingDesc2',
      desc: '',
      args: [],
    );
  }

  /// `Personalized Treatment Plans`
  String get onboardingTitle3 {
    return Intl.message(
      'Personalized Treatment Plans',
      name: 'onboardingTitle3',
      desc: '',
      args: [],
    );
  }

  /// `Receive customized treatment recommendations tailored to your skin type and condition`
  String get onboardingDesc3 {
    return Intl.message(
      'Receive customized treatment recommendations tailored to your skin type and condition',
      name: 'onboardingDesc3',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get previous {
    return Intl.message(
      'Previous',
      name: 'previous',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message(
      'Get Started',
      name: 'getStarted',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back`
  String get welcomeBack {
    return Intl.message(
      'Welcome Back',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to continue to DermaAI`
  String get signInToContinue {
    return Intl.message(
      'Sign in to continue to DermaAI',
      name: 'signInToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get enterEmail {
    return Intl.message(
      'Enter your email',
      name: 'enterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email`
  String get pleaseEnterEmail {
    return Intl.message(
      'Please enter your email',
      name: 'pleaseEnterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get pleaseEnterValidEmail {
    return Intl.message(
      'Please enter a valid email',
      name: 'pleaseEnterValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get enterPassword {
    return Intl.message(
      'Enter your password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get pleaseEnterPassword {
    return Intl.message(
      'Please enter your password',
      name: 'pleaseEnterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get passwordMustBe {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'passwordMustBe',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get rememberMe {
    return Intl.message(
      'Remember me',
      name: 'rememberMe',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Or continue with`
  String get orContinueWith {
    return Intl.message(
      'Or continue with',
      name: 'orContinueWith',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Enter confirm password`
  String get enterConfirmPassword {
    return Intl.message(
      'Enter confirm password',
      name: 'enterConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign up to get started with DermaAI`
  String get signUpToGetStarted {
    return Intl.message(
      'Sign up to get started with DermaAI',
      name: 'signUpToGetStarted',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Enter your full name`
  String get enterFullName {
    return Intl.message(
      'Enter your full name',
      name: 'enterFullName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your name`
  String get pleaseEnterName {
    return Intl.message(
      'Please enter your name',
      name: 'pleaseEnterName',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm your password`
  String get confirmYourPassword {
    return Intl.message(
      'Confirm your password',
      name: 'confirmYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your password`
  String get pleaseConfirmPassword {
    return Intl.message(
      'Please confirm your password',
      name: 'pleaseConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `I agree to the`
  String get iAgreeToThe {
    return Intl.message(
      'I agree to the',
      name: 'iAgreeToThe',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Service`
  String get termsOfService {
    return Intl.message(
      'Terms of Service',
      name: 'termsOfService',
      desc: '',
      args: [],
    );
  }

  /// `and`
  String get and {
    return Intl.message(
      'and',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Please accept the terms and conditions`
  String get pleaseAcceptTerms {
    return Intl.message(
      'Please accept the terms and conditions',
      name: 'pleaseAcceptTerms',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Create New Account`
  String get createNewAccount {
    return Intl.message(
      'Create New Account',
      name: 'createNewAccount',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPasswordTitle {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email and we'll send you a verification code to reset your password`
  String get forgotPasswordSubtitle {
    return Intl.message(
      'Enter your email and we\'ll send you a verification code to reset your password',
      name: 'forgotPasswordSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Send Verification Code`
  String get sendVerificationCode {
    return Intl.message(
      'Send Verification Code',
      name: 'sendVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Remember your password?`
  String get rememberPassword {
    return Intl.message(
      'Remember your password?',
      name: 'rememberPassword',
      desc: '',
      args: [],
    );
  }

  /// `Back to Login`
  String get backToLogin {
    return Intl.message(
      'Back to Login',
      name: 'backToLogin',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPasswordTitle {
    return Intl.message(
      'Reset Password',
      name: 'resetPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Verify Code`
  String get verifyCodeTitle {
    return Intl.message(
      'Verify Code',
      name: 'verifyCodeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter the verification code sent to`
  String get enterCodeSentTo {
    return Intl.message(
      'Enter the verification code sent to',
      name: 'enterCodeSentTo',
      desc: '',
      args: [],
    );
  }

  /// `Verify Code`
  String get verifyCodeButton {
    return Intl.message(
      'Verify Code',
      name: 'verifyCodeButton',
      desc: '',
      args: [],
    );
  }

  /// `Didn't receive the code?`
  String get didNotReceiveCode {
    return Intl.message(
      'Didn\'t receive the code?',
      name: 'didNotReceiveCode',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resendCodeButton {
    return Intl.message(
      'Resend',
      name: 'resendCodeButton',
      desc: '',
      args: [],
    );
  }

  /// `Create New Password`
  String get createNewPasswordTitle {
    return Intl.message(
      'Create New Password',
      name: 'createNewPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter a new password for your account`
  String get enterNewPasswordFor {
    return Intl.message(
      'Enter a new password for your account',
      name: 'enterNewPasswordFor',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter new password`
  String get enterNewPassword {
    return Intl.message(
      'Enter new password',
      name: 'enterNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmNewPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Re-enter password`
  String get reEnterPassword {
    return Intl.message(
      'Re-enter password',
      name: 'reEnterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPasswordButton {
    return Intl.message(
      'Reset Password',
      name: 'resetPasswordButton',
      desc: '',
      args: [],
    );
  }

  /// `Password Requirements:`
  String get passwordRequirements {
    return Intl.message(
      'Password Requirements:',
      name: 'passwordRequirements',
      desc: '',
      args: [],
    );
  }

  /// `At least 8 characters`
  String get atLeast8Characters {
    return Intl.message(
      'At least 8 characters',
      name: 'atLeast8Characters',
      desc: '',
      args: [],
    );
  }

  /// `Upper and lower case letters`
  String get upperLowerCase {
    return Intl.message(
      'Upper and lower case letters',
      name: 'upperLowerCase',
      desc: '',
      args: [],
    );
  }

  /// `At least one number`
  String get atLeastOneNumber {
    return Intl.message(
      'At least one number',
      name: 'atLeastOneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number`
  String get enterPhoneNumber {
    return Intl.message(
      'Enter your phone number',
      name: 'enterPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your phone number`
  String get pleaseEnterPhoneNumber {
    return Intl.message(
      'Please enter your phone number',
      name: 'pleaseEnterPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid phone number`
  String get pleaseEnterValidPhoneNumber {
    return Intl.message(
      'Please enter a valid phone number',
      name: 'pleaseEnterValidPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `join us and start your skin care journey`
  String get welcomeToDermaAI {
    return Intl.message(
      'join us and start your skin care journey',
      name: 'welcomeToDermaAI',
      desc: '',
      args: [],
    );
  }

  /// `Account Verification`
  String get accountVerification {
    return Intl.message(
      'Account Verification',
      name: 'accountVerification',
      desc: '',
      args: [],
    );
  }

  /// `Verify OTP Code`
  String get verifyOtpCode {
    return Intl.message(
      'Verify OTP Code',
      name: 'verifyOtpCode',
      desc: '',
      args: [],
    );
  }

  /// `Verification code sent to your email`
  String get otpSentToEmail {
    return Intl.message(
      'Verification code sent to your email',
      name: 'otpSentToEmail',
      desc: '',
      args: [],
    );
  }

  /// `Verification code sent to your phone`
  String get otpSentToPhone {
    return Intl.message(
      'Verification code sent to your phone',
      name: 'otpSentToPhone',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailVerification {
    return Intl.message(
      'Email',
      name: 'emailVerification',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phoneVerification {
    return Intl.message(
      'Phone',
      name: 'phoneVerification',
      desc: '',
      args: [],
    );
  }

  /// `Verify Code`
  String get verifyCode {
    return Intl.message(
      'Verify Code',
      name: 'verifyCode',
      desc: '',
      args: [],
    );
  }

  /// `Resend Code`
  String get resendCode {
    return Intl.message(
      'Resend Code',
      name: 'resendCode',
      desc: '',
      args: [],
    );
  }

  /// `Code is valid for 5 minutes only`
  String get codeValidFor5Minutes {
    return Intl.message(
      'Code is valid for 5 minutes only',
      name: 'codeValidFor5Minutes',
      desc: '',
      args: [],
    );
  }

  /// `Hello, {name}!`
  String helloUser(Object name) {
    return Intl.message(
      'Hello, $name!',
      name: 'helloUser',
      desc: '',
      args: [name],
    );
  }

  /// `Find Your Doctor`
  String get findYourDoctor {
    return Intl.message(
      'Find Your Doctor',
      name: 'findYourDoctor',
      desc: '',
      args: [],
    );
  }

  /// `How can we help your skin today?`
  String get howCanWeHelp {
    return Intl.message(
      'How can we help your skin today?',
      name: 'howCanWeHelp',
      desc: '',
      args: [],
    );
  }

  /// `How can we help your skin today?`
  String get skinHelpPrompt {
    return Intl.message(
      'How can we help your skin today?',
      name: 'skinHelpPrompt',
      desc: '',
      args: [],
    );
  }

  /// `AI Skin Diagnosis`
  String get aiSkinDiagnosis {
    return Intl.message(
      'AI Skin Diagnosis',
      name: 'aiSkinDiagnosis',
      desc: '',
      args: [],
    );
  }

  /// `Take a photo of your skin condition and get an instant AI-powered diagnosis`
  String get takeSkinPhoto {
    return Intl.message(
      'Take a photo of your skin condition and get an instant AI-powered diagnosis',
      name: 'takeSkinPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Start Diagnosis`
  String get startDiagnosis {
    return Intl.message(
      'Start Diagnosis',
      name: 'startDiagnosis',
      desc: '',
      args: [],
    );
  }

  /// `Quick Access`
  String get quickAccess {
    return Intl.message(
      'Quick Access',
      name: 'quickAccess',
      desc: '',
      args: [],
    );
  }

  /// `Find Doctors`
  String get findDoctors {
    return Intl.message(
      'Find Doctors',
      name: 'findDoctors',
      desc: '',
      args: [],
    );
  }

  /// `Appointments`
  String get appointments {
    return Intl.message(
      'Appointments',
      name: 'appointments',
      desc: '',
      args: [],
    );
  }

  /// `My Diagnoses`
  String get myDiagnoses {
    return Intl.message(
      'My Diagnoses',
      name: 'myDiagnoses',
      desc: '',
      args: [],
    );
  }

  /// `Skin Tips`
  String get skinTips {
    return Intl.message(
      'Skin Tips',
      name: 'skinTips',
      desc: '',
      args: [],
    );
  }

  /// `Top Dermatologists`
  String get topDermatologists {
    return Intl.message(
      'Top Dermatologists',
      name: 'topDermatologists',
      desc: '',
      args: [],
    );
  }

  /// `See All`
  String get seeAll {
    return Intl.message(
      'See All',
      name: 'seeAll',
      desc: '',
      args: [],
    );
  }

  /// `Recent Diagnoses`
  String get recentDiagnoses {
    return Intl.message(
      'Recent Diagnoses',
      name: 'recentDiagnoses',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Symptoms`
  String get symptoms {
    return Intl.message(
      'Symptoms',
      name: 'symptoms',
      desc: '',
      args: [],
    );
  }

  /// `Treatments`
  String get treatments {
    return Intl.message(
      'Treatments',
      name: 'treatments',
      desc: '',
      args: [],
    );
  }

  /// `High`
  String get high {
    return Intl.message(
      'High',
      name: 'high',
      desc: '',
      args: [],
    );
  }

  /// `Medium`
  String get medium {
    return Intl.message(
      'Medium',
      name: 'medium',
      desc: '',
      args: [],
    );
  }

  /// `Low`
  String get low {
    return Intl.message(
      'Low',
      name: 'low',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message(
      'Unknown',
      name: 'unknown',
      desc: '',
      args: [],
    );
  }

  /// `Take or upload a photo of your skin condition for instant AI analysis and treatment recommendations.`
  String get diagnosisDescription {
    return Intl.message(
      'Take or upload a photo of your skin condition for instant AI analysis and treatment recommendations.',
      name: 'diagnosisDescription',
      desc: '',
      args: [],
    );
  }

  /// `AI-Powered Skin Diagnosis`
  String get aiPoweredSkinDiagnosis {
    return Intl.message(
      'AI-Powered Skin Diagnosis',
      name: 'aiPoweredSkinDiagnosis',
      desc: '',
      args: [],
    );
  }

  /// `Upload or Take a Photo`
  String get uploadOrTakePhoto {
    return Intl.message(
      'Upload or Take a Photo',
      name: 'uploadOrTakePhoto',
      desc: '',
      args: [],
    );
  }

  /// `For accurate diagnosis, ensure the photo is clear, well-lit, and focused on the affected area.`
  String get photoGuidelines {
    return Intl.message(
      'For accurate diagnosis, ensure the photo is clear, well-lit, and focused on the affected area.',
      name: 'photoGuidelines',
      desc: '',
      args: [],
    );
  }

  /// `Take Photo`
  String get takePhoto {
    return Intl.message(
      'Take Photo',
      name: 'takePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Upload Photo`
  String get uploadPhoto {
    return Intl.message(
      'Upload Photo',
      name: 'uploadPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Analyzing your skin condition...`
  String get analyzingSkinCondition {
    return Intl.message(
      'Analyzing your skin condition...',
      name: 'analyzingSkinCondition',
      desc: '',
      args: [],
    );
  }

  /// `Change Photo`
  String get changePhoto {
    return Intl.message(
      'Change Photo',
      name: 'changePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Analyze`
  String get analyze {
    return Intl.message(
      'Analyze',
      name: 'analyze',
      desc: '',
      args: [],
    );
  }

  /// `Diagnosis Result`
  String get diagnosisResult {
    return Intl.message(
      'Diagnosis Result',
      name: 'diagnosisResult',
      desc: '',
      args: [],
    );
  }

  /// `Similar Cases`
  String get similarCases {
    return Intl.message(
      'Similar Cases',
      name: 'similarCases',
      desc: '',
      args: [],
    );
  }

  /// `Save to My Records`
  String get saveToMyRecords {
    return Intl.message(
      'Save to My Records',
      name: 'saveToMyRecords',
      desc: '',
      args: [],
    );
  }

  /// `Diagnosis saved to your records`
  String get diagnosisSaved {
    return Intl.message(
      'Diagnosis saved to your records',
      name: 'diagnosisSaved',
      desc: '',
      args: [],
    );
  }

  /// `Share with Doctor`
  String get shareWithDoctor {
    return Intl.message(
      'Share with Doctor',
      name: 'shareWithDoctor',
      desc: '',
      args: [],
    );
  }

  /// `AI Diagnosis`
  String get aiDiagnosis {
    return Intl.message(
      'AI Diagnosis',
      name: 'aiDiagnosis',
      desc: '',
      args: [],
    );
  }

  /// `Confidence`
  String get confidence {
    return Intl.message(
      'Confidence',
      name: 'confidence',
      desc: '',
      args: [],
    );
  }

  /// `Diagnosed on`
  String get diagnosedOn {
    return Intl.message(
      'Diagnosed on',
      name: 'diagnosedOn',
      desc: '',
      args: [],
    );
  }

  /// `Image Analysis`
  String get imageAnalysis {
    return Intl.message(
      'Image Analysis',
      name: 'imageAnalysis',
      desc: '',
      args: [],
    );
  }

  /// `Common Symptoms`
  String get commonSymptoms {
    return Intl.message(
      'Common Symptoms',
      name: 'commonSymptoms',
      desc: '',
      args: [],
    );
  }

  /// `Recommended Treatments`
  String get recommendedTreatments {
    return Intl.message(
      'Recommended Treatments',
      name: 'recommendedTreatments',
      desc: '',
      args: [],
    );
  }

  /// `This is an AI-generated diagnosis. Please consult with a dermatologist for professional medical advice.`
  String get aiDisclaimerMessage {
    return Intl.message(
      'This is an AI-generated diagnosis. Please consult with a dermatologist for professional medical advice.',
      name: 'aiDisclaimerMessage',
      desc: '',
      args: [],
    );
  }

  /// `Book Appointment with Dermatologist`
  String get bookAppointmentWithDermatologist {
    return Intl.message(
      'Book Appointment with Dermatologist',
      name: 'bookAppointmentWithDermatologist',
      desc: '',
      args: [],
    );
  }

  /// `Low Severity`
  String get lowSeverity {
    return Intl.message(
      'Low Severity',
      name: 'lowSeverity',
      desc: '',
      args: [],
    );
  }

  /// `Medium Severity`
  String get mediumSeverity {
    return Intl.message(
      'Medium Severity',
      name: 'mediumSeverity',
      desc: '',
      args: [],
    );
  }

  /// `High Severity`
  String get highSeverity {
    return Intl.message(
      'High Severity',
      name: 'highSeverity',
      desc: '',
      args: [],
    );
  }

  /// `Unknown Severity`
  String get unknownSeverity {
    return Intl.message(
      'Unknown Severity',
      name: 'unknownSeverity',
      desc: '',
      args: [],
    );
  }

  /// `Available`
  String get available {
    return Intl.message(
      'Available',
      name: 'available',
      desc: '',
      args: [],
    );
  }

  /// `Unavailable`
  String get unavailable {
    return Intl.message(
      'Unavailable',
      name: 'unavailable',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Experience`
  String get experience {
    return Intl.message(
      'Experience',
      name: 'experience',
      desc: '',
      args: [],
    );
  }

  /// `Reviews`
  String get reviews {
    return Intl.message(
      'Reviews',
      name: 'reviews',
      desc: '',
      args: [],
    );
  }

  /// `Services`
  String get services {
    return Intl.message(
      'Services',
      name: 'services',
      desc: '',
      args: [],
    );
  }

  /// `Education`
  String get education {
    return Intl.message(
      'Education',
      name: 'education',
      desc: '',
      args: [],
    );
  }

  /// `Patient Reviews`
  String get patientReviews {
    return Intl.message(
      'Patient Reviews',
      name: 'patientReviews',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get viewAll {
    return Intl.message(
      'View All',
      name: 'viewAll',
      desc: '',
      args: [],
    );
  }

  /// `Book Appointment`
  String get bookAppointment {
    return Intl.message(
      'Book Appointment',
      name: 'bookAppointment',
      desc: '',
      args: [],
    );
  }

  /// `Please select a time slot`
  String get pleaseSelectTimeSlot {
    return Intl.message(
      'Please select a time slot',
      name: 'pleaseSelectTimeSlot',
      desc: '',
      args: [],
    );
  }

  /// `Appointment Booked`
  String get appointmentBooked {
    return Intl.message(
      'Appointment Booked',
      name: 'appointmentBooked',
      desc: '',
      args: [],
    );
  }

  /// `Doctor`
  String get doctor {
    return Intl.message(
      'Doctor',
      name: 'doctor',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Doctor Consultation`
  String get doctorConsultation {
    return Intl.message(
      'Doctor Consultation',
      name: 'doctorConsultation',
      desc: '',
      args: [],
    );
  }

  /// `Skin Care`
  String get skinCare {
    return Intl.message(
      'Skin Care',
      name: 'skinCare',
      desc: '',
      args: [],
    );
  }

  /// `Health Tips`
  String get healthTips {
    return Intl.message(
      'Health Tips',
      name: 'healthTips',
      desc: '',
      args: [],
    );
  }

  /// `Our Services`
  String get ourServices {
    return Intl.message(
      'Our Services',
      name: 'ourServices',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Doctors`
  String get doctors {
    return Intl.message(
      'Doctors',
      name: 'doctors',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
