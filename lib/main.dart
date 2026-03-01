import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daniel Ilesanmi - Portfolio',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A192F),
        primaryColor: const Color(0xFF64FFDA),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF64FFDA),
          secondary: Color(0xFFCCD6F6),
          surface: Color(0xFF112240),
        ),
        textTheme: GoogleFonts.interTextTheme(
          ThemeData.dark().textTheme,
        ).copyWith(
          displayLarge: GoogleFonts.outfit(
            color: const Color(0xFFCCD6F6),
            fontWeight: FontWeight.bold,
          ),
          displayMedium: GoogleFonts.outfit(
            color: const Color(0xFFCCD6F6),
            fontWeight: FontWeight.bold,
          ),
          headlineLarge: GoogleFonts.outfit(
            color: const Color(0xFFCCD6F6),
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: GoogleFonts.inter(
            color: const Color(0xFF8892B0),
          ),
          bodyMedium: GoogleFonts.inter(
            color: const Color(0xFF8892B0),
          ),
        ),
      ),
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

  void _scrollToKey(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: _buildNavBar(isMobile),
      ),
      drawer: isMobile ? _buildDrawer() : null,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Center(
          child: Column(
            children: [
              HeroSection(
                  key: _homeKey, onContactTap: () => _scrollToKey(_contactKey)),
              AboutSection(key: _aboutKey),
              ExperienceSection(key: _experienceKey),
              ProjectsSection(key: _projectsKey),
              ContactSection(key: _contactKey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavBar(bool isMobile) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
      color:
          const Color(0xFF0A192F).withOpacity(0.9), // Glassmorphism effect base
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Daniel',
            style: GoogleFonts.outfit(
              color: const Color(0xFF64FFDA),
              fontSize: 28,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          if (!isMobile)
            Row(
              children: [
                _navItem('Home', _homeKey),
                const SizedBox(width: 30),
                _navItem('About', _aboutKey),
                const SizedBox(width: 30),
                _navItem('Experience', _experienceKey),
                const SizedBox(width: 30),
                _navItem('Projects', _projectsKey),
                const SizedBox(width: 30),
                _navItem('Contact', _contactKey),
                const SizedBox(width: 30),
                ElevatedButton(
                  onPressed: () async {
                    final Uri url =
                        Uri.parse('https://github.com/Daniel-the-creator');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: const Color(0xFF64FFDA),
                    side:
                        const BorderSide(color: Color(0xFF64FFDA), width: 1.5),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('GitHub'),
                )
              ],
            )
          else
            Builder(builder: (context) {
              return IconButton(
                icon:
                    const Icon(Icons.menu, color: Color(0xFF64FFDA), size: 32),
                onPressed: () => Scaffold.of(context).openDrawer(),
              );
            }),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFF112240),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _drawerItem('Home', _homeKey),
            const SizedBox(height: 20),
            _drawerItem('About', _aboutKey),
            const SizedBox(height: 20),
            _drawerItem('Experience', _experienceKey),
            const SizedBox(height: 20),
            _drawerItem('Projects', _projectsKey),
            const SizedBox(height: 20),
            _drawerItem('Contact', _contactKey),
          ],
        ),
      ),
    );
  }

  Widget _navItem(String title, GlobalKey key) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _scrollToKey(key),
        child: Text(
          title,
          style: GoogleFonts.inter(
            color: const Color(0xFFCCD6F6),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _drawerItem(String title, GlobalKey key) {
    return ListTile(
      title: Center(
        child: Text(
          title,
          style: GoogleFonts.inter(
            color: const Color(0xFFCCD6F6),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        _scrollToKey(key);
      },
    );
  }
}

class HeroSection extends StatelessWidget {
  final VoidCallback onContactTap;

  const HeroSection({super.key, required this.onContactTap});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 800;

    return Container(
      constraints: const BoxConstraints(maxWidth: 1000, minHeight: 800),
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hi, my name is',
            style: GoogleFonts.inter(
              color: const Color(0xFF64FFDA),
              fontSize: 18,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Daniel Ilesanmi Oluwamayowa.',
            style: GoogleFonts.outfit(
              color: const Color(0xFFCCD6F6),
              fontSize: isMobile ? 50 : 80,
              fontWeight: FontWeight.w800,
              height: 1.1,
            ),
          ),
          Text(
            'I build applications both mobile and web.',
            style: GoogleFonts.outfit(
              color: const Color(0xFF8892B0),
              fontSize: isMobile ? 35 : 60,
              fontWeight: FontWeight.w800,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: 600,
            child: Text(
              "I'm a full-stack Developer and Mobile App Enthusiast, currently studying Software Engineering at Dominion University. I act as the Head of Frontend Developers at Jenious Agency, building functional, responsive, and user-friendly applications.",
              style: GoogleFonts.inter(
                color: const Color(0xFF8892B0),
                fontSize: 18,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: onContactTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: const Color(0xFF64FFDA),
              side: const BorderSide(color: Color(0xFF64FFDA), width: 1.5),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Get In Touch',
              style:
                  GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      constraints: const BoxConstraints(maxWidth: 1000),
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('About Me'),
          const SizedBox(height: 40),
          Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Creative and goal-driven full stack developer with a strong passion for building functional, responsive, and user-friendly applications. Currently studying Software Engineering at Dominion University, Ibadan, and actively seeking remote/freelance opportunities where I can contribute to real-world projects while expanding my mobile and web development skills.",
                      style: GoogleFonts.inter(
                        color: const Color(0xFF8892B0),
                        fontSize: 18,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Experienced in Flutter, UI/UX design, and passionate about continuous learning, collaboration, and delivering value through technology. I'm also an active member of NACOS, UI/UX workshops, and tech communities.",
                      style: GoogleFonts.inter(
                        color: const Color(0xFF8892B0),
                        fontSize: 18,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "Here are a few technologies I work with:",
                      style: GoogleFonts.inter(
                        color: const Color(0xFF8892B0),
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTechList(
                            ['Dart (Flutter)', 'Firebase', 'HTML / CSS']),
                        const SizedBox(width: 40),
                        _buildTechList(
                            ['Git & GitHub', 'UI/UX (Figma)', 'VS Code']),
                        if (!isMobile) const SizedBox(width: 40),
                      ],
                    )
                  ],
                ),
              ),
              if (isMobile) const SizedBox(height: 50),
              if (!isMobile) const SizedBox(width: 50),
              Expanded(
                flex: 2,
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: const Color(0xFF64FFDA), width: 2),
                        ),
                        margin: const EdgeInsets.only(top: 20, left: 20),
                      ),
                      Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          color: const Color(0xFF112240),
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                            image:
                                NetworkImage('https://via.placeholder.com/250'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: GoogleFonts.outfit(
            color: const Color(0xFFCCD6F6),
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Container(
            height: 1,
            color: const Color(0xFF233554),
          ),
        )
      ],
    );
  }

  Widget _buildTechList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.arrow_right, color: Color(0xFF64FFDA), size: 20),
              const SizedBox(width: 8),
              Text(
                item,
                style: GoogleFonts.inter(
                  color: const Color(0xFF8892B0),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 1000),
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Where I’ve Worked & Studied',
                style: GoogleFonts.outfit(
                  color: const Color(0xFFCCD6F6),
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Container(
                  height: 1,
                  color: const Color(0xFF233554),
                ),
              )
            ],
          ),
          const SizedBox(height: 50),
          _buildExperienceItem(
            'Head of Frontend Developers',
            'Jenious Agency',
            'Present',
            [
              'Leading the frontend development team to build engaging user interfaces.',
              'Collaborating with designers and backend engineers to deliver high-quality web applications.',
            ],
          ),
          _buildExperienceItem(
            'Freelance Mobile Developer',
            'Remote',
            '2024 - Present',
            [
              'Designed and built cross-platform mobile apps using Flutter for student use cases, including an Exeat Management system.',
              'Integrated Firebase for authentication and real-time database functionality.',
              'Focused on creating an intuitive user experience and responsive UI.',
            ],
          ),
          _buildExperienceItem(
            'Full-Stack Developer (Project-Based)',
            'Personal & School Projects',
            '2023 - Present',
            [
              'Developed full-stack web and mobile applications from scratch.',
              'Created detailed UI mockups and wireframes using Figma.',
            ],
          ),
          _buildExperienceItem(
            'B.Sc. Software Engineering',
            'Dominion University, Ibadan',
            '2022 - Present',
            [
              'Relevant Coursework focusing on software architecture, algorithms, and applications.',
              'Active in coding competitions, UI/UX workshops, and tech communities.',
              'Member of NACOS.',
            ],
          ),
          _buildExperienceItem(
            'Intern – IT Support & Digital Solutions',
            'CYCONET Nigeria (SIWES)',
            'Aug 2025 - Oct 2025',
            [
              'Assisted in diagnosing and resolving technical issues.',
              'Supported the team in building and scaling digital applications.',
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceItem(
      String title, String company, String date, List<String> details) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  color: const Color(0xFFCCD6F6),
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '@ $company',
                style: GoogleFonts.inter(
                  color: const Color(0xFF64FFDA),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            date,
            style: GoogleFonts.inter(
              color: const Color(0xFF8892B0),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: details.map((detail) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 6.0),
                      child: Icon(Icons.arrow_right,
                          color: Color(0xFF64FFDA), size: 18),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        detail,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF8892B0),
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      constraints: const BoxConstraints(maxWidth: 1000),
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Some Things I’ve Built',
                style: GoogleFonts.outfit(
                  color: const Color(0xFFCCD6F6),
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Container(
                  height: 1,
                  color: const Color(0xFF233554),
                ),
              )
            ],
          ),
          const SizedBox(height: 50),
          GridView.count(
            crossAxisCount: isMobile ? 1 : 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: isMobile ? 1.2 : 1.5,
            children: [
              _buildProjectCard(
                'Exeat Management System',
                'A mobile application built to enable students to request exeat permissions digitally. Features include real-time approval notifications and a comprehensive admin dashboard.',
                ['Flutter', 'Firebase', 'Dart'],
              ),
              _buildProjectCard(
                'Personal Web Portfolio',
                'A responsive personal portfolio website showcasing my experiences, skills, and projects, built using Flutter Web with modern aesthetics.',
                ['Flutter Web', 'Dart', 'Responsive UI'],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildProjectCard(
      String title, String description, List<String> tech) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF112240),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.folder_open, color: Color(0xFF64FFDA), size: 40),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.code, color: Color(0xFF8892B0)),
                    onPressed: () {},
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: GoogleFonts.outfit(
              color: const Color(0xFFCCD6F6),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Text(
              description,
              style: GoogleFonts.inter(
                color: const Color(0xFF8892B0),
                fontSize: 15,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 10,
            children: tech
                .map(
                  (t) => Text(
                    t,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF64FFDA),
                      fontSize: 13,
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 800),
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 150.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "What's Next?",
            style: GoogleFonts.inter(
              color: const Color(0xFF64FFDA),
              fontSize: 16,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Get In Touch',
            style: GoogleFonts.outfit(
              color: const Color(0xFFCCD6F6),
              fontSize: 50,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            "I'm actively seeking remote or freelance opportunities where I can contribute to real-world projects. Whether you have a question, a project offer, or just want to connect, feel free to reach out!",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF8892B0),
              fontSize: 18,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.phone, color: Color(0xFF64FFDA), size: 20),
              const SizedBox(width: 10),
              Text(
                '+234 704 567 8882',
                style: GoogleFonts.inter(
                    color: const Color(0xFFCCD6F6), fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on, color: Color(0xFF64FFDA), size: 20),
              const SizedBox(width: 10),
              Text(
                'Ibadan, Nigeria',
                style: GoogleFonts.inter(
                    color: const Color(0xFFCCD6F6), fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () async {
              final Uri emailLaunchUri = Uri(
                scheme: 'mailto',
                path: 'danielilesanmi04@gmail.com',
                queryParameters: {'subject': 'Hello from your portfolio!'},
              );
              try {
                await launchUrl(emailLaunchUri);
              } catch (e) {
                // Ignore
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: const Color(0xFF64FFDA),
              side: const BorderSide(color: Color(0xFF64FFDA), width: 1.5),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Say Hello',
              style:
                  GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 100),
          Text(
            'Built with Flutter by Daniel Ilesanmi. Designed with Style.',
            style: GoogleFonts.inter(
              color: const Color(0xFF8892B0),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
