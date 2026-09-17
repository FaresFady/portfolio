import 'package:flutter/material.dart';
import 'theme/app_theme.dart';

import 'sections/nav_bar.dart';

import 'sections/hero_section.dart';
import 'sections/projects_section.dart';
import 'sections/skills_section.dart';
import 'sections/education_section.dart';
import 'sections/contact_section.dart';
import 'sections/footer_section.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, mode, _) {
        return MaterialApp(
          title: 'Fares Elhabashy — Junior Flutter Developer',
          debugShowCheckedModeBanner: false,
          themeMode: mode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: const PortfolioHomePage(),
        );
      },
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final GlobalKey _workKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  final ScrollController _scrollController = ScrollController();
  bool _showBackToTop = false;
  bool _didPrecache = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didPrecache) {
      _didPrecache = true;
      precacheImage(const AssetImage('assets/images/profile.jpg'), context);
      precacheImage(const AssetImage('assets/images/hero_newspulse.jpg'), context);
      precacheImage(const AssetImage('assets/images/project_kuh_e_clinic.jpg'), context);
      precacheImage(const AssetImage('assets/images/project_newspulse.jpg'), context);
    }
  }

  void _onScroll() {
    if (_scrollController.offset > 400 && !_showBackToTop) {
      setState(() => _showBackToTop = true);
    } else if (_scrollController.offset <= 400 && _showBackToTop) {
      setState(() => _showBackToTop = false);
    }
  }

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
        alignment: 0.08,
      );
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, _) {
        return Scaffold(
          backgroundColor: AppColors.background,
          floatingActionButton: AnimatedOpacity(
            opacity: _showBackToTop ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 250),
            child: _showBackToTop
                ? FloatingActionButton.small(
                    onPressed: _scrollToTop,
                    backgroundColor: AppColors.panel,
                    foregroundColor: AppColors.accent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: AppColors.accent.withValues(alpha: 0.5)),
                    ),
                    tooltip: 'Back to top',
                    child: const Icon(Icons.arrow_upward, size: 18),
                  )
                : const SizedBox.shrink(),
          ),
          body: Stack(
            children: [
              // Main Scrollable Page Content
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Spacer for sticky navbar height
                    const SizedBox(height: AppDimensions.navHeight),

                    // 1. Hero Section
                    RepaintBoundary(
                      child: HeroSection(
                        onSeeWorkTap: () => _scrollTo(_workKey),
                        onContactTap: () => _scrollTo(_contactKey),
                      ),
                    ),

                    // 2. Selected Projects Section
                    RepaintBoundary(
                      child: Container(
                        key: _workKey,
                        child: ProjectsSection(),
                      ),
                    ),

                    // 3. Skills Section
                    RepaintBoundary(
                      child: Container(
                        key: _skillsKey,
                        child: SkillsSection(),
                      ),
                    ),

                    // 4. Education Section
                    RepaintBoundary(
                      child: Container(
                        key: _aboutKey,
                        child: EducationSection(),
                      ),
                    ),

                    // 5. Contact / Feedback Section
                    RepaintBoundary(
                      child: Container(
                        key: _contactKey,
                        child: ContactSection(),
                      ),
                    ),

                    // Footer
                    RepaintBoundary(
                      child: FooterSection(),
                    ),

                  ],
                ),
              ),

              // Pinned Sticky Navigation Bar
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: RepaintBoundary(
                  child: NavBar(
                    onWorkTap: () => _scrollTo(_workKey),
                    onSkillsTap: () => _scrollTo(_skillsKey),
                    onAboutTap: () => _scrollTo(_aboutKey),
                    onContactTap: () => _scrollTo(_contactKey),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
