class ProjectModel {
  final String id;
  final String title;
  final String shortDescription;
  final String detailedDescription;
  final List<String> images;
  final String platformTag;
  final List<String> technologies;
  final List<String> features;
  final String? githubUrl;
  final String? liveDemoUrl;
  final String? caseStudyUrl;

  /// Backward compatibility getter returning the primary image
  String get imageUrl => images.isNotEmpty ? images.first : '';

  const ProjectModel({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.detailedDescription,
    required this.images,
    required this.platformTag,
    required this.technologies,
    required this.features,
    this.githubUrl,
    this.liveDemoUrl,
    this.caseStudyUrl,
  });
}
