import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

extension BuildContextX on BuildContext {
  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get size => MediaQuery.of(this).size;
  TargetPlatform get platform => Theme.of(this).platform;
  bool get isAndroid => platform == TargetPlatform.android;
  bool get isIOS => platform == TargetPlatform.iOS;
  bool get isTablet => Device.screenType == ScreenType.tablet;
}
