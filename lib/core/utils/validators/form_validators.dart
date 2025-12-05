import 'package:flutter/material.dart';

class FormValidators {
  // Private constructor to prevent instantiation
  FormValidators._();

  /// Validates email address format and requirements
  static String? validateEmail(String? value, BuildContext context) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter email';
    }

    final cleanValue = value.trim();

    // Check email format with comprehensive regex
    if (!_isValidEmailFormat(cleanValue)) {
      return 'Please enter a valid email';
    }

    // Check reasonable length
    if (cleanValue.length > _ValidationConstants.maxEmailLength) {
      return 'Email is too long';
    }

    return null;
  }

  /// Validates password strength and requirements
  static String? validatePassword(String? value, BuildContext context) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter password';
    }

    final cleanValue = value.trim();

    if (cleanValue.length < _ValidationConstants.minPasswordLength) {
      return 'Password must be at least 8 characters';
    }

    if (cleanValue.length > _ValidationConstants.maxPasswordLength) {
      return 'Password is too long';
    }

    // Check password strength
    final strength = _calculatePasswordStrength(cleanValue);
    if (strength < _ValidationConstants.minPasswordStrength) {
      return 'Password is too weak';
    }

    return null;
  }

  /// Validates password confirmation
  static String? validatePasswordConfirmation(
    String? value,
    String? originalPassword,
    BuildContext context,
  ) {
    if (value == null || value.trim().isEmpty) {
      return 'Please confirm password';
    }

    if (value.trim() != originalPassword?.trim()) {
      return 'Passwords do not match';
    }

    return null;
  }

  /// Validates full name
  static String? validateFullName(String? value, BuildContext context) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter full name';
    }

    final cleanValue = value.trim();

    if (cleanValue.length < _ValidationConstants.minNameLength) {
      return 'Name is too short';
    }

    if (cleanValue.length > _ValidationConstants.maxNameLength) {
      return 'Name is too long';
    }

    // Check if name contains only valid characters
    if (!_isValidNameFormat(cleanValue)) {
      return 'Invalid name format';
    }

    return null;
  }

  /// Validates phone number
  static String? validatePhoneNumber(String? value, BuildContext context) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter phone number';
    }

    final cleanValue = value.trim().replaceAll(RegExp(r'[\s\-\(\)]'), '');

    if (!_isValidPhoneFormat(cleanValue)) {
      return 'Invalid phone number';
    }

    return null;
  }

  /// Validates medical license number
  /// Format: MED-XXXXX-YYYY (e.g., MED-12345-2025)
  static String? validateMedicalLicenseNumber(
    String? value,
    BuildContext context,
  ) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter medical license number';
    }

    final cleanValue = value.trim().toUpperCase();

    // Check format: MED-XXXXX-YYYY
    if (!_isValidMedicalLicenseFormat(cleanValue)) {
      return 'Invalid format. Use: MED-12345-2025';
    }

    // Validate year is reasonable (not in future, not too old)
    final yearMatch = RegExp(r'MED-\d{5}-(\d{4})').firstMatch(cleanValue);
    if (yearMatch != null) {
      final year = int.parse(yearMatch.group(1)!);
      final currentYear = DateTime.now().year;

      if (year > currentYear) {
        return 'License year cannot be in the future';
      }

      if (year < currentYear - 50) {
        return 'License is too old';
      }
    }

    return null;
  }

  // Private helper methods
  static bool _isValidEmailFormat(String email) {
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      caseSensitive: false,
    ).hasMatch(email);
  }

  static bool _isValidNameFormat(String name) {
    return RegExp(r'^[a-zA-Z\u0600-\u06FF\s]+$').hasMatch(name);
  }

  static bool _isValidPhoneFormat(String phone) {
    return RegExp(r'^[+]?[0-9]{10,15}$').hasMatch(phone);
  }

  static bool _isValidMedicalLicenseFormat(String license) {
    // Format: MED-XXXXX-YYYY (5 digits, then 4 digit year)
    return RegExp(r'^MED-\d{5}-\d{4}$').hasMatch(license);
  }

  static int _calculatePasswordStrength(String password) {
    int strength = 0;

    if (password.contains(RegExp(r'[A-Z]'))) strength++;
    if (password.contains(RegExp(r'[a-z]'))) strength++;
    if (password.contains(RegExp(r'[0-9]'))) strength++;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength++;

    return strength;
  }
}

/// Constants for validation rules
class _ValidationConstants {
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 50;
  static const int minPasswordStrength = 2;
  static const int maxEmailLength = 125;
  static const int minNameLength = 2;
  static const int maxNameLength = 50;
}
