import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/services/url_launcher_service.dart';
import 'contact_info_row.dart';

/// Left column of Contact section: Headline and professional contact info items
class ContactLeftContent extends StatelessWidget {
  final bool isMobile;

  const ContactLeftContent({
    super.key,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Headline
        Text(
          'Have a project?\nLet\'s talk!',
          style: TextStyle(
            color: Colors.white,
            fontSize: isMobile ? 36 : 44,
            fontWeight: FontWeight.w700,
            height: 1.15,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 36),

        // Professional Contact Information Rows
        ContactInfoRow(
          icon: Icons.location_on_outlined,
          label: 'Location',
          value: AppConstants.location,
        ),
        const SizedBox(height: 16),

        ContactInfoRow(
          icon: Icons.email_outlined,
          label: 'Email',
          value: AppConstants.email,
          onTap: () => UrlLauncherService.openEmail(AppConstants.email),
        ),
        const SizedBox(height: 16),

        ContactInfoRow(
          icon: Icons.phone_outlined,
          label: 'Phone',
          value: AppConstants.phone,
          onTap: () => UrlLauncherService.openUrl(
            'tel:${AppConstants.phone.replaceAll(RegExp(r'\s+'), '')}',
          ),
        ),
        const SizedBox(height: 16),

        ContactInfoRow(
          icon: FontAwesomeIcons.linkedinIn,
          label: 'LinkedIn',
          value: AppConstants.linkedinUrl.replaceFirst('https://', ''),
          onTap: () => UrlLauncherService.openUrl(AppConstants.linkedinUrl),
        ),
        const SizedBox(height: 16),

        ContactInfoRow(
          icon: FontAwesomeIcons.github,
          label: 'GitHub',
          value: AppConstants.githubUrl.replaceFirst('https://', ''),
          onTap: () => UrlLauncherService.openUrl(AppConstants.githubUrl),
        ),
      ],
    );
  }
}
