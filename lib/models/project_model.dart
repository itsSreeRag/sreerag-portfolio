class ProjectModel {
  final String id;
  final String title;
  final String shortDescription;
  final String detailedDescription;
  final String imageUrl;
  final String platformTag;
  final List<String> technologies;
  final List<String> features;
  final String? githubUrl;
  final String? liveDemoUrl;
  final String? caseStudyUrl;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.detailedDescription,
    required this.imageUrl,
    required this.platformTag,
    required this.technologies,
    required this.features,
    this.githubUrl,
    this.liveDemoUrl,
    this.caseStudyUrl,
  });
}
