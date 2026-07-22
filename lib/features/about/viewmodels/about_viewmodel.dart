import 'package:flutter/material.dart';

class AboutViewModel extends ChangeNotifier {
  final int yearsExperience = 2;
  final int projectsCompleted = 10;
  final int repositoriesContributed = 25;
  final int linesOfCodeWritten = 50000;

  bool _isHovered = false;
  bool get isHovered => _isHovered;

  void setHovered(bool hovered) {
    if (_isHovered != hovered) {
      _isHovered = hovered;
      notifyListeners();
    }
  }
}
