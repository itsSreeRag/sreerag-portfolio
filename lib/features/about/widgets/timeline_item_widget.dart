import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class TimelineItemWidget extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isActivated;

  const TimelineItemWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isActivated,
  });

  @override
  State<TimelineItemWidget> createState() => _TimelineItemWidgetState();
}

class _TimelineItemWidgetState extends State<TimelineItemWidget>
    with TickerProviderStateMixin {
  late final AnimationController _activateController;
  late final Animation<double> _dotScale;
  late final Animation<double> _rippleScale;
  late final Animation<double> _rippleOpacity;
  late final Animation<double> _cardSlideX;
  late final Animation<double> _cardOpacity;
  late final Animation<double> _cardScale;
  late final Animation<double> _textOffsetY;
  late final Animation<double> _textOpacity;

  bool _hasTriggered = false;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _activateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    // Dot scale 0.8 -> 1.25 -> 1.0 (0..350ms)
    _dotScale = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween<double>(begin: 0.8, end: 1.25), weight: 50),
      TweenSequenceItem(
          tween: Tween<double>(begin: 1.25, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(
      parent: _activateController,
      curve: const Interval(0.0, 0.55, curve: Curves.easeOutCubic),
    ));

    // Ripple pulse expanding 1.0 -> 2.0 (0..450ms)
    _rippleScale = Tween<double>(begin: 1.0, end: 2.0).animate(CurvedAnimation(
      parent: _activateController,
      curve: const Interval(0.0, 0.70, curve: Curves.easeOut),
    ));
    _rippleOpacity = Tween<double>(begin: 0.8, end: 0.0).animate(CurvedAnimation(
      parent: _activateController,
      curve: const Interval(0.0, 0.70, curve: Curves.easeOut),
    ));

    // Icon card slide X -30 -> 0, opacity 0 -> 1, scale 0.95 -> 1.0 (100..450ms)
    _cardSlideX = Tween<double>(begin: -30.0, end: 0.0).animate(CurvedAnimation(
      parent: _activateController,
      curve: const Interval(0.15, 0.70, curve: Curves.easeOutCubic),
    ));
    _cardOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _activateController,
      curve: const Interval(0.15, 0.70, curve: Curves.easeOut),
    ));
    _cardScale = Tween<double>(begin: 0.95, end: 1.0).animate(CurvedAnimation(
      parent: _activateController,
      curve: const Interval(0.15, 0.70, curve: Curves.easeOutCubic),
    ));

    // Text fade & slide 10px -> 0 (250..550ms)
    _textOffsetY = Tween<double>(begin: 10.0, end: 0.0).animate(CurvedAnimation(
      parent: _activateController,
      curve: const Interval(0.35, 0.85, curve: Curves.easeOut),
    ));
    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _activateController,
      curve: const Interval(0.35, 0.85, curve: Curves.easeOut),
    ));

    if (widget.isActivated) {
      _trigger();
    }
  }

  @override
  void didUpdateWidget(covariant TimelineItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActivated && !_hasTriggered) {
      _trigger();
    }
  }

  void _trigger() {
    _hasTriggered = true;
    _activateController.forward();
  }

  @override
  void dispose() {
    _activateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _activateController,
      builder: (context, child) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            height: 90,
            transform: _isHovered
                ? Matrix4.translationValues(0.0, -4.0, 0.0)
                : Matrix4.identity(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Timeline Dot with ripple pulse & glow
                SizedBox(
                  width: 20,
                  height: 90,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (_hasTriggered && _rippleOpacity.value > 0.01)
                        Transform.scale(
                          scale: _rippleScale.value,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.dotAccent.withValues(
                                  alpha: _rippleOpacity.value,
                                ),
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      Transform.scale(
                        scale: _hasTriggered ? _dotScale.value : 0.8,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _hasTriggered
                                ? AppColors.dotAccent
                                : Colors.white.withValues(alpha: 0.2),
                            boxShadow: _hasTriggered
                                ? [
                                    BoxShadow(
                                      color: AppColors.dotAccent
                                          .withValues(alpha: 0.7),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    ),
                                  ]
                                : [],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),

                // Card Container (Icon + Text) with slide, scale, fade & hover
                Expanded(
                  child: Transform.translate(
                    offset: Offset(_cardSlideX.value, 0),
                    child: Opacity(
                      opacity: _cardOpacity.value,
                      child: Transform.scale(
                        scale: _cardScale.value,
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: _isHovered
                                ? Colors.white.withValues(alpha: 0.05)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: _isHovered
                                  ? AppColors.dotAccent.withValues(alpha: 0.35)
                                  : Colors.transparent,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              // Icon Box
                              Container(
                                width: 46,
                                height: 46,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.03),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: _hasTriggered
                                        ? AppColors.dotAccent
                                            .withValues(alpha: 0.3)
                                        : Colors.white.withValues(alpha: 0.08),
                                    width: 1,
                                  ),
                                ),
                                child: Icon(
                                  widget.icon,
                                  size: 24,
                                  color: _hasTriggered
                                      ? Colors.white
                                      : Colors.white38,
                                ),
                              ),
                              const SizedBox(width: 18),

                              // Title & Subtitle with 10px upward slide & fade
                              Expanded(
                                child: Transform.translate(
                                  offset: Offset(0, _textOffsetY.value),
                                  child: Opacity(
                                    opacity: _textOpacity.value,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.title,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.5,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.2,
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          widget.subtitle,
                                          style: const TextStyle(
                                            color: Color(0xFF94A3B8),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
