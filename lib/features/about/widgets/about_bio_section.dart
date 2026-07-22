import 'package:flutter/material.dart';
import '../viewmodels/about_viewmodel.dart';
import 'stat_card.dart';

class AboutBioSection extends StatelessWidget {
  final bool isMobile;
  final double headingOpacity;
  final double headingOffsetY;
  final double bioOpacity;
  final double bioOffsetY;
  final double statCountProgress;
  final double symbolScaleProgress;
  final double statLabelOpacity;
  final double statLabelOffsetY;
  final String bioText;
  final List<AboutStatItem> stats;

  const AboutBioSection({
    super.key,
    required this.isMobile,
    required this.headingOpacity,
    required this.headingOffsetY,
    required this.bioOpacity,
    required this.bioOffsetY,
    required this.statCountProgress,
    required this.symbolScaleProgress,
    required this.statLabelOpacity,
    required this.statLabelOffsetY,
    required this.bioText,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Heading "About me" with slide up (20px -> 0) & fade in over 500ms
        Transform.translate(
          offset: Offset(0, headingOffsetY),
          child: Opacity(
            opacity: headingOpacity,
            child: Text(
              'About me',
              style: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? 36 : 44,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Paragraph Bio with slide up (15px -> 0) & fade in (200ms delay)
        Transform.translate(
          offset: Offset(0, bioOffsetY),
          child: Opacity(
            opacity: bioOpacity,
            child: Text(
              bioText,
              style: const TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 15.5,
                height: 1.6,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),

        // Stats Counters Row
        Wrap(
          spacing: isMobile ? 24 : 40,
          runSpacing: 20,
          children: stats.map((stat) {
            return StatCard(
              countValue: stat.countValue,
              symbol: stat.symbol,
              label: stat.label,
              countProgress: statCountProgress,
              symbolScale: symbolScaleProgress,
              labelOpacity: statLabelOpacity,
              labelOffsetY: statLabelOffsetY,
            );
          }).toList(),
        ),
      ],
    );
  }
}
