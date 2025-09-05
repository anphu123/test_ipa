import os

os.chdir(os.path.dirname(os.path.abspath(__file__)))

os.system("""
    flutter clean
    flutter pub get
    flutter pub run build_runner watch --delete-conflicting-outputs
    flutter pub run easy_localization:generate -f keys -O lib -o core/assets/locale_keys.g.dart --source-dir ./assets/translations
    flutter build apk --release --split-per-abi
    flutter build apk  --release -t lib/main.dart
    open ios/Runner.xcworkspace
    flutter build ios --release
    flutter install
""")




