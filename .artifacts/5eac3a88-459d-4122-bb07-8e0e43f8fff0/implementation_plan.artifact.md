# Improvement & ANR Fix Plan

This plan addresses the "App isn't responding" (ANR) issue and improves the code quality of the application. The primary cause of the ANR is likely the combination of a syntax error in the theme definition and an extremely large fixed-height layout in the splash screen, which can lead to layout calculation failures on different devices.

## User Review Required

> [!IMPORTANT]
> **Critical Fixes**:
> 1. **Syntax Error**: `main.dart` has a missing `ColorScheme` prefix in `ThemeData`.
> 2. **Layout Fix**: `SplashScreen` has a hardcoded `height: 800` for an image, which exceeds the screen height of many mobile devices, causing layout overflow and potential freezes.

## Proposed Changes

### Core Application (`lib/main.dart`)

#### [MODIFY] [main.dart](file:///C:/flutter/demo_app/lib/main.dart)
- **Fix Syntax Error**: Change `.fromSeed` to `ColorScheme.fromSeed`.
- **Enhance Theme**:
    - Set `useMaterial3: true`.
    - Use `GoogleFonts.montserratTextTheme()` instead of just `fontFamily` to ensure all text styles use the font correctly.
- **Clean Up**: Remove default Flutter template comments.

### UI Optimization (`lib/splash_screen.dart`)

#### [MODIFY] [splash_screen.dart](file:///C:/flutter/demo_app/lib/splash_screen.dart)
- **Fix Layout**: Remove the fixed `height: 800` from `SizedBox`. Use `Expanded` or `Center` to allow the image to scale naturally based on the device screen size.
- **Improve Navigation**: Ensure the `Future.delayed` navigation is handled safely.

### Project Configuration (`pubspec.yaml`)

#### [VERIFY] [pubspec.yaml](file:///C:/flutter/demo_app/pubspec.yaml)
- Ensure all assets (image1.png to image8.png) are correctly placed in the `assets/` folder as declared.

## Verification Plan

### Automated Tests
- Run `flutter analyze` to ensure the syntax error is resolved.
- Run `flutter build apk` (or similar) to verify the build process completes.

### Manual Verification
- Launch the app and verify the `SplashScreen` transitions to `ChooseProductScreen` after 2 seconds without hanging.
- Verify the font is applied correctly across the app.
