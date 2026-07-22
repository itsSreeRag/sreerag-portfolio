enum SkillCategory {
  languages('Languages'),
  framework('Framework'),
  stateManagement('State Management'),
  backend('Backend'),
  database('Database'),
  tools('Tools');

  final String label;
  const SkillCategory(this.label);
}

class SkillModel {
  final String name;
  final SkillCategory category;
  final dynamic icon;
  final double level; // 0.0 to 1.0
  final String description;

  const SkillModel({
    required this.name,
    required this.category,
    required this.icon,
    required this.level,
    required this.description,
  });
}
