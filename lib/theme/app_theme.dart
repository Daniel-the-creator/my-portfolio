import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Design tokens — spacing scale
class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;
  static const double huge = 64;
  static const double massive = 80;
  static const double section = 96;
}

/// Design tokens — colors (Deep Obsidian & Electric Indigo/Violet/Cyan Theme)
class AppColors {
  // ── Primary Palette: Electric Indigo & Violet ─────────────────────────────
  static const Color primary = Color(0xFF6366F1); // Electric Indigo
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primaryDark = Color(0xFF4F46E5);
  static const Color secondary = Color(0xFF8B5CF6); // Vibrant Violet
  static const Color accent = Color(0xFF06B6D4); // Electric Cyan
  static const Color accentLight = Color(0xFF38BDF8);

  // ── Deep Surfaces ────────────────────────────────────────────────────────
  static const Color background = Color(0xFF0A0D14); // Deep obsidian
  static const Color surface = Color(0xFF101422); // Card surface
  static const Color surfaceVariant = Color(0xFF161B2E); // Elevated card
  static const Color surfaceElevated = Color(0xFF1E243D); // Hover/Highlight
  static const Color surfaceGlass = Color(0xCC101422); // Frosted surface

  // ── Dark/Light Compatibility Aliases ─────────────────────────────────────
  static const Color darkBand = background;
  static const Color darkSurface = surface;
  static const Color darkSurfaceVariant = surfaceVariant;
  static const Color lightBand = background;
  static const Color lightSurface = surface;
  static const Color lightSurfaceVariant = surfaceVariant;
  static const Color lightSurfaceElevated = surfaceElevated;

  // ── Text Colors ──────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFFF8FAFC); // Crisp white
  static const Color textSecondary = Color(0xFF94A3B8); // Slate 400
  static const Color textMuted = Color(0xFF64748B); // Slate 500
  static const Color textOnLight = textPrimary;
  static const Color textSecondaryOnLight = textSecondary;
  static const Color textMutedOnLight = textMuted;

  // ── Borders & Outlines ───────────────────────────────────────────────────
  static const Color border = Color(0xFF1E2640);
  static const Color borderSubtle = Color(0xFF151B2E);
  static const Color borderHighlight = Color(0xFF6366F1);
  static const Color borderOnLight = border;
  static const Color borderOnLightSubtle = borderSubtle;

  // ── Gradients ────────────────────────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6), Color(0xFF06B6D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cyanGradient = LinearGradient(
    colors: [Color(0xFF06B6D4), Color(0xFF3B82F6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF12172A), Color(0xFF0F1322)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient subtleGradient = LinearGradient(
    colors: [Color(0xFF161B2E), Color(0xFF0F1322)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

/// Design tokens — border radius
class AppRadius {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double full = 999;
}

/// App Theme
class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        onPrimary: Colors.white,
        secondary: AppColors.secondary,
        onSecondary: Colors.white,
        tertiary: AppColors.accent,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        outline: AppColors.border,
      ),
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.dark().textTheme,
      ).copyWith(
        displayLarge: GoogleFonts.spaceGrotesk(
          fontSize: 64,
          fontWeight: FontWeight.w800,
          color: AppColors.textPrimary,
          letterSpacing: -2.0,
          height: 1.05,
        ),
        displayMedium: GoogleFonts.spaceGrotesk(
          fontSize: 52,
          fontWeight: FontWeight.w800,
          color: AppColors.textPrimary,
          letterSpacing: -1.5,
          height: 1.1,
        ),
        displaySmall: GoogleFonts.spaceGrotesk(
          fontSize: 40,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          letterSpacing: -1.0,
          height: 1.15,
        ),
        headlineLarge: GoogleFonts.spaceGrotesk(
          fontSize: 34,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          letterSpacing: -0.5,
        ),
        headlineMedium: GoogleFonts.spaceGrotesk(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        headlineSmall: GoogleFonts.spaceGrotesk(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleLarge: GoogleFonts.spaceGrotesk(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleSmall: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
          height: 1.7,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
          height: 1.6,
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondary,
          letterSpacing: 0.3,
        ),
        labelMedium: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.textMuted,
          letterSpacing: 0.5,
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: AppColors.textMuted,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
