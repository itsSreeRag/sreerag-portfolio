import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/app_constants.dart';
import '../../core/services/url_launcher_service.dart';

class Footer extends StatelessWidget {
  final Function(String) onNavClick;

  const Footer({
    super.key,
    required this.onNavClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF090E17),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 48,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Sreerag',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Designed with love, all right reserved for Sreerag.',
            style: TextStyle(
              color: Color(0xFF94A3B8),
              fontSize: 13.5,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          // Round Social Icons matching reference image
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _CircleIconButton(
                iconWidget: const Icon(
                  Icons.email_rounded,
                  size: 20,
                  color: Colors.white,
                ),
                onTap: () => UrlLauncherService.openEmail(AppConstants.email),
              ),
              const SizedBox(width: 16),
              _CircleIconButton(
                iconWidget: const FaIcon(
                  FontAwesomeIcons.github,
                  size: 18,
                  color: Colors.white,
                ),
                onTap: () => UrlLauncherService.openUrl(AppConstants.githubUrl),
              ),
              const SizedBox(width: 16),
              _CircleIconButton(
                iconWidget: const FaIcon(
                  FontAwesomeIcons.linkedin,
                  size: 18,
                  color: Colors.white,
                ),
                onTap: () => UrlLauncherService.openUrl(AppConstants.linkedinUrl),
              ),
              const SizedBox(width: 16),
              _CircleIconButton(
                iconWidget: const FaIcon(
                  FontAwesomeIcons.whatsapp,
                  size: 18,
                  color: Colors.white,
                ),
                onTap: () => UrlLauncherService.openUrl(AppConstants.whatsappUrl),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final Widget iconWidget;
  final VoidCallback onTap;

  const _CircleIconButton({
    required this.iconWidget,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.06),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.12),
            width: 1,
          ),
        ),
        child: Center(
          child: iconWidget,
        ),
      ),
    );
  }
}



