import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static final ImagePicker _picker = ImagePicker();

  /// Pick image from gallery
  static Future<File?> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (image != null) {
        final file = File(image.path);
        
        // Check file size (max 5MB)
        final fileSize = await file.length();
        if (fileSize > 5 * 1024 * 1024) {
          throw Exception('حجم الصورة يجب أن يكون أقل من 5 ميجابايت');
        }

        // Check file extension
        final extension = image.path.split('.').last.toLowerCase();
        if (!['jpg', 'jpeg', 'png', 'webp'].contains(extension)) {
          throw Exception('نوع الملف غير مدعوم. يرجى اختيار صورة بصيغة JPEG, PNG, أو WebP');
        }

        return file;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  /// Pick image from camera
  static Future<File?> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (image != null) {
        final file = File(image.path);
        
        // Check file size (max 5MB)
        final fileSize = await file.length();
        if (fileSize > 5 * 1024 * 1024) {
          throw Exception('حجم الصورة يجب أن يكون أقل من 5 ميجابايت');
        }

        return file;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  /// Show bottom sheet to choose image source
  static Future<File?> showImageSourceBottomSheet({
    required Function() onCameraPressed,
    required Function() onGalleryPressed,
  }) async {
    // This will be called from UI with actual bottom sheet
    return null;
  }
}
