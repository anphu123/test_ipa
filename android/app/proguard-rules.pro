# ML Kit Text Recognizer keep rules
-keep class com.google.mlkit.vision.text.** { *; }
-keep class com.google.mlkit.vision.text.chinese.** { *; }
-keep class com.google.mlkit.vision.text.devanagari.** { *; }
-keep class com.google.mlkit.vision.text.japanese.** { *; }
-keep class com.google.mlkit.vision.text.korean.** { *; }
# 👁️ ML Kit: giữ lại tất cả các recognizer options
-keep class com.google.mlkit.vision.text.** { *; }
-keep class com.google.mlkit.vision.text.latin.** { *; }
-keep class com.google.mlkit.vision.text.chinese.** { *; }
-keep class com.google.mlkit.vision.text.japanese.** { *; }
-keep class com.google.mlkit.vision.text.korean.** { *; }
-keep class com.google.mlkit.vision.text.devanagari.** { *; }

# 👁️ Giữ lại các option builder (nếu bạn gọi qua MethodChannel)
-keep class com.google.mlkit.vision.text.**$Builder { *; }

# 📷 InputImage class
-keep class com.google.mlkit.vision.common.** { *; }

# 🗺️ Google Maps keep rules
-keep class com.google.android.gms.maps.** { *; }
-keep interface com.google.android.gms.maps.** { *; }
-keep class com.google.android.gms.location.** { *; }
-keep class com.google.android.gms.common.** { *; }

# 🗺️ Google Maps Flutter plugin
-keep class io.flutter.plugins.googlemaps.** { *; }
-keep class com.google.maps.** { *; }