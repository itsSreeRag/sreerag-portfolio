import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class ScrollProgressIndicator extends StatelessWidget {
  final double progress; // 0.0 to 1.0

  const ScrollProgressIndicator({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 3,
      color: Colors.transparent,
      alignment: Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: progress.clamp(0.0, 1.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.dotAccent,
            boxShadow: const [
              BoxShadow(
                color: AppColors.dotAccentGlow,
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
