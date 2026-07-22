import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/responsive/responsive_breakpoints.dart';
import '../../../core/theme/app_typography.dart';

class TechnologyStrip extends StatefulWidget {
  const TechnologyStrip({super.key});

  @override
  State<TechnologyStrip> createState() => _TechnologyStripState();
}

class _TechnologyStripState extends State<TechnologyStrip> {
  late final ScrollController _scrollController;
  bool _canScrollLeft = false;
  bool _canScrollRight = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_updateScrollState);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _updateScrollState();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateScrollState);
    _scrollController.dispose();
    super.dispose();
  }

  void _updateScrollState() {
    if (!mounted || !_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;

    final canLeft = currentScroll > 5;
    final canRight = currentScroll < (maxScroll - 5) && maxScroll > 0;

    if (canLeft != _canScrollLeft || canRight != _canScrollRight) {
      if (mounted) {
        setState(() {
          _canScrollLeft = canLeft;
          _canScrollRight = canRight;
        });
      }
    }
  }

  void _scroll(bool isLeft) {
    if (!_scrollController.hasClients) return;
    const double offsetDelta = 220;
    final targetOffset = isLeft
        ? (_scrollController.offset - offsetDelta)
            .clamp(0.0, _scrollController.position.maxScrollExtent)
        : (_scrollController.offset + offsetDelta)
            .clamp(0.0, _scrollController.position.maxScrollExtent);

    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.isMobile(context);
    final isTablet = ResponsiveBreakpoints.isTablet(context);
    final isSmallScreen = isMobile || isTablet;

    final double itemMargin = isMobile ? 16 : (isTablet ? 20 : 26);
    final double fontSize = isMobile ? 14.0 : 15.0;
    final double verticalPadding = isMobile ? 16 : 20;

    final bool showLeft = isSmallScreen && _canScrollLeft;
    final bool showRight = isSmallScreen && _canScrollRight;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF111622),
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.05),
            width: 1,
          ),
          bottom: BorderSide(
            color: Colors.white.withValues(alpha: 0.05),
            width: 1,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Scrollable tech list without scrollbar
          ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              scrollbars: false,
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
                PointerDeviceKind.trackpad,
              },
            ),
            child: NotificationListener<ScrollNotification>(
              onNotification: (_) {
                _updateScrollState();
                return false;
              },
              child: SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? (isMobile ? 44 : 52) : 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: AppConstants.techStrip
                      .map((tech) => _TechTextItem(
                            tech: tech,
                            margin: itemMargin,
                            fontSize: fontSize,
                          ))
                      .toList(),
                ),
              ),
            ),
          ),

          // Left Arrow Button (<) - Mobile/Tablet only
          if (isSmallScreen)
            Positioned(
              left: isMobile ? 6 : 14,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: showLeft ? 1.0 : 0.0,
                child: IgnorePointer(
                  ignoring: !showLeft,
                  child: _NavArrowButton(
                    isLeft: true,
                    onTap: () => _scroll(true),
                  ),
                ),
              ),
            ),

          // Right Arrow Button (>) - Mobile/Tablet only
          if (isSmallScreen)
            Positioned(
              right: isMobile ? 6 : 14,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: showRight ? 1.0 : 0.0,
                child: IgnorePointer(
                  ignoring: !showRight,
                  child: _NavArrowButton(
                    isLeft: false,
                    onTap: () => _scroll(false),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _NavArrowButton extends StatefulWidget {
  final bool isLeft;
  final VoidCallback onTap;

  const _NavArrowButton({
    required this.isLeft,
    required this.onTap,
  });

  @override
  State<_NavArrowButton> createState() => _NavArrowButtonState();
}

class _NavArrowButtonState extends State<_NavArrowButton> {
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
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _isHovered
                ? const Color(0xFFE63946).withValues(alpha: 0.2)
                : const Color(0xFF1B2333),
            border: Border.all(
              color: _isHovered
                  ? const Color(0xFFE63946)
                  : Colors.white.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: Icon(
            widget.isLeft
                ? Icons.chevron_left_rounded
                : Icons.chevron_right_rounded,
            size: 20,
            color: _isHovered ? const Color(0xFFE63946) : Colors.white70,
          ),
        ),
      ),
    );
  }
}

class _TechTextItem extends StatefulWidget {
  final String tech;
  final double margin;
  final double fontSize;

  const _TechTextItem({
    required this.tech,
    required this.margin,
    required this.fontSize,
  });

  @override
  State<_TechTextItem> createState() => _TechTextItemState();
}

class _TechTextItemState extends State<_TechTextItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: EdgeInsets.symmetric(horizontal: widget.margin),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 180),
          style: AppTypography.bodyLarge(
            color: _isHovered ? Colors.white : const Color(0xFF8A99AD),
          ).copyWith(
            fontSize: widget.fontSize,
            fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w500,
            letterSpacing: 0.6,
          ),
          child: Text(widget.tech),
        ),
      ),
    );
  }
}




