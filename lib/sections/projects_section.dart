import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  static const List<_ProjectData> _projects = [
    _ProjectData(
      title: 'Exeat Management System',
      category: 'Web/Mobile Application',
      description:
          'A comprehensive digital exeat permission system for university students. '
          'Features real-time approvals, instant push notifications, administrative analytics dashboard, and secure cloud authentication.',
      techStack: ['Flutter', 'Firebase', 'Dart', 'Cloud Firestore'],
      icon: Icons.security_rounded,
      imagePath: 'assets/exeat.png',
      gradient: LinearGradient(
        colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      accentColor: Color(0xFF818CF8),
      liveUrl: 'https://exeat-management-system-project.vercel.app/',
      githubUrl: null,
      isFeatured: true,
    ),
    _ProjectData(
      title: 'Personal Developer Portfolio',
      category: 'Web Application',
      description:
          'A high-performance personal portfolio website built with Flutter Web, '
          'featuring dark obsidian aesthetic, responsive layouts, smooth scroll navigation, and modern micro-interactions.',
      techStack: ['Flutter Web', 'Dart', 'Responsive UI', 'Glassmorphism'],
      icon: Icons.person_pin_circle_rounded,
      imagePath: null,
      gradient: LinearGradient(
        colors: [Color(0xFF06B6D4), Color(0xFF3B82F6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      accentColor: Color(0xFF38BDF8),
      liveUrl: null,
      githubUrl: 'https://github.com/Daniel-the-creator/my-portfolio',
      isFeatured: false,
    ),
    _ProjectData(
      title: 'Jenious Agency Website Page',
      category: 'Web/Mobile Application',
      description: 'A fast, responsive Website engineered for Jenious Agency, '
          'focused on conversion-driven UI, crisp typography, subtle scroll animations, and cross-browser responsiveness.',
      techStack: ['Flutter Web', 'Dart', 'Responsive UI', 'Glassmorphism'],
      icon: Icons.web_rounded,
      imagePath: 'assets/jenios.png',
      gradient: LinearGradient(
        colors: [Color(0xFFEC4899), Color(0xFF8B5CF6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      accentColor: Color(0xFFF472B6),
      liveUrl: 'https://jenios-agency.vercel.app/',
      githubUrl: null,
      isFeatured: false,
    ),
     _ProjectData(
      title: 'Abimot food and farm produce Website',
      category: 'Web/Mobile Application',
      description: 'A fast, responsive Website engineered for Abimot food and farm produce,'
          'focused on conversion-driven UI, crisp typography, subtle scroll animations, and cross-browser responsiveness.',
      techStack: ['Flutter Web', 'Dart', 'Responsive UI',],
      icon: Icons.web_rounded,
      imagePath: 'assets/abimot.png',
      gradient: LinearGradient(
        colors: [Color.fromARGB(255, 216, 23, 23), Color.fromARGB(255, 114, 203, 244)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      accentColor: Color.fromARGB(255, 246, 141, 92),
      liveUrl: 'https://abimot-food-and-farm-produce.vercel.app/',
      githubUrl: null,
      isFeatured: false,
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
                number: '03',
                title: 'Featured Projects',
                subtitle:
                    'Some of the real-world applications and digital products I have built',
              ),
              const SizedBox(height: AppSpacing.xxxl),

              // Projects Grid
              if (isMobile)
                Column(
                  children: _projects
                      .map((p) => Padding(
                            padding:
                                const EdgeInsets.only(bottom: AppSpacing.xl),
                            child: _ProjectCard(data: p),
                          ))
                      .toList(),
                )
              else
                Wrap(
                  spacing: AppSpacing.xl,
                  runSpacing: AppSpacing.xl,
                  children: _projects.map((p) {
                    const cardWidth = (1160 - AppSpacing.xl * 2) / 3;
                    return SizedBox(
                      width: cardWidth.clamp(320, 370),
                      child: _ProjectCard(data: p),
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

class _ProjectData {
  final String title;
  final String category;
  final String description;
  final List<String> techStack;
  final IconData icon;
  final String? imagePath;
  final Gradient gradient;
  final Color accentColor;
  final String? liveUrl;
  final String? githubUrl;
  final bool isFeatured;

  const _ProjectData({
    required this.title,
    required this.category,
    required this.description,
    required this.techStack,
    required this.icon,
    this.imagePath,
    required this.gradient,
    required this.accentColor,
    this.liveUrl,
    this.githubUrl,
    this.isFeatured = false,
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
    try {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } catch (_) {}
  }

  Widget _buildFallbackBanner() {
    return Container(
      decoration: BoxDecoration(
        gradient: widget.data.gradient,
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.15,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Colors.white.withValues(alpha: 0.2)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.25),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
              ),
              child: Icon(
                widget.data.icon,
                size: 44,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform:
            Matrix4.translationValues(0.0, _isHovering ? -6.0 : 0.0, 0.0),
        decoration: BoxDecoration(
          color: _isHovering ? AppColors.surfaceVariant : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(
            color: _isHovering
                ? widget.data.accentColor.withValues(alpha: 0.6)
                : AppColors.border,
            width: 1,
          ),
          boxShadow: _isHovering
              ? [
                  BoxShadow(
                    color: widget.data.accentColor.withValues(alpha: 0.15),
                    blurRadius: 28,
                    offset: const Offset(0, 10),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Banner Preview with Screenshot
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppRadius.xl - 1),
                topRight: Radius.circular(AppRadius.xl - 1),
              ),
              child: SizedBox(
                height: 180,
                width: double.infinity,
                child: Stack(
                  children: [
                    if (widget.data.imagePath != null)
                      Positioned.fill(
                        child: Image.asset(
                          widget.data.imagePath!,
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                          errorBuilder: (_, __, ___) => _buildFallbackBanner(),
                        ),
                      )
                    else
                      Positioned.fill(
                        child: _buildFallbackBanner(),
                      ),

                    // Gradient shade over image for readability
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              AppColors.surface.withValues(alpha: 0.75),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),

                    // Featured Badge
                    if (widget.data.isFeatured)
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(AppRadius.full),
                            border: Border.all(
                                color: widget.data.accentColor
                                    .withValues(alpha: 0.5)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star_rounded,
                                  size: 12, color: widget.data.accentColor),
                              const SizedBox(width: 4),
                              Text(
                                'FEATURED',
                                style: GoogleFonts.sourceCodePro(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.0,
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

            // Card Body
            Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data.category.toUpperCase(),
                    style: GoogleFonts.sourceCodePro(
                      color: widget.data.accentColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.data.title,
                    style: GoogleFonts.spaceGrotesk(
                      color: AppColors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    widget.data.description,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Tech Tags
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: widget.data.techStack.map((tech) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Text(
                          tech,
                          style: GoogleFonts.inter(
                            color: AppColors.textSecondary,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // Action Buttons
                  Row(
                    children: [
                      if (widget.data.liveUrl != null) ...[
                        Expanded(
                          child: _CardActionButton(
                            label: 'Live Demo',
                            icon: Icons.open_in_new_rounded,
                            isPrimary: true,
                            color: widget.data.accentColor,
                            onTap: () => _openUrl(widget.data.liveUrl!),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                      ],
                      if (widget.data.githubUrl != null)
                        Expanded(
                          child: _CardActionButton(
                            label: 'Source Code',
                            icon: Icons.code_rounded,
                            isPrimary: widget.data.liveUrl == null,
                            color: widget.data.accentColor,
                            onTap: () => _openUrl(widget.data.githubUrl!),
                          ),
                        ),
                      if (widget.data.liveUrl == null &&
                          widget.data.githubUrl == null)
                        Expanded(
                          child: _CardActionButton(
                            label: 'Client Project',
                            icon: Icons.lock_outline_rounded,
                            isPrimary: false,
                            color: widget.data.accentColor,
                            onTap: () {},
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardActionButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final Color color;
  final VoidCallback onTap;

  const _CardActionButton({
    required this.label,
    required this.icon,
    required this.isPrimary,
    required this.color,
    required this.onTap,
  });

  @override
  State<_CardActionButton> createState() => _CardActionButtonState();
}

class _CardActionButtonState extends State<_CardActionButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          decoration: BoxDecoration(
            color: widget.isPrimary
                ? (_hover
                    ? widget.color.withValues(alpha: 0.9)
                    : widget.color.withValues(alpha: 0.8))
                : (_hover
                    ? AppColors.surfaceElevated
                    : AppColors.surfaceVariant),
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(
              color: widget.isPrimary
                  ? widget.color
                  : (_hover
                      ? widget.color.withValues(alpha: 0.5)
                      : AppColors.border),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  color:
                      widget.isPrimary ? Colors.black : AppColors.textPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 6),
              Icon(
                widget.icon,
                size: 14,
                color:
                    widget.isPrimary ? Colors.black : AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
