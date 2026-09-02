import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 850;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppSpacing.xl : AppSpacing.xxxl,
        vertical: AppSpacing.huge,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1160),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(
                number: '01',
                title: 'About Me',
                subtitle:
                    'Passionate software developer dedicated to crafting intuitive digital solutions',
              ),
              const SizedBox(height: AppSpacing.xxxl),

              // Bento Grid Layout
              if (isMobile)
                _buildMobileBento(context, isMobile: true)
              else
                _buildDesktopBento(context, isMobile: false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopBento(BuildContext context, {required bool isMobile}) {
    return Column(
      children: [
        // Row 1: Bio Card (Expanded) + Quick Stats (Flex 5)
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 7,
              child: _buildBioCard(isMobile: isMobile),
            ),
            const SizedBox(width: AppSpacing.xl),
            Expanded(
              flex: 5,
              child: _buildStatsCard(isMobile: isMobile),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),

        // Row 2: Skills Categories (Flex 7) + Education & Leadership (Flex 5)
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 7,
              child: _buildSkillsCard(isMobile: isMobile),
            ),
            const SizedBox(width: AppSpacing.xl),
            Expanded(
              flex: 5,
              child: _buildEducationCard(isMobile: isMobile),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileBento(BuildContext context, {required bool isMobile}) {
    return Column(
      children: [
        _buildBioCard(isMobile: isMobile),
        const SizedBox(height: AppSpacing.lg),
        _buildStatsCard(isMobile: isMobile),
        const SizedBox(height: AppSpacing.lg),
        _buildSkillsCard(isMobile: isMobile),
        const SizedBox(height: AppSpacing.lg),
        _buildEducationCard(isMobile: isMobile),
      ],
    );
  }

  Widget _buildBioCard({bool isMobile = false}) {
    return GlassCard(
      enableHover: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: const Icon(
                  Icons.person_pin_rounded,
                  color: AppColors.primaryLight,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Flexible(
                child: Text(
                  'Background & Discipline',
                  style: GoogleFonts.spaceGrotesk(
                    color: AppColors.textPrimary,
                    fontSize: isMobile ? 16 : 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Creative and goal-driven full-stack developer with a deep passion for building functional, responsive, and user-friendly mobile and web applications.',
            style: GoogleFonts.inter(
              color: AppColors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              height: 1.6,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Studied Software Engineering at Dominion University, Ibadan, and actively contributing as Head of Frontend Developers at Jenious Agency. I specialize in turning complex ideas into clean, maintainable, and high-performance cross-platform software.',
            style: GoogleFonts.inter(
              color: AppColors.textSecondary,
              fontSize: 14,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard({bool isMobile = false}) {
    return GlassCard(
      enableHover: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: const Icon(
                  Icons.auto_graph_rounded,
                  color: AppColors.accentLight,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Flexible(
                child: Text(
                  'Track Record',
                  style: GoogleFonts.spaceGrotesk(
                    color: AppColors.textPrimary,
                    fontSize: isMobile ? 16 : 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _StatItem(value: '3+', label: 'Shipped Apps'),
              _StatItem(value: '2+', label: 'Years Coding'),
              _StatItem(value: '100%', label: 'Commitment'),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                const Icon(Icons.verified_rounded,
                    color: Color(0xFF10B981), size: 18),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'Always eager to learn new tools and solve real-world problems.',
                    style: GoogleFonts.inter(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsCard({bool isMobile = false}) {
    return GlassCard(
      enableHover: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: const Icon(
                  Icons.terminal_rounded,
                  color: AppColors.secondary,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Flexible(
                child: Text(
                  'Technical Toolbelt',
                  style: GoogleFonts.spaceGrotesk(
                    color: AppColors.textPrimary,
                    fontSize: isMobile ? 16 : 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          const Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              TechBadge(label: 'Flutter', icon: Icons.phone_android_rounded),
              TechBadge(label: 'Dart', icon: Icons.code_rounded),
              TechBadge(label: 'Firebase', icon: Icons.cloud_rounded),
              TechBadge(label: 'JavaScript', icon: Icons.javascript_rounded),
              TechBadge(label: 'HTML5 & CSS3', icon: Icons.web_rounded),
              TechBadge(label: 'REST APIs', icon: Icons.api_rounded),
              TechBadge(label: 'Git & GitHub', icon: Icons.merge_rounded),
              TechBadge(
                  label: 'Figma UI/UX', icon: Icons.design_services_rounded),
              TechBadge(
                  label: 'Responsive Design', icon: Icons.devices_rounded),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEducationCard({bool isMobile = false}) {
    return GlassCard(
      enableHover: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: const Icon(
                  Icons.school_rounded,
                  color: AppColors.primaryLight,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Flexible(
                child: Text(
                  'Education & Activities',
                  style: GoogleFonts.spaceGrotesk(
                    color: AppColors.textPrimary,
                    fontSize: isMobile ? 16 : 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'B.Sc. Software Engineering',
            style: GoogleFonts.spaceGrotesk(
              color: AppColors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Dominion University, Ibadan (2022 – 2026)',
            style: GoogleFonts.inter(
              color: AppColors.primaryLight,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            '• Active member of NACOS\n• Participant in UI/UX and Dev workshops\n• Regular coding challenges & tech meetups',
            style: GoogleFonts.inter(
              color: AppColors.textSecondary,
              fontSize: 13,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GradientText(
          value,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 28,
            fontWeight: FontWeight.w800,
          ),
          gradient: AppColors.heroGradient,
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.inter(
            color: AppColors.textMuted,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
