import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import '../widgets/scroll_reveal.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  static final List<_ProjectData> _projects = [
    const _ProjectData(
      title: 'Exeat Management System',
      description:
          'A digital solution for university students to request exeat permissions. '
          'Includes real-time approval notifications and a comprehensive admin dashboard.',
      techStack: ['Flutter', 'Firebase', 'Dart'],
      icon: Icons.security_rounded,
      color: Color(0xFF6C63FF),
      liveUrl: 'https://exeat-management-system-project.vercel.app/',
    ),
    const _ProjectData(
      title: 'Personal Portfolio',
      description:
          'A modern, responsive personal portfolio website showcasing professional '
          'experience, skills, and featured technical projects.',
      techStack: ['Flutter Web', 'Dart', 'Responsive UI'],
      icon: Icons.person_rounded,
      color: Color(0xFF00D9FF),
    ),
    const _ProjectData(
      title: 'Jenious Landing Page',
      description:
          'A high-performance landing page developed for Jenious Agency, focusing '
          'on clean typography, smooth animations, and solid UX.',
      techStack: ['HTML', 'CSS', 'JavaScript'],
      icon: Icons.web_rounded,
      color: Color(0xFFE040FB),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 800;
    final isTablet = width >= 800 && width < 1100;

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
            key: ValueKey('proj_title'),
            child: SectionTitle(number: '03.', title: 'Featured Projects'),
          ),
          const SizedBox(height: AppSpacing.xxxl),
          // Project grid
          Wrap(
            spacing: AppSpacing.xl,
            runSpacing: AppSpacing.xl,
            children: List.generate(_projects.length, (index) {
              final project = _projects[index];
              final cardWidth = isMobile
                  ? width - (AppSpacing.xl * 2)
                  : isTablet
                      ? (width - AppSpacing.xxxl * 2 - AppSpacing.xl) / 2
                      : (1100 - AppSpacing.xxxl * 2 - AppSpacing.xl * 2) / 3;

              return ScrollReveal(
                key: ValueKey('proj_card_$index'),
                index: index,
                child: SizedBox(
                  width: cardWidth.clamp(280, 500),
                  child: _ProjectCard(data: project),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _ProjectData {
  final String title;
  final String description;
  final List<String> techStack;
  final IconData icon;
  final Color color;
  final String? liveUrl;
  final String? githubUrl;

  const _ProjectData({
    required this.title,
    required this.description,
    required this.techStack,
    required this.icon,
    required this.color,
    this.liveUrl,
    this.githubUrl,
  });
}

class _ProjectCard extends StatefulWidget {
  final _ProjectData data;

  const _ProjectCard({required this.data});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovering = false;

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: widget.data.liveUrl != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: () {
          if (widget.data.liveUrl != null) {
            _openUrl(widget.data.liveUrl!);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          transform: Matrix4.identity()
            ..translate(0.0, _isHovering ? -6.0 : 0.0),
          padding: const EdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecoration(
            color: _isHovering
                ? AppColors.surfaceVariant.withOpacity(0.8)
                : AppColors.surfaceVariant.withOpacity(0.4),
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: _isHovering
                  ? widget.data.color.withOpacity(0.4)
                  : AppColors.border.withOpacity(0.3),
              width: 1,
            ),
            boxShadow: _isHovering
                ? [
                    BoxShadow(
                      color: widget.data.color.withOpacity(0.15),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Icon
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: widget.data.color.withOpacity(
                        _isHovering ? 0.15 : 0.08,
                      ),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: Icon(
                      widget.data.icon,
                      color: widget.data.color,
                      size: 28,
                    ),
                  ),
                  // Action icons
                  Row(
                    children: [
                      if (widget.data.liveUrl != null)
                        _ActionIcon(
                          icon: Icons.open_in_new_rounded,
                          tooltip: 'Live Demo',
                          onTap: () => _openUrl(widget.data.liveUrl!),
                        ),
                      if (widget.data.githubUrl != null) ...[
                        const SizedBox(width: AppSpacing.sm),
                        _ActionIcon(
                          icon: Icons.code_rounded,
                          tooltip: 'Source Code',
                          onTap: () => _openUrl(widget.data.githubUrl!),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              // Title
              Text(
                widget.data.title,
                style: GoogleFonts.spaceGrotesk(
                  color:
                      _isHovering ? widget.data.color : AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              // Description
              Text(
                widget.data.description,
                style: GoogleFonts.inter(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  height: 1.6,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.xl),
              // Tech stack
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: widget.data.techStack.map((tech) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: widget.data.color.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Text(
                      tech,
                      style: GoogleFonts.inter(
                        color: widget.data.color.withOpacity(0.8),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionIcon extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _ActionIcon({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  State<_ActionIcon> createState() => _ActionIconState();
}

class _ActionIconState extends State<_ActionIcon> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        message: widget.tooltip,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: _isHovering
                  ? AppColors.primary.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Icon(
              widget.icon,
              color: _isHovering ? AppColors.primary : AppColors.textMuted,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
