import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';

class AboutServiceItem {
  final IconData icon;
  final String title;
  final String subtitle;

  const AboutServiceItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}

class AboutStatItem {
  final int countValue;
  final String symbol;
  final String label;

  const AboutStatItem({
    required this.countValue,
    this.symbol = '+',
    required this.label,
  });
}

class AboutViewModel extends ChangeNotifier {
  final String bio = AppConstants.bioFull;

  final List<AboutServiceItem> services = const [
    AboutServiceItem(
      icon: Icons.flutter_dash_rounded,
      title: 'Flutter Development',
      subtitle: 'Cross-platform iOS, Android, and Desktop apps',
    ),
    AboutServiceItem(
      icon: Icons.phone_iphone_rounded,
      title: 'Mobile Applications',
      subtitle: 'Native feel with pixel-perfect UI & state management',
    ),
    AboutServiceItem(
      icon: Icons.desktop_windows_outlined,
      title: 'Windows Desktop Systems',
      subtitle: 'High-performance desktop apps & local storage',
    ),
    AboutServiceItem(
      icon: Icons.api_rounded,
      title: 'REST API & Firebase',
      subtitle: 'Cloud syncing, auth, and real-time backend services',
    ),
  ];

  final List<AboutStatItem> stats = const [
    AboutStatItem(
      countValue: 3,
      symbol: '+',
      label: 'Years of\nexperience',
    ),
    AboutStatItem(
      countValue: 10,
      symbol: '+',
      label: 'Completed\nProjects',
    ),
    AboutStatItem(
      countValue: 100,
      symbol: '%',
      label: 'Client\nsatisfaction',
    ),
  ];

  bool _isHovered = false;
  bool get isHovered => _isHovered;

  void setHovered(bool hovered) {
    if (_isHovered != hovered) {
      _isHovered = hovered;
      notifyListeners();
    }
  }
}
