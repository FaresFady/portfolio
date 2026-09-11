import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// A lively, pulsing online status dot that radiates glowing radar waves
/// to indicate active live availability (like Discord/GitHub active beacons).
class PulsingStatusDot extends StatefulWidget {
  final Color color;
  final double size;

  const PulsingStatusDot({
    super.key,
    this.color = AppColors.success,
    this.size = 9.0,
  });

  @override
  State<PulsingStatusDot> createState() => _PulsingStatusDotState();
}

class _PulsingStatusDotState extends State<PulsingStatusDot> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    final curved = CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeOutCubic,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 2.6).animate(curved);
    _opacityAnimation = Tween<double>(begin: 0.85, end: 0.0).animate(curved);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final prefersReducedMotion = MediaQuery.of(context).disableAnimations;
      if (!prefersReducedMotion) {
        _pulseController.repeat();
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final boundingSize = widget.size * 2.2;

    return SizedBox(
      width: boundingSize,
      height: boundingSize,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Expanding & Fading Radar Pulse Wave
            AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: widget.size,
                      height: widget.size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.color.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                );
              },
            ),

            // Inner Solid Glowing Dot
            Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color: widget.color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withValues(alpha: 0.9),
                    blurRadius: 7,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
