class ExperienceModel {
  final String role;
  final String company;
  final String duration;
  final String location;
  final List<String> responsibilities;
  final List<String> technologies;

  const ExperienceModel({
    required this.role,
    required this.company,
    required this.duration,
    required this.location,
    required this.responsibilities,
    required this.technologies,
  });
}
