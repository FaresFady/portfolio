import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

Future<void> openUrl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

Future<void> downloadCv() async {
  // On web, opening the relative path directly downloads/opens the PDF
  await openUrl('Fares_Elhabashy_CV.pdf');
}

class PrimaryButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final IconData? icon;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onTap,
    this.icon,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, _isHovered ? -2 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.accentSoft : AppColors.accent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.35),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, size: 16, color: AppColors.primaryBtnText),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Text(
                  widget.text,
                  style: AppTypography.body(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryBtnText,
                    height: 1.2,
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

class GhostButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final IconData? icon;

  const GhostButton({
    super.key,
    required this.text,
    required this.onTap,
    this.icon,
  });

  @override
  State<GhostButton> createState() => _GhostButtonState();
}

class _GhostButtonState extends State<GhostButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, _isHovered ? -2 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.panel : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _isHovered ? AppColors.accent : AppColors.line,
              width: 1.2,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, size: 16, color: _isHovered ? AppColors.accent : AppColors.text),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Text(
                  widget.text,
                  style: AppTypography.body(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w500,
                    color: _isHovered ? AppColors.accent : AppColors.text,
                    height: 1.2,
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

class SocialIconButton extends StatefulWidget {
  final Widget Function(Color color)? iconBuilder;
  final IconData? icon;
  final String tooltip;
  final VoidCallback onTap;
  final Color? activeColor;

  const SocialIconButton({
    super.key,
    this.iconBuilder,
    this.icon,
    required this.tooltip,
    required this.onTap,
    this.activeColor,
  });

  @override
  State<SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<SocialIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.activeColor ?? AppColors.accent;
    final itemColor = _isHovered ? color : AppColors.muted;

    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            transform: Matrix4.translationValues(0, _isHovered ? -3 : 0, 0),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _isHovered ? color.withValues(alpha: 0.15) : AppColors.panel,
              shape: BoxShape.circle,
              border: Border.all(
                color: _isHovered ? color : AppColors.line,
                width: 1.2,
              ),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: color.withValues(alpha: 0.3),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ]
                  : [],
            ),
            child: SizedBox(
              width: 18,
              height: 18,
              child: Center(
                child: widget.iconBuilder != null
                    ? widget.iconBuilder!(itemColor)
                    : Icon(
                        widget.icon,
                        size: 18,
                        color: itemColor,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UnderlineLink extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final Color? normalColor;
  final Color? hoverColor;
  final Color? normalBorderColor;
  final Color? hoverBorderColor;
  final double fontSize;
  final TextStyle? customStyle;

  const UnderlineLink({
    super.key,
    required this.text,
    required this.onTap,
    this.normalColor,
    this.hoverColor,
    this.normalBorderColor,
    this.hoverBorderColor,
    this.fontSize = 15.0,
    this.customStyle,
  });

  @override
  State<UnderlineLink> createState() => _UnderlineLinkState();
}

class _UnderlineLinkState extends State<UnderlineLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final textCol = _isHovered
        ? (widget.hoverColor ?? AppColors.text)
        : (widget.normalColor ?? AppColors.muted);

    final borderCol = _isHovered
        ? (widget.hoverBorderColor ?? AppColors.accent)
        : (widget.normalBorderColor ?? Colors.transparent);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: const EdgeInsets.only(bottom: 2),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: borderCol,
                width: 1,
              ),
            ),
          ),
          child: Text(
            widget.text,
            style: (widget.customStyle ?? AppTypography.body(fontSize: widget.fontSize))
                .copyWith(color: textCol),
          ),
        ),
      ),
    );
  }
}
