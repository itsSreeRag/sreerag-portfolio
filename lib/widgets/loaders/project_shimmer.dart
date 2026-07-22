import 'package:flutter/material.dart';
import '../../core/theme/app_radius.dart';

import '../cards/glass_card.dart';
import 'app_shimmer.dart';

class ProjectShimmer extends StatelessWidget {
  const ProjectShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppShimmer(width: double.infinity, height: 200, borderRadius: AppRadius.borderMd),
          SizedBox(height: 16),
          AppShimmer(width: 140, height: 24),
          SizedBox(height: 10),
          AppShimmer(width: double.infinity, height: 16),
          SizedBox(height: 6),
          AppShimmer(width: 220, height: 16),
          SizedBox(height: 16),
          Row(
            children: [
              AppShimmer(width: 70, height: 24),
              SizedBox(width: 8),
              AppShimmer(width: 80, height: 24),
              SizedBox(width: 8),
              AppShimmer(width: 60, height: 24),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              AppShimmer(width: 100, height: 38),
              SizedBox(width: 12),
              AppShimmer(width: 100, height: 38),
            ],
          ),
        ],
      ),
    );
  }
}
