import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/content_wrapper.dart';
import '../widgets/interactive_link.dart';
import '../widgets/brand_icons.dart';
import '../widgets/pulsing_status_dot.dart';


class HeroSection extends StatefulWidget {
  final VoidCallback onSeeWorkTap;
  final VoidCallback onContactTap;

  const HeroSection({
    super.key,
    required this.onSeeWorkTap,
    required this.onContactTap,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with TickerProviderStateMixin {
  late AnimationController _entranceController;
  late AnimationController _floatController;
  late Animation<double> _opacityAnim;
  late Animation<double> _translateAnim;
  late Animation<double> _rotateAnim;
  late Animation<double> _floatAnim;

  @override
  void initState() {
    super.initState();
    // Entrance Animation (one-shot)
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    final curved = CurvedAnimation(
      parent: _entranceController,
      curve: const Cubic(0.2, 0.7, 0.3, 1.0),
    );

    _opacityAnim = Tween<double>(begin: 0.0, end: 1.0).animate(curved);
    _translateAnim = Tween<double>(begin: 18.0, end: 0.0).animate(curved);
    _rotateAnim = Tween<double>(begin: 4.0 * math.pi / 180.0, end: 0.0).animate(curved);

    // Continuous Floating Animation
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    );

    _floatAnim = Tween<double>(begin: -5.0, end: 5.0).animate(
      CurvedAnimation(
        parent: _floatController,
        curve: Curves.easeInOutSine,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _entranceController.forward(from: 0);
      final prefersReducedMotion = MediaQuery.of(context).disableAnimations;
      if (!prefersReducedMotion) {
        _floatController.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= AppDimensions.mobileBreakpoint;
    final prefersReducedMotion = MediaQuery.of(context).disableAnimations;

    final textColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Live Availability Badge with pulsating green indicator
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.panel,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.success.withValues(alpha: 0.4)),
            boxShadow: [
              BoxShadow(
                color: AppColors.success.withValues(alpha: 0.12),
                blurRadius: 10,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const PulsingStatusDot(
                color: AppColors.success,
                size: 8.5,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  'Available for Mobile Developer Roles',
                  style: AppTypography.mono(
                    fontSize: 12,
                    color: AppColors.text,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // Eyebrow
        Text(
          'Junior Flutter Developer',
          style: AppTypography.mono(
            fontSize: 15,
            color: AppColors.accent,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 14),

        // Main Headline
        Text.rich(
          TextSpan(
            text: 'Building apps that hold up outside the ',
            style: AppTypography.heading(
              fontSize: isMobile ? 32 : 44,
              fontWeight: FontWeight.w500,
              height: 1.18,
            ),
            children: [
              TextSpan(
                text: 'happy path',
                style: AppTypography.heading(
                  fontSize: isMobile ? 32 : 44,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  color: AppColors.accentSoft,
                  height: 1.18,
                ),
              ),
              const TextSpan(text: '.'),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Bio
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(
            'Recent Computer Science graduate from Kafr El-Sheikh University, focused on Flutter, clean architecture, and REST API integration. Based in El-Mahmoudia, El-Beheira, Egypt.',
            style: AppTypography.body(
              fontSize: 16.5,
              color: AppColors.muted,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Quick Highlights Stats Row
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: [
            _buildStatBadge('📱 2+ Production Apps'),
            _buildStatBadge('⚡ Clean Architecture'),
            _buildStatBadge('🎓 CS Grad · GPA 3.35'),
          ],
        ),
        const SizedBox(height: 28),

        // CTA Buttons (CV Download + Contact)
        Wrap(
          spacing: 14,
          runSpacing: 12,
          children: [
            PrimaryButton(
              text: 'Download CV 📄',
              icon: Icons.file_download_outlined,
              onTap: downloadCv,
            ),
            GhostButton(
              text: 'Get in Touch 💬',
              icon: Icons.chat_bubble_outline,
              onTap: widget.onContactTap,
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Social Media Icons Row with Official Vector Brand Logos
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            SocialIconButton(
              iconBuilder: (color) => BrandIcons.github(color: color),
              tooltip: 'GitHub',
              activeColor: AppColors.text,
              onTap: () => openUrl('https://github.com/FaresFady'),
            ),
            SocialIconButton(
              iconBuilder: (color) => BrandIcons.linkedin(color: color),
              tooltip: 'LinkedIn',
              activeColor: const Color(0xFF0A66C2),
              onTap: () => openUrl('https://www.linkedin.com/in/fares-elhabashy-484b31295/'),
            ),
            SocialIconButton(
              iconBuilder: (color) => BrandIcons.facebook(color: color),
              tooltip: 'Facebook',
              activeColor: const Color(0xFF1877F2),
              onTap: () => openUrl('https://www.facebook.com/fares.elhabashy77'),
            ),
            SocialIconButton(
              iconBuilder: (color) => BrandIcons.instagram(color: color),
              tooltip: 'Instagram',
              activeColor: const Color(0xFFE4405F),
              onTap: () => openUrl('https://www.instagram.com/fares_elhabashy/'),
            ),
            SocialIconButton(
              iconBuilder: (color) => BrandIcons.whatsapp(color: color),
              tooltip: 'WhatsApp (+20 128 178 8394)',
              activeColor: const Color(0xFF25D366),
              onTap: () => openUrl('https://wa.me/201281788394?text=Hi%20Fares!%20I%20saw%20your%20Flutter%20portfolio.'),
            ),
            SocialIconButton(
              iconBuilder: (color) => BrandIcons.email(color: color),
              tooltip: 'Email (fareselhabashy7@gmail.com)',
              activeColor: AppColors.accent,
              onTap: () => openUrl('mailto:fareselhabashy7@gmail.com'),
            ),
          ],
        ),
      ],
    );

    // Prominent Portrait Card Showcase
    final portraitVisual = _buildHeroPortrait(isMobile, prefersReducedMotion);

    final animatedVisual = prefersReducedMotion
        ? portraitVisual
        : AnimatedBuilder(
            animation: _entranceController,
            builder: (context, child) {
              return Opacity(
                opacity: _opacityAnim.value.clamp(0.0, 1.0),
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.translationValues(0.0, _translateAnim.value, 0.0)
                    ..rotateZ(_rotateAnim.value),
                  child: child,
                ),
              );
            },
            child: portraitVisual,
          );

    final animatedTextColumn = prefersReducedMotion
        ? textColumn
        : AnimatedBuilder(
            animation: _entranceController,
            builder: (context, child) {
              return Opacity(
                opacity: _opacityAnim.value.clamp(0.0, 1.0),
                child: Transform.translate(
                  offset: Offset(0, _translateAnim.value),
                  child: child,
                ),
              );
            },
            child: textColumn,
          );

    return Container(
      padding: EdgeInsets.only(
        top: isMobile ? 44 : 84,
        bottom: isMobile ? 56 : 80,
      ),
      child: ContentWrapper(
        child: isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  animatedVisual,
                  const SizedBox(height: 36),
                  animatedTextColumn,
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 115,
                    child: animatedTextColumn,
                  ),
                  const SizedBox(width: 48),
                  Expanded(
                    flex: 85,
                    child: Center(child: animatedVisual),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildStatBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.panel,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.line),
      ),
      child: Text(
        text,
        style: AppTypography.mono(fontSize: 12, color: AppColors.stackText),
      ),
    );
  }

  Widget _buildHeroPortrait(bool isMobile, bool prefersReducedMotion) {
    final double portraitSize = isMobile ? 240.0 : 290.0;

    Widget portrait = SizedBox(
      width: portraitSize + 40,
      height: portraitSize + 50,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Ambient Glow Background
          Container(
            width: portraitSize,
            height: portraitSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.18),
                  blurRadius: 70,
                  spreadRadius: 10,
                ),
                BoxShadow(
                  color: AppColors.flutterBlue.withValues(alpha: 0.12),
                  blurRadius: 50,
                  spreadRadius: 5,
                ),
              ],
            ),
          ),

          // Main Portrait Circle
          Container(
            width: portraitSize,
            height: portraitSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.accent,
                width: 3,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.45),
                  blurRadius: 40,
                  offset: Offset(0, 20),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/profile.jpg',
                fit: BoxFit.cover,
                semanticLabel: 'Fares Elhabashy — Junior Flutter Developer',
              ),
            ),
          ),

          // Floating Chip 1: Top Right (Flutter & Dart)
          Positioned(
            top: 6,
            right: 0,
            child: prefersReducedMotion
                ? _buildFloatingGlassChip(
                    icon: Icons.code,
                    iconColor: AppColors.flutterBlue,
                    label: 'Flutter & Dart',
                  )
                : AnimatedBuilder(
                    animation: _floatAnim,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _floatAnim.value),
                        child: child,
                      );
                    },
                    child: _buildFloatingGlassChip(
                      icon: Icons.code,
                      iconColor: AppColors.flutterBlue,
                      label: 'Flutter & Dart',
                    ),
                  ),
          ),

          // Floating Chip 2: Bottom Left (Clean Architecture)
          Positioned(
            bottom: 16,
            left: 0,
            child: prefersReducedMotion
                ? _buildFloatingGlassChip(
                    icon: Icons.architecture,
                    iconColor: AppColors.accent,
                    label: 'Clean Arch',
                  )
                : AnimatedBuilder(
                    animation: _floatAnim,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, -_floatAnim.value),
                        child: child,
                      );
                    },
                    child: _buildFloatingGlassChip(
                      icon: Icons.architecture,
                      iconColor: AppColors.accent,
                      label: 'Clean Arch',
                    ),
                  ),
          ),
        ],
      ),
    );

    return portrait;
  }

  Widget _buildFloatingGlassChip({
    required IconData icon,
    required Color iconColor,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.panel.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.4), width: 1.2),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 14,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: iconColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTypography.mono(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.text,
            ),
          ),
        ],
      ),
    );
  }
}
