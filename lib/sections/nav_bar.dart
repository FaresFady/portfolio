import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/content_wrapper.dart';
import '../widgets/interactive_link.dart';

class NavBar extends StatelessWidget {
  final VoidCallback onWorkTap;
  final VoidCallback onSkillsTap;
  final VoidCallback onAboutTap;
  final VoidCallback onContactTap;

  const NavBar({
    super.key,
    required this.onWorkTap,
    required this.onSkillsTap,
    required this.onAboutTap,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= AppDimensions.mobileBreakpoint;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: AppDimensions.navHeight,
          decoration: BoxDecoration(
            color: AppColors.navBackground,
            border: Border(
              bottom: BorderSide(color: AppColors.line, width: 1),
            ),
          ),
          child: ContentWrapper(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Brand with Logo
                Flexible(
                  flex: isMobile ? 1 : 0,
                  fit: FlexFit.loose,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.accent,
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.accent.withValues(alpha: 0.25),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          'Fares Elhabashy',
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.heading(
                            fontSize: isMobile ? 16 : 19,
                            fontWeight: FontWeight.w600,
                            color: AppColors.text,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),

                // Right cluster: Nav links + CV + Theme switcher
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!isMobile) ...[
                      UnderlineLink(text: 'Work', onTap: onWorkTap, fontSize: 14.5),
                      const SizedBox(width: 22),
                      UnderlineLink(text: 'Skills', onTap: onSkillsTap, fontSize: 14.5),
                      const SizedBox(width: 22),
                      UnderlineLink(text: 'About', onTap: onAboutTap, fontSize: 14.5),
                      const SizedBox(width: 22),
                      UnderlineLink(text: 'Contact', onTap: onContactTap, fontSize: 14.5),
                      const SizedBox(width: 16),
                    ] else ...[
                      _mobileNavLink('Work', onWorkTap),
                      const SizedBox(width: 12),
                      _mobileNavLink('Skills', onSkillsTap),
                      const SizedBox(width: 12),
                      _mobileNavLink('Contact', onContactTap),
                      const SizedBox(width: 8),
                    ],
                    // Theme Switcher Toggle
                    const _ThemeToggle(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _mobileNavLink(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Text(
          text,
          style: AppTypography.body(
            fontSize: 13,
            color: AppColors.muted,
          ),
        ),
      ),
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  const _ThemeToggle();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, mode, _) {
        final isDark = mode == ThemeMode.dark;
        return Tooltip(
          message: isDark ? 'Switch to Light Mode ☀️' : 'Switch to Dark Mode 🌙',
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                themeNotifier.value = isDark ? ThemeMode.light : ThemeMode.dark;
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: AppColors.panel,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.accent.withValues(alpha: 0.4),
                    width: 1,
                  ),
                ),
                child: Icon(
                  isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                  size: 18,
                  color: AppColors.accent,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
