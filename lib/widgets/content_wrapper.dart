import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ContentWrapper extends StatelessWidget {
  final Widget child;
  final double? verticalPadding;

  const ContentWrapper({
    super.key,
    required this.child,
    this.verticalPadding,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= AppDimensions.mobileBreakpoint;
    final hPadding = isMobile
        ? AppDimensions.mobileHorizontalPadding
        : AppDimensions.desktopHorizontalPadding;

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: AppDimensions.maxContentWidth),
        padding: EdgeInsets.symmetric(
          horizontal: hPadding,
          vertical: verticalPadding ?? 0,
        ),
        child: child,
      ),
    );
  }
}
