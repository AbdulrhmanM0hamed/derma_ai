// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'app_colors.dart';

// class AppTheme {
//   static ThemeData get lightTheme {
//     return ThemeData(
//       useMaterial3: true,
//       colorScheme: ColorScheme.fromSeed(
//         seedColor: AppColors.primary,
//         primary: AppColors.primary,
//         onPrimary: Colors.white,
//         secondary: AppColors.secondary,
//         onSecondary: Colors.white,
//         tertiary: AppColors.accent,
//         onTertiary: Colors.white,
//         background: AppColors.background,
//         surface: AppColors.surface,
//         error: AppColors.error,
//       ),
//       scaffoldBackgroundColor: AppColors.background,
//       appBarTheme: const AppBarTheme(
//         backgroundColor: AppColors.surface,
//         elevation: 0,
//         centerTitle: true,
//         iconTheme: IconThemeData(color: AppColors.textPrimary),
//         titleTextStyle: TextStyle(
//           color: AppColors.textPrimary,
//           fontSize: 18,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//       textTheme: GoogleFonts.poppinsTextTheme().copyWith(
//         displayLarge: GoogleFonts.poppins(
//           fontSize: 32,
//           fontWeight: FontWeight.bold,
//           color: AppColors.textPrimary,
//         ),
//         displayMedium: GoogleFonts.poppins(
//           fontSize: 28,
//           fontWeight: FontWeight.bold,
//           color: AppColors.textPrimary,
//         ),
//         displaySmall: GoogleFonts.poppins(
//           fontSize: 24,
//           fontWeight: FontWeight.bold,
//           color: AppColors.textPrimary,
//         ),
//         headlineMedium: GoogleFonts.poppins(
//           fontSize: 20,
//           fontWeight: FontWeight.w600,
//           color: AppColors.textPrimary,
//         ),
//         headlineSmall: GoogleFonts.poppins(
//           fontSize: 18,
//           fontWeight: FontWeight.w600,
//           color: AppColors.textPrimary,
//         ),
//         titleLarge: GoogleFonts.poppins(
//           fontSize: 16,
//           fontWeight: FontWeight.w600,
//           color: AppColors.textPrimary,
//         ),
//         titleMedium: GoogleFonts.poppins(
//           fontSize: 14,
//           fontWeight: FontWeight.w500,
//           color: AppColors.textPrimary,
//         ),
//         titleSmall: GoogleFonts.poppins(
//           fontSize: 12,
//           fontWeight: FontWeight.w500,
//           color: AppColors.textSecondary,
//         ),
//         bodyLarge: GoogleFonts.poppins(
//           fontSize: 16,
//           fontWeight: FontWeight.normal,
//           color: AppColors.textPrimary,
//         ),
//         bodyMedium: GoogleFonts.poppins(
//           fontSize: 14,
//           fontWeight: FontWeight.normal,
//           color: AppColors.textPrimary,
//         ),
//         bodySmall: GoogleFonts.poppins(
//           fontSize: 12,
//           fontWeight: FontWeight.normal,
//           color: AppColors.textSecondary,
//         ),
//         labelLarge: GoogleFonts.poppins(
//           fontSize: 14,
//           fontWeight: FontWeight.w500,
//           color: Colors.white,
//         ),
//       ),
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.primary,
//           foregroundColor: Colors.white,
//           elevation: 0,
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           textStyle: GoogleFonts.poppins(
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       outlinedButtonTheme: OutlinedButtonThemeData(
//         style: OutlinedButton.styleFrom(
//           foregroundColor: AppColors.primary,
//           side: const BorderSide(color: AppColors.primary, width: 1.5),
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           textStyle: GoogleFonts.poppins(
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       textButtonTheme: TextButtonThemeData(
//         style: TextButton.styleFrom(
//           foregroundColor: AppColors.primary,
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           textStyle: GoogleFonts.poppins(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: AppColors.border, width: 1),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: AppColors.border, width: 1),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: AppColors.error, width: 1),
//         ),
//         hintStyle: GoogleFonts.poppins(
//           fontSize: 14,
//           fontWeight: FontWeight.normal,
//           color: AppColors.textTertiary,
//         ),
//         labelStyle: GoogleFonts.poppins(
//           fontSize: 14,
//           fontWeight: FontWeight.normal,
//           color: AppColors.textSecondary,
//         ),
//       ),
//       cardTheme: CardTheme(
//         color: Colors.white,
//         elevation: 2,
//         shadowColor: Colors.black.withOpacity(0.05),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//       ),
//       dividerTheme: const DividerThemeData(
//         color: AppColors.divider,
//         thickness: 1,
//         space: 1,
//       ),
//       checkboxTheme: CheckboxThemeData(
//         fillColor: MaterialStateProperty.resolveWith<Color>(
//           (Set<MaterialState> states) {
//             if (states.contains(MaterialState.disabled)) {
//               return AppColors.textDisabled;
//             }
//             if (states.contains(MaterialState.selected)) {
//               return AppColors.primary;
//             }
//             return Colors.transparent;
//           },
//         ),
//         side: const BorderSide(color: AppColors.textTertiary),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(4),
//         ),
//       ),
//       radioTheme: RadioThemeData(
//         fillColor: MaterialStateProperty.resolveWith<Color>(
//           (Set<MaterialState> states) {
//             if (states.contains(MaterialState.disabled)) {
//               return AppColors.textDisabled;
//             }
//             if (states.contains(MaterialState.selected)) {
//               return AppColors.primary;
//             }
//             return AppColors.textTertiary;
//           },
//         ),
//       ),
//       switchTheme: SwitchThemeData(
//         thumbColor: MaterialStateProperty.resolveWith<Color>(
//           (Set<MaterialState> states) {
//             if (states.contains(MaterialState.disabled)) {
//               return AppColors.textDisabled;
//             }
//             if (states.contains(MaterialState.selected)) {
//               return AppColors.primary;
//             }
//             return Colors.white;
//           },
//         ),
//         trackColor: MaterialStateProperty.resolveWith<Color>(
//           (Set<MaterialState> states) {
//             if (states.contains(MaterialState.disabled)) {
//               return AppColors.textDisabled.withOpacity(0.5);
//             }
//             if (states.contains(MaterialState.selected)) {
//               return AppColors.primary.withOpacity(0.5);
//             }
//             return AppColors.textTertiary.withOpacity(0.5);
//           },
//         ),
//       ),
//       bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//         backgroundColor: Colors.white,
//         selectedItemColor: AppColors.primary,
//         unselectedItemColor: AppColors.textTertiary,
//         selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
//         unselectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
//         type: BottomNavigationBarType.fixed,
//         elevation: 8,
//       ),
//       tabBarTheme: const TabBarTheme(
//         labelColor: AppColors.primary,
//         unselectedLabelColor: AppColors.textTertiary,
//         indicatorColor: AppColors.primary,
//         labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//         unselectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//       ),
//       dialogTheme: DialogTheme(
//         backgroundColor: Colors.white,
//         elevation: 5,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       ),
//       bottomSheetTheme: const BottomSheetThemeData(
//         backgroundColor: Colors.white,
//         elevation: 5,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(24),
//             topRight: Radius.circular(24),
//           ),
//         ),
//       ),
//       snackBarTheme: SnackBarThemeData(
//         backgroundColor: AppColors.textPrimary,
//         contentTextStyle: GoogleFonts.poppins(
//           fontSize: 14,
//           fontWeight: FontWeight.normal,
//           color: Colors.white,
//         ),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         behavior: SnackBarBehavior.floating,
//       ),
//       progressIndicatorTheme: const ProgressIndicatorThemeData(
//         color: AppColors.primary,
//         circularTrackColor: AppColors.border,
//         linearTrackColor: AppColors.border,
//       ),
//       chipTheme: ChipThemeData(
//         backgroundColor: AppColors.background,
//         disabledColor: AppColors.textDisabled.withOpacity(0.1),
//         selectedColor: AppColors.primary.withOpacity(0.1),
//         secondarySelectedColor: AppColors.primary.withOpacity(0.1),
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         labelStyle: GoogleFonts.poppins(
//           fontSize: 12,
//           fontWeight: FontWeight.w500,
//           color: AppColors.textPrimary,
//         ),
//         secondaryLabelStyle: GoogleFonts.poppins(
//           fontSize: 12,
//           fontWeight: FontWeight.w500,
//           color: AppColors.primary,
//         ),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//     );
//   }

//   static ThemeData get darkTheme {
//     // For future implementation
//     return lightTheme;
//   }
// }