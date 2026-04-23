import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import '../widgets/scroll_reveal.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  static final List<_ExperienceData> _experiences = [
    const _ExperienceData(
      title: 'Head of Frontend Developers',
      company: 'Jenious Agency',
      date: 'Present',
      icon: Icons.rocket_launch_rounded,
      details: [
        'Leading the frontend development team to build engaging user interfaces.',
        'Collaborating with designers and backend engineers to deliver high-quality web applications.',
      ],
    ),
    const _ExperienceData(
      title: 'Full-Stack Developer',
      company: 'Project-Based',
      date: '2023 – Present',
      icon: Icons.code_rounded,
      details: [
        'Designed and built cross-platform mobile apps using Flutter for student use cases, including an Exeat Management system.',
        'Integrated Firebase for authentication and real-time database functionality.',
      ],
    ),
    const _ExperienceData(
      title: 'Intern – IT Support & Digital Solutions',
      company: 'CYCONET Nigeria (SIWES)',
      date: 'Aug 2025 – Oct 2025',
      icon: Icons.business_center_rounded,
      details: [
        'Assisted in diagnosing and resolving technical issues.',
        'Supported the team in building and scaling digital applications.',
      ],
    ),
    const _ExperienceData(
      title: 'B.Sc. Software Engineering',
      company: 'Dominion University, Ibadan',
      date: '2022 – Present',
      icon: Icons.school_rounded,
      details: [
        'Relevant Coursework focusing on software architecture, algorithms, and applications.',
        'Active in coding competitions, UI/UX workshops, and tech communities.',
        'Member of NACOS.',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      constraints: const BoxConstraints(maxWidth: 1100),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppSpacing.xl : AppSpacing.xxxl,
        vertical: AppSpacing.massive,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScrollReveal(
            key: ValueKey('exp_title'),
            child: SectionTitle(number: '02.', title: 'Experience & Education'),
          ),
          const SizedBox(height: AppSpacing.xxxl),
          // Timeline
          ...List.generate(_experiences.length, (index) {
            final exp = _experiences[index];
            final isLast = index == _experiences.length - 1;
            return ScrollReveal(
              key: ValueKey('exp_item_$index'),
              index: index,
              child: _TimelineItem(
                data: exp,
                isLast: isLast,
                index: index,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _ExperienceData {
  final String title;
  final String company;
  final String date;
  final IconData icon;
  final List<String> details;

  const _ExperienceData({
    required this.title,
    required this.company,
    required this.date,
    required this.icon,
    required this.details,
  });
}

class _TimelineItem extends StatefulWidget {
  final _ExperienceData data;
  final bool isLast;
  final int index;

  const _TimelineItem({
    required this.data,
    required this.isLast,
    required this.index,
  });

  @override
  State<_TimelineItem> createState() => _TimelineItemState();
}

class _TimelineItemState extends State<_TimelineItem> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline rail
            if (!isMobile) ...[
              SizedBox(
                width: 60,
                child: Column(
                  children: [
                    // Dot
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _isHovering
                            ? AppColors.primary.withOpacity(0.2)
                            : AppColors.surfaceVariant,
                        border: Border.all(
                          color: _isHovering
                              ? AppColors.primary
                              : AppColors.border,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        widget.data.icon,
                        size: 18,
                        color: _isHovering
                            ? AppColors.primary
                            : AppColors.textMuted,
                      ),
                    ),
                    // Line
                    if (!widget.isLast)
                      Expanded(
                        child: Container(
                          width: 2,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.border,
                                AppColors.border.withOpacity(0.2),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
            ],
            // Card content
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: widget.isLast ? 0 : AppSpacing.xxl,
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  decoration: BoxDecoration(
                    color: _isHovering
                        ? AppColors.surfaceVariant.withOpacity(0.6)
                        : AppColors.surfaceVariant.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    border: Border.all(
                      color: _isHovering
                          ? AppColors.primary.withOpacity(0.3)
                          : AppColors.border.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title + Company
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: AppSpacing.sm,
                        children: [
                          Text(
                            widget.data.title,
                            style: GoogleFonts.spaceGrotesk(
                              color: AppColors.textPrimary,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '@ ${widget.data.company}',
                            style: GoogleFonts.inter(
                              color: AppColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      // Date badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                        ),
                        child: Text(
                          widget.data.date,
                          style: GoogleFonts.inter(
                            color: AppColors.accent,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      // Details
                      ...widget.data.details.map(
                        (detail) => Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.6),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppSpacing.md),
                              Expanded(
                                child: Text(
                                  detail,
                                  style: GoogleFonts.inter(
                                    color: AppColors.textSecondary,
                                    fontSize: 15,
                                    height: 1.6,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
