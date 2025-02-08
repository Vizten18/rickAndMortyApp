class Constants {
  /// Grid system's base value. The project uses an 8 point grid system.
  ///
  /// This means that the minimum size must be 8.0 and any other sizes must
  /// be multiples of this value.
  static const _gridSystem = 8.0;

  /// Default minimum padding size. The project uses an 8.0 point
  /// grid system.
  ///
  /// This means that the minimum padding size is 8.0, and any other sizes must
  /// be multiples of this value.
  static const padding = _gridSystem;

  /// Default margin size for widgets and screens. The margin follows the
  /// same grid system as the padding.
  static const margin = padding * 2;

  /// Default padding size to use between different sections.
  static const sectionPadding = padding * 4;

  /// Default padding size to use between different fields.
  static const fieldPadding = padding * 2;

  /// Default border radius value.
  static const defaultRadius = 8.0;

  static const bottomPadding = _gridSystem * 5;

  static const loadingIndicatorSize = 40.0;

  static const pageLimit = 25;

  static const circleAvatarDiameter = 40.0;

  static const apiTimeOut = Duration(seconds: 30);

  static const carouselHeight = 110.0;

  static const pieChartWidth = 110.0;

  static const piecChartHeight = 110.0;
}
