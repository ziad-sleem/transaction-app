import 'package:flutter/material.dart';

class MQ {
  final BuildContext context;
  MQ({required this.context});

  // ============ SCREEN SIZE ============
  Size get size => MediaQuery.of(context).size;
  double get h => MediaQuery.of(context).size.height;
  double get w => MediaQuery.of(context).size.width;

  // ============ RESPONSIVE BREAKPOINTS ============
  bool get isMobile => w < 600;
  bool get isTablet => w >= 600 && w < 1200;
  bool get isDesktop => w >= 1200;
  bool get isSmallMobile => h < 600;
  bool get isLargeMobile => h >= 600;

  // ============ RESPONSIVE HEIGHT VALUES ============
  double h1({double mobileMultiplier = 0.01}) => h * mobileMultiplier;
  double h2({double mobileMultiplier = 0.02}) => h * mobileMultiplier;
  double h3({double mobileMultiplier = 0.03}) => h * mobileMultiplier;
  double h5({double mobileMultiplier = 0.05}) => h * mobileMultiplier;
  double h10({double mobileMultiplier = 0.1}) => h * mobileMultiplier;
  double h15({double mobileMultiplier = 0.15}) => h * mobileMultiplier;
  double h20({double mobileMultiplier = 0.2}) => h * mobileMultiplier;

  // ============ RESPONSIVE WIDTH VALUES ============
  double w5({double mobileMultiplier = 0.05}) => w * mobileMultiplier;
  double w10({double mobileMultiplier = 0.1}) => w * mobileMultiplier;
  double w15({double mobileMultiplier = 0.15}) => w * mobileMultiplier;
  double w20({double mobileMultiplier = 0.2}) => w * mobileMultiplier;
  double w50({double mobileMultiplier = 0.5}) => w * mobileMultiplier;

  // ============ RESPONSIVE PADDING/MARGIN ============
  EdgeInsets paddingAll({double mobile = 16}) => EdgeInsets.all(mobile);
  EdgeInsets paddingSymmetric({double horizontal = 16, double vertical = 16}) =>
      EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  EdgeInsets paddingOnly({
    double top = 0,
    double bottom = 0,
    double left = 0,
    double right = 0,
  }) => EdgeInsets.only(top: top, bottom: bottom, left: left, right: right);

  // ============ RESPONSIVE FONT SIZES ============
  double fontSize({double mobileSizeMultiplier = 1.0}) {
    if (isMobile) return 14 * mobileSizeMultiplier;
    if (isTablet) return 16 * mobileSizeMultiplier;
    return 18 * mobileSizeMultiplier;
  }

  // ============ CUSTOM RESPONSIVE VALUE ============
  /// Get responsive value based on screen size
  double val({required double mobile, double tablet = 0, double desktop = 0}) {
    if (isDesktop && desktop > 0) return desktop;
    if (isTablet && tablet > 0) return tablet;
    return mobile;
  }
}
