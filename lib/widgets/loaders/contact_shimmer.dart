import 'package:flutter/material.dart';
import '../cards/glass_card.dart';
import 'app_shimmer.dart';

class ContactShimmer extends StatelessWidget {
  const ContactShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppShimmer(width: 140, height: 24),
          SizedBox(height: 20),
          AppShimmer(width: double.infinity, height: 48),
          SizedBox(height: 16),
          AppShimmer(width: double.infinity, height: 48),
          SizedBox(height: 16),
          AppShimmer(width: double.infinity, height: 120),
          SizedBox(height: 20),
          AppShimmer(width: 140, height: 44),
        ],
      ),
    );
  }
}
