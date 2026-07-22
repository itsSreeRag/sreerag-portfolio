// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../core/responsive/responsive_breakpoints.dart';
// import '../../../core/theme/app_colors.dart';
// import '../../../core/theme/app_radius.dart';
// import '../../../core/theme/app_spacing.dart';
// import '../../../core/theme/app_typography.dart';
// import '../../../models/skill_model.dart';
// import '../../../widgets/loaders/skill_shimmer.dart';
// import '../../../widgets/typography/section_header.dart';
// import '../viewmodels/skills_viewmodel.dart';
// import '../widgets/skill_card.dart';

// class SkillsView extends StatelessWidget {
//   const SkillsView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final isMobile = ResponsiveBreakpoints.isMobile(context);
//     final isTablet = ResponsiveBreakpoints.isTablet(context);

//     final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

//     return Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: isMobile ? AppSpacing.md : AppSpacing.xxl,
//         vertical: AppSpacing.xxl,
//       ),
//       child: Consumer<SkillsViewModel>(
//         builder: (context, viewModel, child) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SectionHeader(
//                 badge: 'SKILLS & TECH STACK',
//                 title: 'Technical Arsenal & Expertise',
//                 subtitle: 'Core competencies across language, state management, backend, databases, and tooling.',
//               ),
//               const SizedBox(height: AppSpacing.xl),

//               // Category Filter Tabs
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: [
//                     _buildCategoryChip(
//                       context,
//                       label: 'All Skills',
//                       isSelected: viewModel.selectedCategory == null,
//                       onTap: () => viewModel.selectCategory(null),
//                     ),
//                     ...SkillCategory.values.map(
//                       (cat) => _buildCategoryChip(
//                         context,
//                         label: cat.label,
//                         isSelected: viewModel.selectedCategory == cat,
//                         onTap: () => viewModel.selectCategory(cat),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: AppSpacing.xl),

//               // Skills Grid or Shimmer
//               if (viewModel.isLoading)
//                 GridView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: crossAxisCount,
//                     crossAxisSpacing: AppSpacing.md,
//                     mainAxisSpacing: AppSpacing.md,
//                     mainAxisExtent: 180,
//                   ),
//                   itemCount: 6,
//                   itemBuilder: (context, index) => const SkillShimmer(),
//                 )
//               else
//                 GridView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: crossAxisCount,
//                     crossAxisSpacing: AppSpacing.md,
//                     mainAxisSpacing: AppSpacing.md,
//                     mainAxisExtent: 180,
//                   ),
//                   itemCount: viewModel.filteredSkills.length,
//                   itemBuilder: (context, index) {
//                     final skill = viewModel.filteredSkills[index];
//                     return SkillCard(skill: skill);
//                   },
//                 ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildCategoryChip(
//     BuildContext context, {
//     required String label,
//     required bool isSelected,
//     required VoidCallback onTap,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 10),
//       child: ChoiceChip(
//         label: Text(label),
//         selected: isSelected,
//         onSelected: (_) => onTap(),
//         selectedColor: AppColors.primary,
//         backgroundColor: AppColors.surfaceElevated,
//         labelStyle: AppTypography.labelLarge(
//           color: isSelected ? Colors.white : AppColors.textSecondary,
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: AppRadius.borderRound,
//           side: BorderSide(
//             color: isSelected ? AppColors.primaryLight : AppColors.surfaceBorder,
//           ),
//         ),
//       ),
//     );
//   }
// }
