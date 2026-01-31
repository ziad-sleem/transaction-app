# MQ Quick Reference

## Import
```dart
import 'package:expense_tracker_app/core/constants/app_media_query.dart';
```

## Basic Setup
```dart
@override
Widget build(BuildContext context) {
  final mq = MQ(context: context);
  return Scaffold(...);
}
```

## Common Usage Patterns

### Screen Size
```dart
double height = mq.h;        // Screen height
double width = mq.w;         // Screen width
Size size = mq.size;         // Both
```

### Device Detection
```dart
if (mq.isMobile) { }         // width < 600
if (mq.isTablet) { }         // 600 <= width < 1200
if (mq.isDesktop) { }        // width >= 1200
```

### Spacing (Most Common)
```dart
// Heights
SizedBox(height: mq.h1());   // 1%
SizedBox(height: mq.h2());   // 2%
SizedBox(height: mq.h5());   // 5%
SizedBox(height: mq.h10());  // 10% ⭐ Most used
SizedBox(height: mq.h15());  // 15%
SizedBox(height: mq.h20());  // 20%

// Widths
SizedBox(width: mq.w5());    // 5%
SizedBox(width: mq.w10());   // 10%
SizedBox(width: mq.w20());   // 20%
SizedBox(width: mq.w50());   // 50%

// Custom multipliers
SizedBox(height: mq.h10(mobileMultiplier: 0.18));  // 18%
```

### Padding/Margins
```dart
// All sides equal
Padding(padding: mq.paddingAll(mobile: 16), child: widget)

// Horizontal and Vertical
Padding(padding: mq.paddingSymmetric(horizontal: 16, vertical: 12), child: widget)

// Custom sides
Padding(padding: mq.paddingOnly(top: 20, bottom: 10), child: widget)
```

### Device-Specific Values
```dart
double value = mq.val(
  mobile: 16,
  tablet: 24,
  desktop: 32,
);

double icon = mq.val(mobile: 24, tablet: 32, desktop: 48);
```

## Conversion Cheat Sheet

| Old Code | New Code |
|----------|----------|
| `size.height * 0.01` | `mq.h1()` |
| `size.height * 0.02` | `mq.h2()` |
| `size.height * 0.05` | `mq.h5()` |
| `size.height * 0.1` | `mq.h10()` |
| `size.height * 0.15` | `mq.h15()` |
| `size.height * 0.2` | `mq.h20()` |
| `size.width * 0.05` | `mq.w5()` |
| `size.width * 0.1` | `mq.w10()` |
| `size.width * 0.2` | `mq.w20()` |
| `MediaQuery.of(context).size.height` | `mq.h` |
| `MediaQuery.of(context).size.width` | `mq.w` |

## Tips
1. ✅ Always create `mq` variable at the start of build()
2. ✅ Use predefined h1()-h20(), w5()-w50() methods
3. ✅ Use breakpoints for layout decisions
4. ✅ Use `paddingSymmetric()` for standard UI padding
5. ❌ Don't use `mq` inside nested functions (create new instance if needed)
6. ❌ Don't manually multiply mq.h or mq.w (use predefined methods)
