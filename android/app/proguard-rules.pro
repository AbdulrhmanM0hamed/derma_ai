# Flutter's desired ProGuard rules for release builds.
#
# You can learn more about configuring ProGuard here:
# https://developer.android.com/studio/build/shrink-code

# Keep all native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep Flutter and Dart related classes
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Keep camera plugin classes if using camera
-keep class io.flutter.plugins.camera.** { *; }

# Keep Google Play Core classes (for deferred components)
-keep class com.google.android.play.core.** { *; }
-keep class com.google.android.play.core.splitcompat.** { *; }
-keep class com.google.android.play.core.splitinstall.** { *; }
-keep class com.google.android.play.core.tasks.** { *; }

# Keep Flutter deferred components classes
-keep class io.flutter.embedding.engine.deferredcomponents.** { *; }

# Keep classes accessed via reflection
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes InnerClasses
-keepattributes EnclosingMethod

# Keep all classes that might be accessed via JNI
-keepclasseswithmembernames,includedescriptorclasses class * {
    native <methods>;
}

# Prevent obfuscation of classes with @Keep annotation
-keep @androidx.annotation.Keep class * { *; }
-keepclassmembers class * {
    @androidx.annotation.Keep *;
}

# General rule to prevent issues with missing classes
-dontwarn com.google.android.play.core.**
-dontwarn org.tensorflow.lite.gpu.**
