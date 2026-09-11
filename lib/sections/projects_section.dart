import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/content_wrapper.dart';
import '../widgets/interactive_link.dart';
import '../widgets/scroll_reveal.dart';


class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= AppDimensions.mobileBreakpoint;

    return Container(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 48 : 76),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.line, width: 1),
        ),
      ),
      child: ContentWrapper(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Head
            ScrollReveal(
              direction: RevealDirection.up,
              child: _buildSectionHead(isMobile),
            ),

            SizedBox(height: isMobile ? 32 : 48),

            // Project 1: KUH-E-Clinic (slides in)
            ScrollReveal(
              direction: isMobile ? RevealDirection.up : RevealDirection.left,
              offsetDistance: 38,
              child: _buildProjectCard(
                context: context,
                isMobile: isMobile,
                isReverse: false,
                imageAsset: 'assets/images/project_kuh_e_clinic.jpg',
                imageAlt: 'KUH-E-Clinic app screens for doctor, nurse, and hospital manager roles',
                meta: 'Graduation project · Oct 2025 – Jun 2026',
                title: 'KUH-E-Clinic — a hospital system built for four different kinds of users',
                description:
                    'My graduation project was a hospital management app built with Flutter and Clean Architecture. It had to work for doctors, nurses, admins, and hospital managers at once, each with a completely different workflow — which is what pushed me to actually learn how to structure an app properly instead of just making it work. REST APIs handle the real-time data exchange between roles, and the whole thing follows an MVVM structure so it can grow without turning into a mess.',
                stack: ['Flutter', 'Dart', 'Clean Architecture', 'REST APIs', 'MVVM'],
                codeUrl: 'https://github.com/FaresFady/KUH-E-Clinic-MyVersion',
              ),
            ),

            // Divider between projects
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Container(
                height: 1,
                color: AppColors.line,
              ),
            ),

            // Project 2: NewsPulse (slides in)
            ScrollReveal(
              direction: isMobile ? RevealDirection.up : RevealDirection.right,
              offsetDistance: 38,
              child: _buildProjectCard(
                context: context,
                isMobile: isMobile,
                isReverse: true,
                imageAsset: 'assets/images/project_newspulse.jpg',
                imageAlt: 'NewsPulse settings screen showing Arabic and English support with dark mode',
                meta: 'Side project · Jul – Aug 2026',
                title: 'NewsPulse — a news app that doesn\'t break when the internet does',
                description:
                    'NewsPulse started as a way to practice Flutter outside of coursework. It\'s grown into a fully bilingual (Arabic/English) news reader with a dark mode for late-night reading, live search, and smooth custom animations. The detail I\'m most proud of: if the API hits its rate limit or the connection drops, the app quietly falls back to local data instead of showing an empty screen.',
                stack: ['Flutter', 'Dart', 'REST APIs', 'Local Storage', 'Dark Mode'],
                codeUrl: 'https://github.com/FaresFady/NewsPulse-App',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHead(bool isMobile) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (isMobile || constraints.maxWidth < 640) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selected projects',
                style: AppTypography.heading(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Two apps built end to end — from architecture decisions down to the small details that make them hold up in real use.',
                style: AppTypography.body(
                  fontSize: 15,
                  color: AppColors.muted,
                  height: 1.5,
                ),
              ),
            ],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              'Selected projects',
              style: AppTypography.heading(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 24),
            Flexible(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 380),
                child: Text(
                  'Two apps built end to end — from architecture decisions down to the small details that make them hold up in real use.',
                  style: AppTypography.body(
                    fontSize: 15,
                    color: AppColors.muted,
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProjectCard({
    required BuildContext context,
    required bool isMobile,
    required bool isReverse,
    required String imageAsset,
    required String imageAlt,
    required String meta,
    required String title,
    required String description,
    required List<String> stack,
    required String codeUrl,
  }) {
    final mediaWidget = _InteractiveProjectMedia(
      imageAsset: imageAsset,
      imageAlt: imageAlt,
      projectTitle: title,
    );

    final bodyWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          meta,
          style: AppTypography.mono(
            fontSize: 13,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: AppTypography.heading(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          description,
          style: AppTypography.body(
            fontSize: 15.5,
            color: AppColors.muted,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 18),
        // Modern Tech Stack Badges
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: stack
              .map(
                (tech) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.panel,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.line),
                  ),
                  child: Text(
                    tech,
                    style: AppTypography.mono(
                      fontSize: 12,
                      color: AppColors.stackText,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 20),
        UnderlineLink(
          text: 'View the code →',
          onTap: () => openUrl(codeUrl),
          fontSize: 14.5,
          normalColor: AppColors.text,
          hoverColor: AppColors.accentSoft,
          normalBorderColor: AppColors.accent,
          hoverBorderColor: AppColors.accentSoft,
        ),
      ],
    );

    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            mediaWidget,
            const SizedBox(height: 24),
            bodyWidget,
          ],
        ),
      );
    }

    final children = isReverse
        ? [
            Expanded(child: bodyWidget),
            const SizedBox(width: 48),
            Expanded(child: mediaWidget),
          ]
        : [
            Expanded(child: mediaWidget),
            const SizedBox(width: 48),
            Expanded(child: bodyWidget),
          ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}

class _InteractiveProjectMedia extends StatefulWidget {
  final String imageAsset;
  final String imageAlt;
  final String projectTitle;

  const _InteractiveProjectMedia({
    required this.imageAsset,
    required this.imageAlt,
    required this.projectTitle,
  });

  @override
  State<_InteractiveProjectMedia> createState() => _InteractiveProjectMediaState();
}

class _InteractiveProjectMediaState extends State<_InteractiveProjectMedia> {
  bool _isHovered = false;

  void _showImageModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogCtx) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 1000, maxHeight: 800),
              decoration: BoxDecoration(
                color: AppColors.panel,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.accent.withValues(alpha: 0.5), width: 1.5),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black87,
                    blurRadius: 40,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      color: AppColors.background,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.projectTitle,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.heading(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close, color: AppColors.muted),
                            onPressed: () => Navigator.of(dialogCtx).pop(),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: InteractiveViewer(
                        child: Image.asset(
                          widget.imageAsset,
                          fit: BoxFit.contain,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => _showImageModal(context),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _isHovered ? AppColors.accent.withValues(alpha: 0.8) : AppColors.line,
              width: 1.5,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.15),
                      blurRadius: 24,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Image.asset(
                  widget.imageAsset,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  semanticLabel: widget.imageAlt,
                ),
              ),
              // Subtle zoom hint on hover
              Positioned(
                bottom: 12,
                right: 12,
                child: AnimatedOpacity(
                  opacity: _isHovered ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 180),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.background.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.accent.withValues(alpha: 0.4)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.fullscreen, size: 16, color: AppColors.accent),
                        const SizedBox(width: 4),
                        Text(
                          'View Fullscreen',
                          style: AppTypography.mono(fontSize: 11, color: AppColors.text),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
