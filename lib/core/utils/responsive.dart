import 'package:flutter/widgets.dart';

import '../theme/design_tokens.dart';

/// Discrete screen-size classes used to drive adaptive layout decisions.
enum ScreenSize { mobile, tablet, desktop }

extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;

  ScreenSize get screenSize {
    final w = screenWidth;
    if (w < Breakpoints.mobile) return ScreenSize.mobile;
    if (w < Breakpoints.tablet) return ScreenSize.tablet;
    return ScreenSize.desktop;
  }

  bool get isMobile => screenSize == ScreenSize.mobile;
  bool get isTablet => screenSize == ScreenSize.tablet;
  bool get isDesktop => screenSize == ScreenSize.desktop;

  /// Number of columns for the product grid at the current width.
  int get productGridColumns => switch (screenSize) {
        ScreenSize.mobile => 2,
        ScreenSize.tablet => 3,
        ScreenSize.desktop => screenWidth > Breakpoints.desktop ? 5 : 4,
      };

  /// Whether a persistent side cart panel should be shown (desktop only).
  bool get showSideCart => screenWidth > Breakpoints.desktop;
}
