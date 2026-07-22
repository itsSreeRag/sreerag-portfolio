import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Hero profile visual: red glowing ring behind a background-removed cutout
/// photo, flanked by decorative chevrons and an ambient radial glow.
///
/// The ring sits BEHIND the photo (not clipping it) so the cutout can
/// naturally overflow above and below the ring edge, matching the
/// reference design exactly.
class HeroProfileAvatar extends StatefulWidget {
  final bool isMobile;

  const HeroProfileAvatar({super.key, this.isMobile = false});

  @override
  State<HeroProfileAvatar> createState() => _HeroProfileAvatarState();
}

class _HeroProfileAvatarState extends State<HeroProfileAvatar> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage('assets/profile/proflie.png'), context);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = widget.isMobile;
    final double ringSize = isMobile ? 240 : 340;
    final double stackWidth = isMobile ? 320 : 440;
    final double stackHeight = isMobile ? 340 : 440;
    final double photoHeight = isMobile ? 280 : 390;
    final double photoWidth = isMobile ? 320 : 440;
    final double chevronSize = isMobile ? 36 : 50;
    final double ringBorderWidth = isMobile ? 8 : 12;

    final double ringTop = (stackHeight - ringSize) / 2;
    final double photoTop = ringTop - (photoHeight - ringSize) * 0.45;

    return SizedBox(
      width: stackWidth,
      height: stackHeight,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Ambient radial glow behind everything
          Container(
            width: ringSize + 100,
            height: ringSize + 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.dotAccent.withValues(alpha: 0.25),
                  AppColors.dotAccent.withValues(alpha: 0.08),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // Top-Left decorative chevron (<)
          Positioned(
            top: isMobile ? 20 : 30,
            left: isMobile ? 5 : 10,
            child: _Chevron(isLeft: true, size: chevronSize),
          ),

          // Bottom-Right decorative chevron (>)
          Positioned(
            bottom: isMobile ? 20 : 30,
            right: isMobile ? 5 : 10,
            child: _Chevron(isLeft: false, size: chevronSize),
          ),

          // Red glowing ring outline (drawn behind the photo)
          Container(
            width: ringSize,
            height: ringSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.dotAccent,
                width: ringBorderWidth,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.dotAccent.withValues(alpha: 0.55),
                  blurRadius: 36,
                  spreadRadius: 3,
                ),
              ],
            ),
          ),

          // Cutout photo — centered over the ring so head reaches top edge & torso fills ring
          Positioned(
            top: photoTop,
            width: photoWidth,
            height: photoHeight,
            child: Image.asset(
              'assets/profile/proflie.png',
              fit: BoxFit.fitHeight,
              alignment: Alignment.center,
              gaplessPlayback: true,
              filterQuality: FilterQuality.medium,
              isAntiAlias: true,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.person_rounded,
                size: isMobile ? 120 : 160,
                color: AppColors.dotAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Chevron extends StatelessWidget {
  final bool isLeft;
  final double size;

  const _Chevron({required this.isLeft, required this.size});

  @override
  Widget build(BuildContext context) {
    return Icon(
      isLeft ? Icons.chevron_left_rounded : Icons.chevron_right_rounded,
      size: size,
      color: AppColors.dotAccent.withValues(alpha: 0.5),
    );
  }
}




