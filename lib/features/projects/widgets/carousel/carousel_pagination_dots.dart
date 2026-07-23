import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class CarouselPaginationDots extends StatelessWidget {
  final int totalImages;
  final int currentIndex;
  final ValueChanged<int> onSelectPage;

  const CarouselPaginationDots({
    super.key,
    required this.totalImages,
    required this.currentIndex,
    required this.onSelectPage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(totalImages, (index) {
          final isActive = index == currentIndex;
          return GestureDetector(
            onTap: () => onSelectPage(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: isActive ? 22 : 8,
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: isActive
                    ? AppColors.dotAccent
                    : Colors.white.withValues(alpha: 0.35),
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: AppColors.dotAccent.withValues(alpha: 0.6),
                          blurRadius: 6,
                          spreadRadius: 1,
                        ),
                      ]
                    : [],
              ),
            ),
          );
        }),
      ),
    );
  }
}
