import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class CarouselPlaceholderTile extends StatelessWidget {
  const CarouselPlaceholderTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF141C28),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.code_rounded,
            size: 48,
            color: AppColors.dotAccent,
          ),
          SizedBox(height: 12),
          Text(
            'Project Preview',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
