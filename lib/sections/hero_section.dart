import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    final isMobile = width < 850;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 72 + (isMobile ? AppSpacing.xl : AppSpacing.huge),
        bottom: isMobile ? AppSpacing.xxxl : AppSpacing.massive,
        left: isMobile ? AppSpacing.xl : AppSpacing.xxxl,
        right: isMobile ? AppSpacing.xl : AppSpacing.xxxl,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1160),
          child: Column(
            children: [
              if (isMobile)
                _buildMobileLayout(context)
              else
                _buildDesktopLayout(context),
              const SizedBox(height: AppSpacing.huge),
              const _TechTickerRibbon(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 12,
          child: _buildTextContent(context, isMobile: false),
        ),
        const SizedBox(width: AppSpacing.xxxl),
        const Expanded(
          flex: 10,
          child: _HeroVisualDesktop(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const _HeroVisualMobile(),
        const SizedBox(height: AppSpacing.xxl),
        _buildTextContent(context, isMobile: true),
      ],
    );
  }

  Widget _buildTextContent(BuildContext context, {required bool isMobile}) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Status Badge
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppRadius.full),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF10B981).withValues(alpha: 0.6),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Available for opportunities',
                style: GoogleFonts.inter(
                  color: AppColors.primaryLight,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),

        // Main Title
        RichText(
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          text: TextSpan(
            style: GoogleFonts.spaceGrotesk(
              color: AppColors.textPrimary,
              fontSize: isMobile ? 42 : 62,
              fontWeight: FontWeight.w800,
              letterSpacing: -1.5,
              height: 1.05,
            ),
            children: [
              const TextSpan(text: "Hi, I'm "),
              WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: GradientText(
                  'Daniel Ilesanmi',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: isMobile ? 42 : 62,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1.5,
                    height: 1.05,
                  ),
                  gradient: AppColors.heroGradient,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Subtitle
        Text(
          'Full-Stack Developer & Mobile Engineer',
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: GoogleFonts.inter(
            color: AppColors.accentLight,
            fontSize: isMobile ? 18 : 22,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Bio Description
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 540),
          child: Text(
            'Crafting high-performance cross-platform mobile apps and elegant web experiences. '
            'Currently leading frontend engineering at Jenious Agency and a recent Software Engineering graduate from Dominion University.',
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: GoogleFonts.inter(
              color: AppColors.textSecondary,
              fontSize: isMobile ? 15 : 16,
              height: 1.7,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xxl),

        // CTA Buttons
        Wrap(
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
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
      ],
    );
  }
}

/// Desktop visual with circular profile photo and floating tech badges
class _HeroVisualDesktop extends StatefulWidget {
  const _HeroVisualDesktop();

  @override
  State<_HeroVisualDesktop> createState() => _HeroVisualDesktopState();
}

class _HeroVisualDesktopState extends State<_HeroVisualDesktop> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: Center(
        child: SizedBox(
          width: 380,
          height: 380,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Ambient glow behind image
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary
                          .withValues(alpha: _isHovering ? 0.35 : 0.2),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              // Gradient outer ring
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 290,
                height: 290,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.heroGradient,
                ),
                padding: const EdgeInsets.all(3),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.surface,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/profile.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: AppColors.surfaceVariant,
                        child: const Icon(
                          Icons.person_rounded,
                          size: 100,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Floating Pill Badge 1: Flutter
              const Positioned(
                top: 20,
                left: 10,
                child: _FloatingPill(
                  icon: Icons.flutter_dash,
                  label: 'Flutter & Dart',
                  color: Color(0xFF02569B),
                ),
              ),

              // Floating Pill Badge 2: Mobile UI
              const Positioned(
                bottom: 30,
                left: 0,
                child: _FloatingPill(
                  icon: Icons.phone_android_rounded,
                  label: 'Cross-Platform',
                  color: AppColors.primary,
                ),
              ),

              // Floating Pill Badge 3: Firebase / Cloud
              const Positioned(
                top: 80,
                right: 0,
                child: _FloatingPill(
                  icon: Icons.cloud_rounded,
                  label: 'Firebase & APIs',
                  color: Color(0xFFFFCA28),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Mobile visual
class _HeroVisualMobile extends StatelessWidget {
  const _HeroVisualMobile();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 190,
        height: 190,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppColors.heroGradient,
        ),
        padding: const EdgeInsets.all(3),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.surface,
          ),
          padding: const EdgeInsets.all(3),
          child: ClipOval(
            child: Image.asset(
              'assets/profile.jpg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: AppColors.surfaceVariant,
                child: const Icon(
                  Icons.person_rounded,
                  size: 60,
                  color: AppColors.textMuted,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FloatingPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _FloatingPill({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(AppRadius.full),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.inter(
              color: AppColors.textPrimary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Tech Ticker Ribbon
class _TechTickerRibbon extends StatelessWidget {
  const _TechTickerRibbon();

  static const List<(String, IconData)> _items = [
    ('Flutter', Icons.phone_android_rounded),
    ('Dart', Icons.code_rounded),
    ('Firebase', Icons.cloud_rounded),
    ('JavaScript', Icons.javascript_rounded),
    ('REST APIs', Icons.api_rounded),
    ('Figma & UI/UX', Icons.design_services_rounded),
    ('Git / GitHub', Icons.merge_rounded),
    ('Responsive Web', Icons.web_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl, vertical: AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: AppSpacing.lg,
        runSpacing: AppSpacing.md,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: _items.map((item) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(item.$2, size: 16, color: AppColors.primaryLight),
              const SizedBox(width: 8),
              Text(
                item.$1,
                style: GoogleFonts.inter(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
