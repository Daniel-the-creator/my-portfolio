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
      title: 'Daniel Ilesanmi — Portfolio',
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
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  double _scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() => _scrollOffset = _scrollController.offset);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToKey(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72),
        child: _NavBar(
          isMobile: isMobile,
          scrollOffset: _scrollOffset,
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
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/background.gif',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: AppColors.background,
              ),
            ),
          ),
          // Dark overlay for readability
          Positioned.fill(
            child: Container(
              color: AppColors.background.withOpacity(0.75),
            ),
          ),
          // Ambient glow orbs
          Positioned(
            top: -200,
            left: -200,
            child: _GlowOrb(
              color: AppColors.primary.withOpacity(0.06),
              size: 500,
            ),
          ),
          Positioned(
            bottom: 300,
            right: -200,
            child: _GlowOrb(
              color: AppColors.accent.withOpacity(0.04),
              size: 600,
            ),
          ),
          Positioned(
            top: 900,
            left: 100,
            child: _GlowOrb(
              color: AppColors.tertiary.withOpacity(0.03),
              size: 400,
            ),
          ),
          // Content
          SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Column(
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
          ),
        ],
      ),
    );
  }
}

/// Glow orb — ambient background decoration
class _GlowOrb extends StatelessWidget {
  final Color color;
  final double size;

  const _GlowOrb({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withOpacity(color.opacity * 1.5),
            color.withOpacity(0),
          ],
        ),
      ),
    );
  }
}

/// Navigation bar with blur + scroll-aware opacity
class _NavBar extends StatelessWidget {
  final bool isMobile;
  final double scrollOffset;
  final VoidCallback onHomeTap;
  final VoidCallback onAboutTap;
  final VoidCallback onExperienceTap;
  final VoidCallback onProjectsTap;
  final VoidCallback onContactTap;

  const _NavBar({
    required this.isMobile,
    required this.scrollOffset,
    required this.onHomeTap,
    required this.onAboutTap,
    required this.onExperienceTap,
    required this.onProjectsTap,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    final bgOpacity = (scrollOffset / 200).clamp(0.0, 0.85);

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? AppSpacing.xl : AppSpacing.xxxl,
            vertical: AppSpacing.lg,
          ),
          decoration: BoxDecoration(
            color: AppColors.background.withOpacity(bgOpacity),
            border: Border(
              bottom: BorderSide(
                color: AppColors.border.withOpacity(
                  scrollOffset > 50 ? 0.3 : 0,
                ),
              ),
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo
                GestureDetector(
                  onTap: onHomeTap,
                  child: GradientText(
                    'Diles.',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                    gradient: AppColors.primaryGradient,
                  ),
                ),
                if (!isMobile)
                  Row(
                    children: [
                      _NavLink(text: 'Home', onTap: onHomeTap),
                      const SizedBox(width: AppSpacing.xl),
                      _NavLink(text: 'About', onTap: onAboutTap),
                      const SizedBox(width: AppSpacing.xl),
                      _NavLink(text: 'Experience', onTap: onExperienceTap),
                      const SizedBox(width: AppSpacing.xl),
                      _NavLink(text: 'Projects', onTap: onProjectsTap),
                      const SizedBox(width: AppSpacing.xl),
                      _NavLink(text: 'Contact', onTap: onContactTap),
                      const SizedBox(width: AppSpacing.xxl),
                      _GitHubButton(),
                    ],
                  )
                else
                  Builder(
                    builder: (ctx) => IconButton(
                      icon: const Icon(
                        Icons.menu_rounded,
                        color: AppColors.primary,
                        size: 28,
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
  }
}

/// Navigation link with hover underline
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: GoogleFonts.inter(
                color: _isHovering
                    ? AppColors.primary
                    : AppColors.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              child: Text(widget.text),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2,
              width: _isHovering ? 20 : 0,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// GitHub button in nav
class _GitHubButton extends StatefulWidget {
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
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: _isHovering
                ? AppColors.primary.withOpacity(0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(
              color: _isHovering
                  ? AppColors.primary
                  : AppColors.border,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.code_rounded,
                size: 16,
                color: _isHovering
                    ? AppColors.primary
                    : AppColors.textSecondary,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'GitHub',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _isHovering
                      ? AppColors.primary
                      : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Mobile drawer
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
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo
              GradientText(
                'Diles.',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
                gradient: AppColors.primaryGradient,
              ),
              const SizedBox(height: AppSpacing.xxxl),
              Container(
                height: 1,
                color: AppColors.border.withOpacity(0.3),
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
              // GitHub CTA at bottom
              SecondaryButton(
                text: 'GitHub',
                icon: Icons.code_rounded,
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
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.lg,
            horizontal: AppSpacing.lg,
          ),
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          decoration: BoxDecoration(
            color: _isHovering
                ? AppColors.primary.withOpacity(0.08)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Row(
            children: [
              Text(
                widget.number,
                style: GoogleFonts.spaceGrotesk(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              Text(
                widget.title,
                style: GoogleFonts.spaceGrotesk(
                  color: _isHovering
                      ? AppColors.primary
                      : AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
