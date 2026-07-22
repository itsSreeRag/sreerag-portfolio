import 'package:flutter/material.dart';
import '../../../models/experience_model.dart';
import '../../../widgets/loaders/timeline_shimmer.dart';
import 'experience_timeline_item.dart';

class ExperienceTimelineList extends StatelessWidget {
  final bool isLoading;
  final List<ExperienceModel> experiences;
  final bool isMobile;

  const ExperienceTimelineList({
    super.key,
    required this.isLoading,
    required this.experiences,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const TimelineShimmer();
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: experiences.length,
      itemBuilder: (context, index) {
        return ExperienceTimelineItem(
          experience: experiences[index],
          isMobile: isMobile,
        );
      },
    );
  }
}
