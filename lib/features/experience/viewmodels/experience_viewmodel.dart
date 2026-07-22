import 'package:flutter/material.dart';
import '../../../models/experience_model.dart';
import '../../../repositories/portfolio_repository.dart';

class ExperienceViewModel extends ChangeNotifier {
  final PortfolioRepository _repository;

  ExperienceViewModel({required PortfolioRepository repository})
      : _repository = repository {
    loadExperience();
  }

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<ExperienceModel> _experiences = [];
  List<ExperienceModel> get experiences => _experiences;

  Future<void> loadExperience() async {
    _isLoading = true;
    notifyListeners();
    _experiences = await _repository.fetchExperience();
    _isLoading = false;
    notifyListeners();
  }
}
