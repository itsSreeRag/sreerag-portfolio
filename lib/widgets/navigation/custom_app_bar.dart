import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/responsive/responsive_breakpoints.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import 'nav_item.dart';

class CustomAppBar extends StatelessWidget {
  final List<String> navItems;
  final int activeIndex;
  final Function(String) onItemSelected;
  final VoidCallback onOpenDrawer;

  const CustomAppBar({
    super.key,
    required this.navItems,
    required this.activeIndex,
    required this.onItemSelected,
    required this.onOpenDrawer,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.isDesktop(context);

    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.85),
        border: Border(
          bottom: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
        ),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1300),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Brand Logo / Name (exact reference style)
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onItemSelected('Home'),
                  child: Text(
                    AppConstants.appBarName,
                    style: AppTypography.titleLarge(
                      color: Colors.white,
                    ).copyWith(fontWeight: FontWeight.w700, letterSpacing: 0.2),
                  ),
                ),
              ),

              // Nav links right (Home, About, Projects, Experience, Contact)
              if (isDesktop)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(navItems.length, (index) {
                    final item = navItems[index];
                    return NavItem(
                      title: item,
                      isActive: activeIndex == index,
                      onTap: () => onItemSelected(item),
                    );
                  }),
                )
              else
                IconButton(
                  icon: const Icon(Icons.menu_rounded, color: Colors.white),
                  onPressed: onOpenDrawer,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
