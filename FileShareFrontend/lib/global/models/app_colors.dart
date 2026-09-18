import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  // Backgrounds & Surfaces
  final LinearGradient? bgPage;
  final Color? card;
  final Color? cardAlt;
  final Color? cardAlt2;

  // Typography & Borders
  final Color? ink;
  final Color? sub;
  final Color? line;
  final Color? track;

  // Brand
  final Color? indigo;
  final Color? blue;
  final LinearGradient? grad;

  // Semantic
  final Color? success;
  final Color? danger;
  final Color? warning;

  // States
  final Color? disabledBg;
  final Color? disabledInk;
  final Color? scrim;

  const AppColors({
    this.bgPage,
    this.card,
    this.cardAlt,
    this.cardAlt2,
    this.ink,
    this.sub,
    this.line,
    this.track,
    this.indigo,
    this.blue,
    this.grad,
    this.success,
    this.danger,
    this.warning,
    this.disabledBg,
    this.disabledInk,
    this.scrim,
  });

  @override
  AppColors copyWith({
    LinearGradient? bgPage,
    Color? card,
    Color? cardAlt,
    Color? cardAlt2,
    Color? ink,
    Color? sub,
    Color? line,
    Color? track,
    Color? indigo,
    Color? blue,
    LinearGradient? grad,
    Color? success,
    Color? danger,
    Color? warning,
    Color? disabledBg,
    Color? disabledInk,
    Color? scrim,
  }) {
    return AppColors(
      bgPage: bgPage ?? this.bgPage,
      card: card ?? this.card,
      cardAlt: cardAlt ?? this.cardAlt,
      cardAlt2: cardAlt2 ?? this.cardAlt2,
      ink: ink ?? this.ink,
      sub: sub ?? this.sub,
      line: line ?? this.line,
      track: track ?? this.track,
      indigo: indigo ?? this.indigo,
      blue: blue ?? this.blue,
      grad: grad ?? this.grad,
      success: success ?? this.success,
      danger: danger ?? this.danger,
      warning: warning ?? this.warning,
      disabledBg: disabledBg ?? this.disabledBg,
      disabledInk: disabledInk ?? this.disabledInk,
      scrim: scrim ?? this.scrim,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      bgPage: LinearGradient.lerp(bgPage, other.bgPage, t),
      card: Color.lerp(card, other.card, t),
      cardAlt: Color.lerp(cardAlt, other.cardAlt, t),
      cardAlt2: Color.lerp(cardAlt2, other.cardAlt2, t),
      ink: Color.lerp(ink, other.ink, t),
      sub: Color.lerp(sub, other.sub, t),
      line: Color.lerp(line, other.line, t),
      track: Color.lerp(track, other.track, t),
      indigo: Color.lerp(indigo, other.indigo, t),
      blue: Color.lerp(blue, other.blue, t),
      grad: LinearGradient.lerp(grad, other.grad, t),
      success: Color.lerp(success, other.success, t),
      danger: Color.lerp(danger, other.danger, t),
      warning: Color.lerp(warning, other.warning, t),
      disabledBg: Color.lerp(disabledBg, other.disabledBg, t),
      disabledInk: Color.lerp(disabledInk, other.disabledInk, t),
      scrim: Color.lerp(scrim, other.scrim, t),
    );
  }

  // ==========================================
  // LIGHT THEME INSTANCE
  // ==========================================
  static const AppColors light = AppColors(
    bgPage: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomRight,
      stops: [0.0, 0.5, 1.0],
      colors: [
        Color(0xFFDBE9FF),
        Color(0xFFEEF4FF),
        Color(0xFFE3F3FF),
      ],
    ),
    card: Color(0xFFFFFFFF),
    cardAlt: Color(0xFFF3F5FC),
    cardAlt2: Color(0xFFFAFBFF),
    ink: Color(0xFF1B1D3A),
    sub: Color(0xFF8A8FA8),
    line: Color(0xFFEEF0FA),
    track: Color(0xFFEDEFFA),
    indigo: Color(0xFF5D78E7),
    blue: Color(0xFF35C2FD),
    grad: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF5D78E7),
        Color(0xFF35C2FD),
      ],
    ),
    success: Color(0xFF3BC79A),
    danger: Color(0xFFEF5B6B),
    warning: Color(0xFFF5A623),
    disabledBg: Color(0xFFEDEFF7),
    disabledInk: Color(0xFFB7BBD6),
    scrim: Color(0x730F142D), // rgba(15,20,45,.45)
  );

  // ==========================================
  // DARK THEME INSTANCE
  // ==========================================
  static const AppColors dark = AppColors(
    bgPage: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomRight,
      stops: [0.0, 0.45, 1.0],
      colors: [
        Color(0xFF0B0E22),
        Color(0xFF10122A),
        Color(0xFF141433),
      ],
    ),
    card: Color(0xFF181A34),
    cardAlt: Color(0xFF20223F),
    cardAlt2: Color(0xFF1C1E3A),
    ink: Color(0xFFF1F2FB),
    sub: Color(0xFF8B8FB8),
    line: Color(0xFF2A2C4E),
    track: Color(0xFF2A2C4E),
    indigo: Color(0xFF5D78E7),
    blue: Color(0xFF35C2FD),
    grad: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF5D78E7),
        Color(0xFF35C2FD),
      ],
    ),
    success: Color(0xFF3BC79A),
    danger: Color(0xFFEF5B6B),
    warning: Color(0xFFF5A623),
    disabledBg: Color(0xFF23253F),
    disabledInk: Color(0xFF4A4D74),
    scrim: Color(0x99000000), // rgba(0,0,0,.6)
  );
}