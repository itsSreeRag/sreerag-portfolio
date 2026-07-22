import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Left section of Contact form: Headline text and Submit button
class ContactHeadlineSection extends StatelessWidget {
  final bool isMobile;
  final bool isSubmitting;
  final VoidCallback onSubmit;

  const ContactHeadlineSection({
    super.key,
    required this.isMobile,
    required this.isSubmitting,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Have a project?\nLet\'s talk!',
          style: TextStyle(
            color: Colors.white,
            fontSize: isMobile ? 36 : 48,
            fontWeight: FontWeight.w700,
            height: 1.15,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 36),

        // Solid Coral Red Submit Button
        SizedBox(
          height: 48,
          child: ElevatedButton(
            onPressed: isSubmitting ? null : onSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.dotAccent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 36,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              elevation: 0,
            ),
            child: isSubmitting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
