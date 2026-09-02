import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'theme/app_theme.dart';
import 'widgets/common_widgets.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/experience_section.dart';
import 'sections/projects_section.dart';
import 'sections/contact_section.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daniel Ilesanmi — Full-Stack Developer & Mobile Engineer',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: AppTheme.darkTheme,
      home: const PortfolioScreen(),
    );
  }
}

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<double> _scrollOffsetNotifier = ValueNotifier<double>(0.0);

  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _scrollOffsetNotifier.value = _scrollController.offset;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollOffsetNotifier.dispose();
    super.dispose();
  }

  void _scrollToKey(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72),
        child: _NavBar(
          isMobile: isMobile,
          scrollNotifier: _scrollOffsetNotifier,
          onHomeTap: () => _scrollToKey(_homeKey),
          onAboutTap: () => _scrollToKey(_aboutKey),
          onExperienceTap: () => _scrollToKey(_experienceKey),
          onProjectsTap: () => _scrollToKey(_projectsKey),
          onContactTap: () => _scrollToKey(_contactKey),
        ),
      ),
      drawer: isMobile
          ? _MobileDrawer(
              onHomeTap: () => _scrollToKey(_homeKey),
              onAboutTap: () => _scrollToKey(_aboutKey),
              onExperienceTap: () => _scrollToKey(_experienceKey),
              onProjectsTap: () => _scrollToKey(_projectsKey),
              onContactTap: () => _scrollToKey(_contactKey),
            )
          : null,
      body: Stack(
        children: [
          // Background ambient gradient glow spots (static & lightweight)
          Positioned(
            top: -150,
            left: -150,
            child: IgnorePointer(
              child: Container(
                width: 500,
                height: 500,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.12),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 600,
            right: -200,
            child: IgnorePointer(
              child: Container(
                width: 600,
                height: 600,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.secondary.withValues(alpha: 0.08),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 400,
            left: -100,
            child: IgnorePointer(
              child: Container(
                width: 500,
                height: 500,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.accent.withValues(alpha: 0.06),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Main scrollable content
          SingleChildScrollView(
            controller: _scrollController,
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HeroSection(
                  key: _homeKey,
                  onContactTap: () => _scrollToKey(_contactKey),
                  onProjectsTap: () => _scrollToKey(_projectsKey),
                ),
                AboutSection(key: _aboutKey),
                ExperienceSection(key: _experienceKey),
                ProjectsSection(key: _projectsKey),
                ContactSection(key: _contactKey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Navigation bar — high-performance scroll opacity listener (zero page rebuilds)
class _NavBar extends StatelessWidget {
  final bool isMobile;
  final ValueNotifier<double> scrollNotifier;
  final VoidCallback onHomeTap;
  final VoidCallback onAboutTap;
  final VoidCallback onExperienceTap;
  final VoidCallback onProjectsTap;
  final VoidCallback onContactTap;

  const _NavBar({
    required this.isMobile,
    required this.scrollNotifier,
    required this.onHomeTap,
    required this.onAboutTap,
    required this.onExperienceTap,
    required this.onProjectsTap,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: scrollNotifier,
      builder: (context, offset, child) {
        final isScrolled = offset > 20;

        return ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: isScrolled ? 16 : 0, sigmaY: isScrolled ? 16 : 0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? AppSpacing.xl : AppSpacing.xxxl,
                vertical: AppSpacing.md,
              ),
              decoration: BoxDecoration(
                color: isScrolled
                    ? AppColors.background.withValues(alpha: 0.82)
                    : Colors.transparent,
                border: Border(
                  bottom: BorderSide(
                    color: isScrolled
                        ? AppColors.border.withValues(alpha: 0.6)
                        : Colors.transparent,
                  ),
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Brand Logo
                    GestureDetector(
                      onTap: onHomeTap,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                gradient: AppColors.primaryGradient,
                                borderRadius: BorderRadius.circular(AppRadius.sm),
                              ),
                              child: Text(
                                'D',
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            GradientText(
                              'ilesanmi.',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.5,
                              ),
                              gradient: AppColors.primaryGradient,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Desktop Nav Items
                    if (!isMobile)
                      Row(
                        children: [
                          _NavLink(text: 'Home', onTap: onHomeTap),
                          const SizedBox(width: AppSpacing.lg),
                          _NavLink(text: 'About', onTap: onAboutTap),
                          const SizedBox(width: AppSpacing.lg),
                          _NavLink(text: 'Experience', onTap: onExperienceTap),
                          const SizedBox(width: AppSpacing.lg),
                          _NavLink(text: 'Projects', onTap: onProjectsTap),
                          const SizedBox(width: AppSpacing.lg),
                          _NavLink(text: 'Contact', onTap: onContactTap),
                          const SizedBox(width: AppSpacing.xl),
                          const _GitHubButton(),
                        ],
                      )
                    else
                      Builder(
                        builder: (ctx) => IconButton(
                          icon: const Icon(
                            Icons.menu_rounded,
                            color: AppColors.primaryLight,
                            size: 26,
                          ),
                          onPressed: () => Scaffold.of(ctx).openDrawer(),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Navigation link with smooth hover styling
class _NavLink extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const _NavLink({required this.text, required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _isHovering
                ? AppColors.primary.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Text(
            widget.text,
            style: GoogleFonts.inter(
              color: _isHovering ? AppColors.textPrimary : AppColors.textSecondary,
              fontSize: 14,
              fontWeight: _isHovering ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

/// GitHub CTA in Navigation
class _GitHubButton extends StatefulWidget {
  const _GitHubButton();

  @override
  State<_GitHubButton> createState() => _GitHubButtonState();
}

class _GitHubButtonState extends State<_GitHubButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          try {
            await launchUrl(
              Uri.parse('https://github.com/Daniel-the-creator'),
              mode: LaunchMode.externalApplication,
            );
          } catch (_) {}
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: _isHovering
                ? AppColors.primary.withValues(alpha: 0.15)
                : AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(
              color: _isHovering ? AppColors.primaryLight : AppColors.border,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.code_rounded,
                size: 16,
                color: _isHovering ? AppColors.primaryLight : AppColors.textSecondary,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'GitHub',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _isHovering ? AppColors.textPrimary : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Mobile Drawer
class _MobileDrawer extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onAboutTap;
  final VoidCallback onExperienceTap;
  final VoidCallback onProjectsTap;
  final VoidCallback onContactTap;

  const _MobileDrawer({
    required this.onHomeTap,
    required this.onAboutTap,
    required this.onExperienceTap,
    required this.onProjectsTap,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Text(
                      'D',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  GradientText(
                    'ilesanmi.',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                    gradient: AppColors.primaryGradient,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xxxl),
              Container(
                height: 1,
                color: AppColors.border,
              ),
              const SizedBox(height: AppSpacing.xxl),
              _DrawerItem(
                number: '01',
                title: 'Home',
                onTap: () {
                  Navigator.pop(context);
                  onHomeTap();
                },
              ),
              _DrawerItem(
                number: '02',
                title: 'About',
                onTap: () {
                  Navigator.pop(context);
                  onAboutTap();
                },
              ),
              _DrawerItem(
                number: '03',
                title: 'Experience',
                onTap: () {
                  Navigator.pop(context);
                  onExperienceTap();
                },
              ),
              _DrawerItem(
                number: '04',
                title: 'Projects',
                onTap: () {
                  Navigator.pop(context);
                  onProjectsTap();
                },
              ),
              _DrawerItem(
                number: '05',
                title: 'Contact',
                onTap: () {
                  Navigator.pop(context);
                  onContactTap();
                },
              ),
              const Spacer(),
              SecondaryButton(
                text: 'Visit GitHub Profile',
                icon: Icons.open_in_new_rounded,
                onPressed: () async {
                  try {
                    await launchUrl(
                      Uri.parse('https://github.com/Daniel-the-creator'),
                      mode: LaunchMode.externalApplication,
                    );
                  } catch (_) {}
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerItem extends StatefulWidget {
  final String number;
  final String title;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.number,
    required this.title,
    required this.onTap,
  });

  @override
  State<_DrawerItem> createState() => _DrawerItemState();
}

class _DrawerItemState extends State<_DrawerItem> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.md,
            horizontal: AppSpacing.lg,
          ),
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          decoration: BoxDecoration(
            color: _isHovering
                ? AppColors.primary.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Row(
            children: [
              Text(
                widget.number,
                style: GoogleFonts.sourceCodePro(
                  color: AppColors.primaryLight,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              Text(
                widget.title,
                style: GoogleFonts.spaceGrotesk(
                  color: _isHovering ? AppColors.textPrimary : AppColors.textSecondary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
