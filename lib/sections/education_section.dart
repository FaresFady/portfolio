import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/content_wrapper.dart';
import '../widgets/scroll_reveal.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= AppDimensions.mobileBreakpoint;

    final col1 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildEntry(
          when: '2022 – 2026',
          what: 'B.Sc. Computer Science (Information Technology)',
          where:
              'Kafr El-Sheikh University, Faculty of Computers and Information · GPA 3.35',
        ),
        const SizedBox(height: 26),
        _buildEntry(
          when: 'May – Oct 2024',
          what: 'Master Computer Science',
          where: 'Route Academy · certificate',
        ),
      ],
    );

    final col2 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildEntry(
          when: 'Languages',
          what: 'Arabic · native',
          where: 'English · CEFR B1 (Intermediate)',
        ),
      ],
    );

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
              child: Text(
                'Education',
                style: AppTypography.heading(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: isMobile ? 32 : 48),

            // Education Grid
            if (isMobile)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ScrollReveal(
                    direction: RevealDirection.up,
                    delayMs: 60,
                    child: col1,
                  ),
                  const SizedBox(height: 26),
                  ScrollReveal(
                    direction: RevealDirection.up,
                    delayMs: 140,
                    child: col2,
                  ),
                ],
              )
            else
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ScrollReveal(
                      direction: RevealDirection.up,
                      delayMs: 60,
                      child: col1,
                    ),
                  ),
                  const SizedBox(width: 56),
                  Expanded(
                    child: ScrollReveal(
                      direction: RevealDirection.up,
                      delayMs: 140,
                      child: col2,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEntry({
    required String when,
    required String what,
    required String where,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          when,
          style: AppTypography.body(
            fontSize: 13.5,
            color: AppColors.muted,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          what,
          style: AppTypography.body(
            fontSize: 16.5,
            fontWeight: FontWeight.w500,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          where,
          style: AppTypography.body(
            fontSize: 14.5,
            color: AppColors.muted,
          ),
        ),
      ],
    );
  }
}
