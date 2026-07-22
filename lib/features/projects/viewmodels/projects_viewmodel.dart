import 'package:flutter/material.dart';
import '../../../models/project_model.dart';
import '../../../repositories/portfolio_repository.dart';

class ProjectsViewModel extends ChangeNotifier {
  final PortfolioRepository _repository;

  ProjectsViewModel({required PortfolioRepository repository})
      : _repository = repository {
    loadProjects();
  }

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<ProjectModel> _projects = [];
  List<ProjectModel> get projects => _projects;

  ProjectModel? _selectedProject;
  ProjectModel? get selectedProject => _selectedProject;

  Future<void> loadProjects() async {
    _isLoading = true;
    notifyListeners();
    _projects = await _repository.fetchProjects();
    _isLoading = false;
    notifyListeners();
  }

  void selectProject(ProjectModel? project) {
    _selectedProject = project;
    notifyListeners();
  }
}
