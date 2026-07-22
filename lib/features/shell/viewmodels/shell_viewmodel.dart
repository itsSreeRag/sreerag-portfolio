import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ShellViewModel extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();

  final Map<String, GlobalKey> sectionKeys = {
    'Home': GlobalKey(),
    'About': GlobalKey(),
    'Projects': GlobalKey(),
    'Experience': GlobalKey(),
    'Contact': GlobalKey(),
  };

  int _activeNavIndex = 0;
  int get activeNavIndex => _activeNavIndex;

  double _scrollProgress = 0.0;
  double get scrollProgress => _scrollProgress;

  bool _showBackToTop = false;
  bool get showBackToTop => _showBackToTop;

  ShellViewModel() {
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;

    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    bool shouldNotify = false;

    // Scroll progress (0.0 to 1.0)
    if (maxScroll > 0) {
      final newProgress = (currentScroll / maxScroll).clamp(0.0, 1.0);
      if ((newProgress - _scrollProgress).abs() > 0.015) {
        _scrollProgress = newProgress;
        shouldNotify = true;
      }
    }

    // Show Back To Top after 300px
    final shouldShow = currentScroll > 300;
    if (_showBackToTop != shouldShow) {
      _showBackToTop = shouldShow;
      shouldNotify = true;
    }

    // Determine active section by key positions
    final newActiveIndex = _calculateActiveSectionIndex();
    if (_activeNavIndex != newActiveIndex) {
      _activeNavIndex = newActiveIndex;
      shouldNotify = true;
    }

    if (shouldNotify) {
      notifyListeners();
    }
  }

  int _calculateActiveSectionIndex() {
    int index = 0;
    final navKeysList = sectionKeys.entries.toList();

    for (int i = 0; i < navKeysList.length; i++) {
      final key = navKeysList[i].value;
      final context = key.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          final position = box.localToGlobal(Offset.zero);
          if (position.dy <= 220) {
            index = i;
          }
        }
      }
    }
    return index;
  }

  void scrollToSection(String title) {
    final key = sectionKeys[title];
    if (key != null && key.currentContext != null) {
      final context = key.currentContext!;
      final renderObject = context.findRenderObject();
      if (renderObject != null && scrollController.hasClients) {
        final viewport = RenderAbstractViewport.of(renderObject);
        final offsetToReveal = viewport.getOffsetToReveal(renderObject, 0.0);

        final double targetOffset = (offsetToReveal.offset - 90.0).clamp(
          0.0,
          scrollController.position.maxScrollExtent,
        );

        scrollController.animateTo(
          targetOffset,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOutCubic,
        );
      }
    }
  }

  void scrollToTop() {
    if (!scrollController.hasClients) return;
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
  }
}
