import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onContactTap;
  final VoidCallback onProjectsTap;

  const HeroSection({
    super.key,
    required this.onContactTap,
    required this.onProjectsTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 800;

    return Container(
      constraints: const BoxConstraints(maxWidth: 1100),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppSpacing.xl : AppSpacing.xxxl,
        vertical: AppSpacing.section,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: isMobile ? 60 : 80),
          // Status badge
          FadeInDown(
            duration: const Duration(milliseconds: 600),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(AppRadius.full),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.2),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF22C55E),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'Available for opportunities',
                    style: GoogleFonts.inter(
                      color: AppColors.primary,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          // Name
          FadeInUp(
            duration: const Duration(milliseconds: 700),
            delay: const Duration(milliseconds: 200),
            child: Text(
              'Daniel\nIlesanmi.',
              style: GoogleFonts.spaceGrotesk(
                color: AppColors.textPrimary,
                fontSize: isMobile ? 48 : 72,
                fontWeight: FontWeight.w700,
                height: 1.05,
                letterSpacing: -2,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          // Subtitle gradient
          FadeInUp(
            duration: const Duration(milliseconds: 700),
            delay: const Duration(milliseconds: 400),
            child: GradientText(
              'Full-Stack Developer & Mobile Engineer',
              style: GoogleFonts.spaceGrotesk(
                fontSize: isMobile ? 24 : 32,
                fontWeight: FontWeight.w600,
                height: 1.2,
                letterSpacing: -0.5,
              ),
              gradient: AppColors.primaryGradient,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          // Description
          FadeInUp(
            duration: const Duration(milliseconds: 700),
            delay: const Duration(milliseconds: 600),
            child: SizedBox(
              width: min(580, width - 80),
              child: Text(
                "Building functional, responsive, and user-friendly applications. "
                "Currently studying Software Engineering at Dominion University and leading "
                "frontend development at Jenious Agency.",
                style: GoogleFonts.inter(
                  color: AppColors.textSecondary,
                  fontSize: isMobile ? 16 : 18,
                  height: 1.7,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xxxl),
          // CTA Buttons
          FadeInUp(
            duration: const Duration(milliseconds: 700),
            delay: const Duration(milliseconds: 800),
            child: Wrap(
              spacing: AppSpacing.lg,
              runSpacing: AppSpacing.lg,
              children: [
                PrimaryButton(
                  text: 'View My Work',
                  icon: Icons.arrow_forward_rounded,
                  onPressed: onProjectsTap,
                ),
                SecondaryButton(
                  text: 'Get In Touch',
                  icon: Icons.mail_outline_rounded,
                  onPressed: onContactTap,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.huge),
          // Stats row
          FadeInUp(
            duration: const Duration(milliseconds: 700),
            delay: const Duration(milliseconds: 1000),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.lg,
              ),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant.withOpacity(0.4),
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(
                  color: AppColors.border.withOpacity(0.3),
                ),
              ),
              child: Wrap(
                spacing: isMobile ? AppSpacing.xl : AppSpacing.xxxl,
                runSpacing: AppSpacing.lg,
                children: [
                  _buildStat('3+', 'Projects'),
                  _buildStat('2+', 'Years Coding'),
                  _buildStat('5+', 'Technologies'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GradientText(
          value,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
          gradient: AppColors.primaryGradient,
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          label,
          style: GoogleFonts.inter(
            color: AppColors.textMuted,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
