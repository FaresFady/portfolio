import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/content_wrapper.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= AppDimensions.mobileBreakpoint;

    return Container(
      padding: const EdgeInsets.only(top: 28, bottom: 44),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.line, width: 1),
        ),
      ),
      child: ContentWrapper(
        child: isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildDevQuote(),
                  const SizedBox(height: 14),
                  Text(
                    '© 2026 Fares Elhabashy. Built with Flutter Web.',
                    textAlign: TextAlign.center,
                    style: AppTypography.body(
                      fontSize: 13.5,
                      color: AppColors.muted,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '© 2026 Fares Elhabashy. Built with Flutter Web.',
                    style: AppTypography.body(
                      fontSize: 13.5,
                      color: AppColors.muted,
                    ),
                  ),
                  _buildDevQuote(),
                ],
              ),
      ),
    );
  }

  Widget _buildDevQuote() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.panel,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.line),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.code, size: 16, color: AppColors.accent),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              '“First, solve the problem. Then, write the code.”',
              style: AppTypography.mono(
                fontSize: 12.5,
                color: AppColors.accent,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
