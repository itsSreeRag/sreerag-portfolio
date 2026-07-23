import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'carousel_placeholder_tile.dart';

class CarouselImageTile extends StatelessWidget {
  final String imagePath;

  const CarouselImageTile({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final isNetwork = imagePath.startsWith('http');

    if (isNetwork) {
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        gaplessPlayback: true,
        filterQuality: FilterQuality.medium,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: const Color(0xFF141C28),
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.dotAccent.withValues(alpha: 0.6),
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) =>
            const CarouselPlaceholderTile(),
      );
    } else {
      return Image.asset(
        imagePath,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        gaplessPlayback: true,
        filterQuality: FilterQuality.medium,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('Error loading asset image "$imagePath": $error');
          return const CarouselPlaceholderTile();
        },
      );
    }
  }
}
