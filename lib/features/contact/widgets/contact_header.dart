import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

/// Section header for Contacts feature: horizontal accent line + Contacts title
class ContactHeader extends StatelessWidget {
  const ContactHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(width: 100, height: 2, color: AppColors.dotAccent),
        const SizedBox(width: 16),
        Text(
          'Contacts',
          style: AppTypography.displayMedium(
            color: Colors.white,
          ).copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
