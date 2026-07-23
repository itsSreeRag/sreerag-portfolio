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
      title: 'Cross-Platform Development',
      subtitle: 'Android • iOS • Web • Windows',
    ),
    AboutServiceItem(
      icon: Icons.layers_rounded,
      title: 'Scalable Architecture',
      subtitle: 'MVVM • Provider • Modular Code',
    ),
    AboutServiceItem(
      icon: Icons.storage_rounded,
      title: 'Backend & Data',
      subtitle: 'Firebase • REST APIs • SQLite • Hive',
    ),
    AboutServiceItem(
      icon: Icons.design_services_rounded,
      title: 'Modern UI/UX',
      subtitle: 'Responsive • Animations • Clean Design',
    ),
  ];

  final List<AboutStatItem> stats = const [
    AboutStatItem(countValue: 1, symbol: '+', label: 'Years of\nexperience'),
    AboutStatItem(countValue: 10, symbol: '+', label: 'Completed\nProjects'),
    // AboutStatItem(countValue: 100, symbol: '%', label: 'Client\nsatisfaction'),
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
