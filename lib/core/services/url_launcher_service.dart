import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherService {
  static Future<bool> openUrl(String urlString) async {
    try {
      final Uri uri = Uri.parse(urlString);
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint('Error launching URL ($urlString): $e');
    }
    return false;
  }

  static Future<bool> openEmail(String email, {String subject = ''}) async {
    final String mailto = 'mailto:$email?subject=${Uri.encodeComponent(subject)}';
    return openUrl(mailto);
  }

  static Future<bool> openPhone(String phone) async {
    return openUrl('tel:$phone');
  }
}
