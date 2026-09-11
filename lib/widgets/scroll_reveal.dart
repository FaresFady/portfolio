import 'package:flutter/material.dart';

enum RevealDirection { up, left, right }

class ScrollReveal extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final int delayMs;
  final RevealDirection direction;
  final double offsetDistance;

  const ScrollReveal({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 650),
    this.delayMs = 0,
    this.direction = RevealDirection.up,
    this.offsetDistance = 36.0,
  });

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _opacityAnim;
  late Animation<Offset> _slideAnim;
  bool _revealed = false;
  ScrollPosition? _scrollPosition;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    // Smooth ease-out cubic curve for natural, elegant slide and fade
    final curved = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    );

    _opacityAnim = Tween<double>(begin: 0.0, end: 1.0).animate(curved);

    Offset startOffset;
    switch (widget.direction) {
      case RevealDirection.up:
        startOffset = Offset(0, widget.offsetDistance);
        break;
      case RevealDirection.left:
        startOffset = Offset(-widget.offsetDistance, 0);
        break;
      case RevealDirection.right:
        startOffset = Offset(widget.offsetDistance, 0);
        break;
    }

    _slideAnim = Tween<Offset>(begin: startOffset, end: Offset.zero).animate(curved);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (MediaQuery.of(context).disableAnimations) {
        _forceReveal();
        return;
      }
      _checkVisibility();
      _relinkScrollPosition();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_revealed) {
      _animController.value = 1.0;
      return;
    }
    _relinkScrollPosition();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _checkVisibility();
    });
  }

  @override
  void didUpdateWidget(ScrollReveal oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_revealed) {
      _animController.value = 1.0;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _checkVisibility();
      });
    }
  }

  bool _checkScheduled = false;

  void _onScrollTick() {
    if (_revealed || _checkScheduled || !mounted) return;
    _checkScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkScheduled = false;
      if (mounted && !_revealed) {
        _checkVisibility();
      }
    });
  }

  void _relinkScrollPosition() {
    if (_revealed || !mounted) return;
    final scrollable = Scrollable.maybeOf(context);
    final newPosition = scrollable?.position;
    if (_scrollPosition != newPosition) {
      _scrollPosition?.removeListener(_onScrollTick);
      _scrollPosition = newPosition;
      _scrollPosition?.addListener(_onScrollTick);
    }
  }

  void _forceReveal() {
    _revealed = true;
    _scrollPosition?.removeListener(_onScrollTick);
    _scrollPosition = null;
    if (mounted) {
      _animController.value = 1.0;
    }
  }

  void _checkVisibility() {
    if (_revealed || !mounted) return;

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final screenHeight = MediaQuery.of(context).size.height;

    // If widget is already above viewport (scrolled past), reveal immediately without animation
    if (position.dy + size.height < 0) {
      _revealed = true;
      _scrollPosition?.removeListener(_onScrollTick);
      _scrollPosition = null;
      _animController.value = 1.0;
      return;
    }

    // Trigger reveal when widget top enters 88% of screen height
    if (position.dy < screenHeight * 0.88) {
      _revealed = true;
      _scrollPosition?.removeListener(_onScrollTick);
      _scrollPosition = null;

      if (widget.delayMs > 0) {
        Future.delayed(Duration(milliseconds: widget.delayMs), () {
          if (mounted) _animController.forward();
        });
      } else {
        _animController.forward();
      }
    }
  }

  @override
  void dispose() {
    _scrollPosition?.removeListener(_onScrollTick);
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_revealed && _animController.isCompleted) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _animController,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnim.value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: _slideAnim.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}


