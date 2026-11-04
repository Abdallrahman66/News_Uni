//!Splash Screen Helper:

// 1- add package flutter_native_splash in pubspec.yaml_/

// 2- prepare splash image (Android + iOS)
//    - assets/icons/splash.png
//    - PNG
//    - no transparency (background included)
//    - centered logo

// 3- Android 12 splash design (Figma)
//    - frame: 640x640 (radius 320)
//    - center the icon
//    - wrap inside frame 960x960
//    - export as: splash_android_12.png

// 4- create file: flutter_native_splash.yaml

// flutter_native_splash:
//   color: "#5F33E1"
//   image: assets/icons/splash.png

//   android_12:
//     color: "#5F33E1"
//     image: assets/icons/splash_android_12.png

// 5- run command
// dart run flutter_native_splash:create --path=flutter_native_splash.yaml
////////////////////////////////////////////////////////////////////////////////

//!Icon launcher Helper:
// 1- add package flutter_launcher_icons in pubspec.yaml
// icons app logo
// 2- app IOS & Android:
// # size 1024x1024
// # PNG
// # no alpha (no transparency)
// # no rounded corners
// # example:
// assets/icons/app_icon.png

// write in pubspec.yaml
// dev_dependencies:
//   flutter_launcher_icons: ^0.13.1

// flutter_icons:
//   android: true
//   ios: true
//   image_path: "assets/icons/app_icon.png"
//   adaptive_icon_background: "#5F33E1"
//   adaptive_icon_foreground: "assets/icons/app_icon_logo.png"
//   remove_alpha_ios: true

// final run this
// flutter pub get
// dart run flutter_launcher_icons
