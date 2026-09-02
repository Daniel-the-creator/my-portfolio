import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  static const List<_ExperienceData> _experiences = [
    _ExperienceData(
      role: 'Head of Frontend Developers',
      company: 'Jenious Agency',
      period: 'Present',
      isCurrent: true,
      icon: Icons.rocket_launch_rounded,
      color: AppColors.primaryLight,
      highlights: [
        'Lead frontend engineering and collaborate closely with product design to ship responsive, pixel-perfect user interfaces.',
        'Architect frontend components and establish clean code standards for rapid client project delivery.',
      ],
    ),
    _ExperienceData(
      role: 'Full-Stack Developer',
      company: 'Project-Based & Freelance',
      period: '2023 – Present',
      isCurrent: false,
      icon: Icons.code_rounded,
      color: AppColors.accentLight,
      highlights: [
        'Engineered cross-platform mobile solutions with Flutter including student permission & management portals.',
        'Integrated Firebase Authentication, Cloud Firestore real-time databases, and REST APIs.',
        'Prioritized frictionless mobile user experience, accessible layouts, and rapid startup performance.',
      ],
    ),
    _ExperienceData(
      role: 'IT Support & Digital Solutions Intern',
      company: 'CYCONET Nigeria (SIWES)',
      period: 'Aug 2025 – Oct 2025',
      isCurrent: false,
      icon: Icons.business_center_rounded,
      color: AppColors.secondary,
      highlights: [
        'Assisted IT infrastructure troubleshooting, hardware diagnostics, and digital system maintenance.',
        'Collaborated with senior engineers on internal web applications and digital automation tooling.',
      ],
    ),
    _ExperienceData(
      role: 'B.Sc. Software Engineering',
      company: 'Dominion University, Ibadan',
      period: '2022 – 2026',
      isCurrent: false,
      icon: Icons.school_rounded,
      color: Color(0xFF10B981),
      highlights: [
        'Specializing in algorithms, data structures, software architecture, and distributed systems.',
        'Active leader in developer circles, NACOS workshops, and peer programming sessions.',
      ],
    ),
  ];

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
                number: '02',
                title: 'Experience & Journey',
                subtitle:
                    'My professional career milestones and engineering journey',
              ),
              const SizedBox(height: AppSpacing.xxxl),
              ...List.generate(_experiences.length, (index) {
                final exp = _experiences[index];
                final isLast = index == _experiences.length - 1;
                return _TimelineTile(
                  data: exp,
                  isLast: isLast,
                  isMobile: isMobile,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExperienceData {
  final String role;
  final String company;
  final String period;
  final bool isCurrent;
  final IconData icon;
  final Color color;
  final List<String> highlights;

  const _ExperienceData({
    required this.role,
    required this.company,
    required this.period,
    required this.isCurrent,
    required this.icon,
    required this.color,
    required this.highlights,
  });
}

class _TimelineTile extends StatefulWidget {
  final _ExperienceData data;
  final bool isLast;
  final bool isMobile;

  const _TimelineTile({
    required this.data,
    required this.isLast,
    required this.isMobile,
  });

  @override
  State<_TimelineTile> createState() => _TimelineTileState();
}

class _TimelineTileState extends State<_TimelineTile> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Timeline Indicator (on desktop/tablet)
          if (!widget.isMobile) ...[
            SizedBox(
              width: 48,
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isHovering
                          ? widget.data.color.withValues(alpha: 0.2)
                          : AppColors.surfaceVariant,
                      border: Border.all(
                        color:
                            _isHovering ? widget.data.color : AppColors.border,
                        width: 1.5,
                      ),
                      boxShadow: _isHovering
                          ? [
                              BoxShadow(
                                color: widget.data.color.withValues(alpha: 0.4),
                                blurRadius: 16,
                              ),
                            ]
                          : null,
                    ),
                    child: Icon(
                      widget.data.icon,
                      size: 16,
                      color: _isHovering
                          ? widget.data.color
                          : AppColors.textSecondary,
                    ),
                  ),
                  if (!widget.isLast)
                    Container(
                      width: 2,
                      height: 120,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            widget.data.color.withValues(alpha: 0.4),
                            AppColors.border.withValues(alpha: 0.3),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.lg),
          ],

          // Right Experience Card
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: widget.isLast ? 0 : AppSpacing.xl,
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(AppSpacing.xl),
                decoration: BoxDecoration(
                  color: _isHovering
                      ? AppColors.surfaceVariant
                      : AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(
                    color: _isHovering
                        ? widget.data.color.withValues(alpha: 0.5)
                        : AppColors.border,
                    width: 1,
                  ),
                  boxShadow: _isHovering
                      ? [
                          BoxShadow(
                            color: widget.data.color.withValues(alpha: 0.08),
                            blurRadius: 20,
                            offset: const Offset(0, 6),
                          ),
                        ]
                      : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Row: Role + Period Badge
                    // On mobile: icon + role/company stack, period badge on next line
                    // On desktop: role/company expanded + period badge inline
                    if (widget.isMobile) ...[  
                      // Mobile: icon + text side by side
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: widget.data.color.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                            ),
                            child: Icon(widget.data.icon,
                                size: 16, color: widget.data.color),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.data.role,
                                  style: GoogleFonts.spaceGrotesk(
                                    color: AppColors.textPrimary,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  widget.data.company,
                                  style: GoogleFonts.inter(
                                    color: widget.data.color,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      // Period badge on its own row on mobile
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: widget.data.isCurrent
                              ? AppColors.primary.withValues(alpha: 0.15)
                              : AppColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(AppRadius.full),
                          border: Border.all(
                            color: widget.data.isCurrent
                                ? AppColors.primaryLight.withValues(alpha: 0.4)
                                : AppColors.border,
                          ),
                        ),
                        child: Text(
                          widget.data.period,
                          style: GoogleFonts.sourceCodePro(
                            color: widget.data.isCurrent
                                ? AppColors.primaryLight
                                : AppColors.textSecondary,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ] else ...[  
                      // Desktop: role/company + inline period badge
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.data.role,
                                  style: GoogleFonts.spaceGrotesk(
                                    color: AppColors.textPrimary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  widget.data.company,
                                  style: GoogleFonts.inter(
                                    color: widget.data.color,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: widget.data.isCurrent
                                  ? AppColors.primary.withValues(alpha: 0.15)
                                  : AppColors.surfaceVariant,
                              borderRadius:
                                  BorderRadius.circular(AppRadius.full),
                              border: Border.all(
                                color: widget.data.isCurrent
                                    ? AppColors.primaryLight
                                        .withValues(alpha: 0.4)
                                    : AppColors.border,
                              ),
                            ),
                            child: Text(
                              widget.data.period,
                              style: GoogleFonts.sourceCodePro(
                                color: widget.data.isCurrent
                                    ? AppColors.primaryLight
                                    : AppColors.textSecondary,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: AppSpacing.md),
                    const Divider(color: AppColors.border, height: 1),
                    const SizedBox(height: AppSpacing.md),

                    // Highlights
                    ...widget.data.highlights.map(
                      (highlight) => Padding(
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
                                  color: widget.data.color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Text(
                                highlight,
                                style: GoogleFonts.inter(
                                  color: AppColors.textSecondary,
                                  fontSize: 14,
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
    );
  }
}
