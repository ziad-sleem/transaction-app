# Media Query Implementation Guide

## Overview
This document explains how to use the enhanced `MQ` (Media Query) class for responsive design throughout the application. The `MQ` class provides a simple, consistent way to handle responsive sizing and breakpoints.

## Location
- File: `lib/core/constants/app_media_query.dart`

## Features

### 1. Screen Size Properties
```dart
final mq = MQ(context: context);

// Get screen dimensions
double height = mq.h;      // Screen height
double width = mq.w;       // Screen width
Size size = mq.size;       // Full size object
```

### 2. Responsive Breakpoints
Use these to detect device types and adjust layouts accordingly:

```dart
final mq = MQ(context: context);

if (mq.isMobile) {
  // Layout for mobile devices (< 600px width)
}

if (mq.isTablet) {
  // Layout for tablets (600-1200px width)
}

if (mq.isDesktop) {
  // Layout for desktop (>= 1200px width)
}

if (mq.isSmallMobile) {
  // Layout for short screens (< 600px height)
}

if (mq.isLargeMobile) {
  // Layout for tall screens (>= 600px height)
}
```

### 3. Predefined Responsive Heights
These provide commonly used height values as percentages of screen height:

```dart
final mq = MQ(context: context);

// Pre-configured height methods
SizedBox(height: mq.h1());    // 1% of screen height
SizedBox(height: mq.h2());    // 2% of screen height
SizedBox(height: mq.h3());    // 3% of screen height
SizedBox(height: mq.h5());    // 5% of screen height
SizedBox(height: mq.h10());   // 10% of screen height (default 0.1)
SizedBox(height: mq.h15());   // 15% of screen height
SizedBox(height: mq.h20());   // 20% of screen height

// You can customize multipliers
SizedBox(height: mq.h10(mobileMultiplier: 0.18));  // 18% of screen height
```

### 4. Predefined Responsive Widths
```dart
final mq = MQ(context: context);

SizedBox(width: mq.w5());     // 5% of screen width
SizedBox(width: mq.w10());    // 10% of screen width
SizedBox(width: mq.w15());    // 15% of screen width
SizedBox(width: mq.w20());    // 20% of screen width
SizedBox(width: mq.w50());    // 50% of screen width

// Customize multipliers
SizedBox(width: mq.w5(mobileMultiplier: 0.017));
```

### 5. Responsive Padding and Margins
```dart
final mq = MQ(context: context);

// Padding all sides
Padding(
  padding: mq.paddingAll(16),
  child: child,
)

// Symmetric padding
Padding(
  padding: mq.paddingSymmetric(horizontal: 16, vertical: 20),
  child: child,
)

// Custom padding
Padding(
  padding: mq.paddingOnly(top: 20, bottom: 10, left: 16, right: 16),
  child: child,
)
```

### 6. Responsive Font Sizes
```dart
final mq = MQ(context: context);

MyText(
  "Hello",
  fontSize: mq.fontSize(mobileSizeMultiplier: 1.2),  // Responsive text size
)
```

### 7. Custom Responsive Values
For any value that needs to be responsive based on device type:

```dart
final mq = MQ(context: context);

// Returns different values based on breakpoint
double value = mq.val(
  mobile: 16,      // For mobile devices
  tablet: 24,      // For tablets
  desktop: 32,     // For desktop
);
```

## Examples

### Before (Without MQ)
```dart
Widget build(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          SizedBox(height: size.height * 0.1),
          SizedBox(height: size.height * 0.18),
          SizedBox(height: size.height * 0.01),
          SizedBox(height: size.height * 0.02),
          SizedBox(width: size.width * 0.05),
        ],
      ),
    ),
  );
}
```

### After (With MQ)
```dart
Widget build(BuildContext context) {
  final mq = MQ(context: context);
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          SizedBox(height: mq.h10()),
          SizedBox(height: mq.h20(mobileMultiplier: 0.18)),
          SizedBox(height: mq.h1()),
          SizedBox(height: mq.h2()),
          SizedBox(width: mq.w5()),
        ],
      ),
    ),
  );
}
```

## Best Practices

1. **Always create a local variable** at the beginning of `build()` method:
   ```dart
   final mq = MQ(context: context);
   ```

2. **Use predefined methods** instead of manual calculations:
   ```dart
   // ✅ Good
   SizedBox(height: mq.h10());
   
   // ❌ Avoid
   SizedBox(height: MQ(context: context).h * 0.1);
   ```

3. **Use breakpoints for layout decisions**:
   ```dart
   if (mq.isMobile) {
     // Adjust layout for mobile
   }
   ```

4. **Combine values for complex layouts**:
   ```dart
   final mq = MQ(context: context);
   final padding = mq.val(mobile: 12, tablet: 20, desktop: 32);
   final iconSize = mq.val(mobile: 24, tablet: 32, desktop: 48);
   ```

5. **Use padding helpers for consistency**:
   ```dart
   Padding(
     padding: mq.paddingSymmetric(horizontal: 16, vertical: 12),
     child: MyWidget(),
   )
   ```

## Updated Files
The following files have been updated to use the MQ system:
- `lib/features/authentication/presentation/pages/login_page.dart`
- `lib/features/authentication/presentation/pages/register_page.dart`
- `lib/features/authentication/presentation/widgets/auth_panar.dart`
- `lib/features/home/presentation/pages/home_page.dart`
- `lib/features/home/presentation/widgets/balance_widget.dart`
- `lib/features/stats/presentation/pages/stats_page.dart`
- `lib/features/add_transaction/presentation/pages/add_transaction_page.dart`

## Migration Notes
When updating files to use MQ:
1. Import the MQ class: `import 'package:expense_tracker_app/core/constants/app_media_query.dart';`
2. Create a local `mq` variable in the build method
3. Replace `MediaQuery.of(context).size` with `mq`
4. Replace `size.height * 0.X` with predefined methods like `mq.hX()`
5. Replace `size.width * 0.X` with predefined methods like `mq.wX()`
