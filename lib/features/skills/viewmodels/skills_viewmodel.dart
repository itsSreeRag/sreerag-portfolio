import 'package:flutter/material.dart';
import '../../../models/skill_model.dart';
import '../../../repositories/portfolio_repository.dart';

class SkillsViewModel extends ChangeNotifier {
  final PortfolioRepository _repository;

  SkillsViewModel({required PortfolioRepository repository})
      : _repository = repository {
    loadSkills();
  }

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<SkillModel> _allSkills = [];
  SkillCategory? _selectedCategory;

  SkillCategory? get selectedCategory => _selectedCategory;

  List<SkillModel> get filteredSkills {
    if (_selectedCategory == null) {
      return _allSkills;
    }
    return _allSkills.where((s) => s.category == _selectedCategory).toList();
  }

  Future<void> loadSkills() async {
    _isLoading = true;
    notifyListeners();
    _allSkills = await _repository.fetchSkills();
    _isLoading = false;
    notifyListeners();
  }

  void selectCategory(SkillCategory? category) {
    if (_selectedCategory != category) {
      _selectedCategory = category;
      notifyListeners();
    }
  }
}
