import 'package:flutter/material.dart';

class Responsive {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;

  // Device type flags
  static bool isMobile = false;
  static bool isTablet = false;
  static bool isDesktop = false;

  // Breakpoints
  static const double mobileBreakpoint = 768;
  static const double tabletBreakpoint = 1024;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

    // Set device type flags
    isMobile = screenWidth < mobileBreakpoint;
    isTablet =
        screenWidth >= mobileBreakpoint && screenWidth < tabletBreakpoint;
    isDesktop = screenWidth >= tabletBreakpoint;
  }

  // Responsive width
  static double width(double percentage) {
    return screenWidth * (percentage / 100);
  }

  // Responsive height
  static double height(double percentage) {
    return screenHeight * (percentage / 100);
  }

  // Responsive font size
  static double fontSize(double size) {
    if (isMobile) return size * 0.9;
    if (isTablet) return size * 0.95;
    return size;
  }

  // Responsive spacing
  static double spacing(double size) {
    if (isMobile) return size * 0.8;
    if (isTablet) return size * 0.9;
    return size;
  }

  // Get columns count based on screen size
  static int getColumns({int mobile = 1, int tablet = 2, int desktop = 3}) {
    if (isMobile) return mobile;
    if (isTablet) return tablet;
    return desktop;
  }

  // Responsive value based on screen size
  static T getValue<T>({required T mobile, T? tablet, T? desktop}) {
    if (isMobile) return mobile;
    if (isTablet) return tablet ?? mobile;
    return desktop ?? tablet ?? mobile;
  }
}

extension ResponsiveExtension on num {
  double get w => Responsive.width(toDouble());
  double get h => Responsive.height(toDouble());
  double get sp => Responsive.fontSize(toDouble());
  double get r => Responsive.spacing(toDouble());
}
