import 'package:flutter/material.dart';
import '../viewmodels/about_viewmodel.dart';
import 'timeline_beam_painter.dart';
import 'timeline_item_widget.dart';

class AboutTimelineServices extends StatelessWidget {
  final bool isMobile;
  final double beamProgress;
  final double beamOpacity;
  final List<bool> itemActivated;
  final List<AboutServiceItem> services;

  const AboutTimelineServices({
    super.key,
    required this.isMobile,
    required this.beamProgress,
    required this.beamOpacity,
    required this.itemActivated,
    required this.services,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Custom Painter for Beam of Light traveling down vertical timeline
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          width: 20,
          child: CustomPaint(
            painter: TimelineBeamPainter(
              progress: beamProgress,
              beamOpacity: beamOpacity,
            ),
          ),
        ),

        // Timeline Items
        Column(
          children: List.generate(services.length, (index) {
            final s = services[index];
            return TimelineItemWidget(
              icon: s.icon,
              title: s.title,
              subtitle: s.subtitle,
              isActivated: itemActivated[index],
            );
          }),
        ),
      ],
    );
  }
}
