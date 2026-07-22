import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/services/url_launcher_service.dart';

class HomeViewModel extends ChangeNotifier {
  int _currentRoleIndex = 0;
  Timer? _timer;

  int get currentRoleIndex => _currentRoleIndex;
  String get currentRole => AppConstants.typingRoles[_currentRoleIndex];

  HomeViewModel() {
    _startRoleRotation();
  }

  void _startRoleRotation() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      _currentRoleIndex = (_currentRoleIndex + 1) % AppConstants.typingRoles.length;
      notifyListeners();
    });
  }

  /// Launches the resume link
  void openResume() {
    UrlLauncherService.openUrl(AppConstants.resumeUrl);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
