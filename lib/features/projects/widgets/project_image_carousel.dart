import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_colors.dart';
import 'carousel/carousel_image_tile.dart';
import 'carousel/carousel_nav_button.dart';
import 'carousel/carousel_pagination_dots.dart';

/// Reusable responsive image carousel for project screenshots.
/// Supports infinite looping, smooth slide animations, drag/swipe gestures,
/// hover pause/zoom, keyboard arrow navigation, and custom animated pagination.
class ProjectImageCarousel extends StatefulWidget {
  final List<String> images;
  final bool isMobile;
  final double? height;

  const ProjectImageCarousel({
    super.key,
    required this.images,
    this.isMobile = false,
    this.height,
  });

  @override
  State<ProjectImageCarousel> createState() => _ProjectImageCarouselState();
}

class _ProjectImageCarouselState extends State<ProjectImageCarousel> {
  late final PageController _pageController;
  Timer? _autoplayTimer;
  bool _isHovered = false;
  int _currentIndex = 0;
  final FocusNode _focusNode = FocusNode();

  static const int _virtualPageOffset = 5000;

  bool get _hasMultipleImages => widget.images.length > 1;

  @override
  void initState() {
    super.initState();
    final initialPage = _hasMultipleImages
        ? _virtualPageOffset * widget.images.length
        : 0;
    _pageController = PageController(initialPage: initialPage);

    if (_hasMultipleImages) {
      _startAutoplay();
    }
  }

  void _startAutoplay() {
    _stopAutoplay();
    if (!_hasMultipleImages) return;

    _autoplayTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted || _isHovered || !_hasMultipleImages) return;
      if (_pageController.hasClients) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  void _stopAutoplay() {
    _autoplayTimer?.cancel();
    _autoplayTimer = null;
  }

  void _onHoverChanged(bool isHovered) {
    if (_isHovered == isHovered) return;
    setState(() {
      _isHovered = isHovered;
    });

    if (isHovered) {
      _stopAutoplay();
    } else {
      _startAutoplay();
    }
  }

  void _goToPrevious() {
    if (!_hasMultipleImages || !_pageController.hasClients) return;
    _pageController.previousPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
  }

  void _goToNext() {
    if (!_hasMultipleImages || !_pageController.hasClients) return;
    _pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
  }

  void _goToPage(int index) {
    if (!_hasMultipleImages || !_pageController.hasClients) return;
    final currentVirtualPage = _pageController.page?.round() ?? 0;
    final currentRealIndex = currentVirtualPage % widget.images.length;
    final difference = index - currentRealIndex;
    final targetPage = currentVirtualPage + difference;

    _pageController.animateToPage(
      targetPage,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOutCubic,
    );
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (!_hasMultipleImages) return KeyEventResult.ignored;

    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        _goToPrevious();
        return KeyEventResult.handled;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        _goToNext();
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  @override
  void dispose() {
    _stopAutoplay();
    _pageController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = widget.isMobile;
    final double carouselHeight = widget.height ?? (isMobile ? 240 : 320);
    final totalImages = widget.images.length;

    if (totalImages == 0) {
      return Container(
        height: carouselHeight,
        decoration: BoxDecoration(
          color: const Color(0xFF141C28),
          borderRadius: BorderRadius.circular(12),
        ),
      );
    }

    return Focus(
      focusNode: _focusNode,
      onKeyEvent: _handleKeyEvent,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => _onHoverChanged(true),
        onExit: (_) => _onHoverChanged(false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          height: carouselHeight,
          decoration: BoxDecoration(
            color: const Color(0xFF141C28),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered
                  ? AppColors.dotAccent.withValues(alpha: 0.5)
                  : Colors.white.withValues(alpha: 0.1),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? AppColors.dotAccent.withValues(alpha: 0.2)
                    : Colors.black.withValues(alpha: 0.3),
                blurRadius: 20,
                spreadRadius: 1,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(11),
            child: AnimatedScale(
              scale: _isHovered ? 1.03 : 1.0,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              child: Stack(
                children: [
                  // PageView Slider supporting Touch & Desktop Mouse Drag
                  ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                      dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                        PointerDeviceKind.trackpad,
                      },
                    ),
                    child: PageView.builder(
                      controller: _pageController,
                      physics: _hasMultipleImages
                          ? const BouncingScrollPhysics()
                          : const NeverScrollableScrollPhysics(),
                      itemCount: _hasMultipleImages ? null : 1,
                      onPageChanged: (page) {
                        setState(() {
                          _currentIndex = page % totalImages;
                        });
                      },
                      itemBuilder: (context, virtualIndex) {
                        final realIndex = virtualIndex % totalImages;
                        final imagePath = widget.images[realIndex];

                        return Semantics(
                          label:
                              'Project screenshot ${realIndex + 1} of $totalImages',
                          container: true,
                          child: CarouselImageTile(imagePath: imagePath),
                        );
                      },
                    ),
                  ),

                  // Left Navigation Arrow Button
                  if (_hasMultipleImages)
                    Positioned(
                      left: 12,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: isMobile ? 0.7 : (_isHovered ? 1.0 : 0.0),
                          child: IgnorePointer(
                            ignoring: !isMobile && !_isHovered,
                            child: CarouselNavButton(
                              icon: Icons.chevron_left_rounded,
                              onPressed: _goToPrevious,
                              tooltip: 'Previous Image',
                            ),
                          ),
                        ),
                      ),
                    ),

                  // Right Navigation Arrow Button
                  if (_hasMultipleImages)
                    Positioned(
                      right: 12,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: isMobile ? 0.7 : (_isHovered ? 1.0 : 0.0),
                          child: IgnorePointer(
                            ignoring: !isMobile && !_isHovered,
                            child: CarouselNavButton(
                              icon: Icons.chevron_right_rounded,
                              onPressed: _goToNext,
                              tooltip: 'Next Image',
                            ),
                          ),
                        ),
                      ),
                    ),

                  // Animated Pagination Dots at the Bottom
                  if (_hasMultipleImages)
                    Positioned(
                      bottom: 12,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: CarouselPaginationDots(
                          totalImages: totalImages,
                          currentIndex: _currentIndex,
                          onSelectPage: _goToPage,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
