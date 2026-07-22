import 'package:flutter/material.dart';
import '../cards/glass_card.dart';
import 'app_shimmer.dart';

class TimelineShimmer extends StatelessWidget {
  const TimelineShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppShimmer(width: 180, height: 24),
              AppShimmer(width: 90, height: 20),
            ],
          ),
          SizedBox(height: 8),
          AppShimmer(width: 120, height: 16),
          SizedBox(height: 16),
          AppShimmer(width: double.infinity, height: 14),
          SizedBox(height: 6),
          AppShimmer(width: double.infinity, height: 14),
          SizedBox(height: 6),
          AppShimmer(width: 250, height: 14),
        ],
      ),
    );
  }
}
