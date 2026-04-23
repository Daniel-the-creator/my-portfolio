import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import '../widgets/scroll_reveal.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 800;

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
            key: ValueKey('about_title'),
            child: SectionTitle(number: '01.', title: 'About Me'),
          ),
          const SizedBox(height: AppSpacing.xxxl),
          isMobile ? _buildMobileLayout(context) : _buildDesktopLayout(context),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: _buildTextContent(context),
        ),
        const SizedBox(width: AppSpacing.xxxl),
        const Expanded(
          flex: 2,
          child: ScrollReveal(
            key: ValueKey('about_photo'),
            offset: Offset(40, 0),
            child: _ProfileImage(),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        const ScrollReveal(
          key: ValueKey('about_photo_mobile'),
          child: _ProfileImage(),
        ),
        const SizedBox(height: AppSpacing.xxl),
        _buildTextContent(context),
      ],
    );
  }

  Widget _buildTextContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScrollReveal(
          key: const ValueKey('about_p1'),
          index: 1,
          child: Text(
            "Creative and goal-driven full-stack developer with a strong passion for "
            "building functional, responsive, and user-friendly applications. Currently "
            "studying Software Engineering at Dominion University, Ibadan, and actively "
            "seeking remote/freelance opportunities where I can contribute to real-world "
            "projects while expanding my mobile and web development skills.",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        ScrollReveal(
          key: const ValueKey('about_p2'),
          index: 2,
          child: Text(
            "Experienced in Flutter, UI/UX design, and passionate about continuous "
            "learning, collaboration, and delivering value through technology. I'm also "
            "an active member of NACOS, UI/UX workshops, and tech communities.",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const SizedBox(height: AppSpacing.xxl),
        ScrollReveal(
          key: const ValueKey('about_tech_label'),
          index: 3,
          child: Text(
            "Technologies I work with",
            style: GoogleFonts.spaceGrotesk(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        const ScrollReveal(
          key: ValueKey('about_tech_badges'),
          index: 4,
          child: Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              TechBadge(label: 'Dart', icon: Icons.code_rounded),
              TechBadge(label: 'Flutter', icon: Icons.phone_android_rounded),
              TechBadge(label: 'Firebase', icon: Icons.cloud_rounded),
              TechBadge(label: 'HTML / CSS', icon: Icons.web_rounded),
              TechBadge(label: 'JavaScript', icon: Icons.javascript_rounded),
              TechBadge(label: 'Git & GitHub', icon: Icons.merge_rounded),
              TechBadge(label: 'Figma', icon: Icons.design_services_rounded),
              TechBadge(label: 'REST APIs', icon: Icons.api_rounded),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProfileImage extends StatefulWidget {
  const _ProfileImage();

  @override
  State<_ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<_ProfileImage> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..translate(0.0, _isHovering ? -8.0 : 0.0),
        child: Stack(
          children: [
            // Border decoration
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
              top: _isHovering ? 16 : 12,
              left: _isHovering ? 16 : 12,
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.4),
                    width: 2,
                  ),
                ),
              ),
            ),
            // Photo
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.xl),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                decoration: BoxDecoration(
                  boxShadow: _isHovering
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.2),
                            blurRadius: 30,
                          ),
                        ]
                      : [],
                ),
                child: ColorFiltered(
                  colorFilter: _isHovering
                      ? const ColorFilter.mode(
                          Colors.transparent, BlendMode.multiply)
                      : ColorFilter.mode(
                          AppColors.primary.withOpacity(0.15),
                          BlendMode.softLight,
                        ),
                  child: Image.asset(
                    'assets/profile.jpg',
                    width: 280,
                    height: 280,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 280,
                      height: 280,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(AppRadius.xl),
                      ),
                      child: const Icon(
                        Icons.person_rounded,
                        size: 80,
                        color: AppColors.textMuted,
                      ),
                    ),
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
