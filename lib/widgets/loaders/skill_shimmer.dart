import 'package:flutter/material.dart';
import '../cards/glass_card.dart';
import 'app_shimmer.dart';

class SkillShimmer extends StatelessWidget {
  const SkillShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const GlassCard(
      padding: EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              AppShimmer(width: 32, height: 32),
              SizedBox(width: 10),
              AppShimmer(width: 90, height: 18),
            ],
          ),
          SizedBox(height: 8),
          AppShimmer(width: double.infinity, height: 10),
          SizedBox(height: 10),
          AppShimmer(width: double.infinity, height: 6),
        ],
      ),
    );
  }
}
