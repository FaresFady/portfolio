import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/content_wrapper.dart';
import '../widgets/scroll_reveal.dart';

class SkillCategory {
  final String label;
  final IconData icon;
  final List<String> tags;

  const SkillCategory({
    required this.label,
    required this.icon,
    required this.tags,
  });
}

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  static const List<SkillCategory> categories = [
    SkillCategory(
      label: 'Flutter development',
      icon: Icons.phone_android,
      tags: [
        'Stateless & Stateful Widgets',
        'App Navigation',
        'MVVM Architecture',
        'Custom Widgets & Themes',
        'Material Design',
        'Local Storage',
      ],
    ),
    SkillCategory(
      label: 'Backend & APIs',
      icon: Icons.cloud_outlined,
      tags: [
        'RESTful APIs',
        'JSON Parsing',
        'Firebase Auth',
        'Cloud Firestore',
        'HTTP Client',
      ],
    ),
    SkillCategory(
      label: 'Code quality',
      icon: Icons.architecture,
      tags: [
        'Clean Architecture',
        'MVVM Pattern',
        'OOP Principles',
        'Data Structures',
        'Algorithms',
      ],
    ),
    SkillCategory(
      label: 'Tools & languages',
      icon: Icons.terminal,
      tags: [
        'Dart',
        'Git & GitHub',
        'C++',
        'C#',
        'Python (basic)',
        'Java (beginner)',
        'MySQL (basic)',
      ],
    ),
  ];

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

            // Skills Grid
            if (isMobile)
              ScrollReveal(
                direction: RevealDirection.up,
                offsetDistance: 32,
                child: Column(
                  children: categories.map((cat) => _buildCategoryCard(cat)).toList(),
                ),
              )
            else
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ScrollReveal(
                      direction: RevealDirection.up,
                      delayMs: 0,
                      offsetDistance: 32,
                      child: Column(
                        children: [
                          _buildCategoryCard(categories[0]),
                          const SizedBox(height: 24),
                          _buildCategoryCard(categories[2]),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                  Expanded(
                    child: ScrollReveal(
                      direction: RevealDirection.up,
                      delayMs: 80,
                      offsetDistance: 32,
                      child: Column(
                        children: [
                          _buildCategoryCard(categories[1]),
                          const SizedBox(height: 24),
                          _buildCategoryCard(categories[3]),
                        ],
                      ),
                    ),
                  ),
                ],
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
                'Skills',
                style: AppTypography.heading(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'What I actually reach for day to day, grouped the way I think about them.',
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
              'Skills',
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
                  'What I actually reach for day to day, grouped the way I think about them.',
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

  Widget _buildCategoryCard(SkillCategory cat) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.panel,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.line, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(cat.icon, size: 18, color: AppColors.accent),
              const SizedBox(width: 10),
              Text(
                cat.label,
                style: AppTypography.mono(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: cat.tags.map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppColors.line),
                ),
                child: Text(
                  tag,
                  style: AppTypography.body(
                    fontSize: 13,
                    color: AppColors.text,
                    height: 1.2,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
