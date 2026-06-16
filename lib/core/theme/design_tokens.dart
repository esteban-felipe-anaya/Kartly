import 'package:flutter/widgets.dart';

/// Centralized design tokens. No raw colors or magic spacing numbers should
/// appear in widgets — pull everything from here (or the [ColorScheme]).
class Insets {
  const Insets._();
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;
}

class Gaps {
  const Gaps._();
  static const Widget xs = SizedBox(width: Insets.xs, height: Insets.xs);
  static const Widget sm = SizedBox(width: Insets.sm, height: Insets.sm);
  static const Widget md = SizedBox(width: Insets.md, height: Insets.md);
  static const Widget lg = SizedBox(width: Insets.lg, height: Insets.lg);
  static const Widget xl = SizedBox(width: Insets.xl, height: Insets.xl);
  static const Widget xxl = SizedBox(width: Insets.xxl, height: Insets.xxl);

  // Explicit single-axis gaps for rows/columns.
  static const Widget hSm = SizedBox(width: Insets.sm);
  static const Widget hMd = SizedBox(width: Insets.md);
  static const Widget hLg = SizedBox(width: Insets.lg);
  static const Widget vSm = SizedBox(height: Insets.sm);
  static const Widget vMd = SizedBox(height: Insets.md);
  static const Widget vLg = SizedBox(height: Insets.lg);
  static const Widget vXl = SizedBox(height: Insets.xl);
}

class Radii {
  const Radii._();
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double pill = 999;

  static const BorderRadius smAll = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius mdAll = BorderRadius.all(Radius.circular(md));
  static const BorderRadius lgAll = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius xlAll = BorderRadius.all(Radius.circular(xl));
}

/// Responsive layout breakpoints (in logical pixels / dp).
class Breakpoints {
  const Breakpoints._();
  static const double mobile = 600;
  static const double tablet = 840;
  static const double desktop = 1240;
}

/// The Kartly brand seed color used to derive the Material 3 [ColorScheme].
const Color kSeedColor = Color(0xFF6750A4);
