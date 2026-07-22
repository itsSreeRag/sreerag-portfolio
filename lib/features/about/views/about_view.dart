import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/responsive/responsive_breakpoints.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../shell/viewmodels/shell_viewmodel.dart';
import '../viewmodels/about_viewmodel.dart';
import '../widgets/stat_card.dart';

class AboutView extends StatefulWidget {
  const AboutView({super.key});

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView>
    with SingleTickerProviderStateMixin {
  final GlobalKey _sectionKey = GlobalKey();
  ScrollController? _scrollController;

  late final AnimationController _masterController;

  late final Animation<double> _headingOpacity;
  late final Animation<double> _headingOffsetY;

  late final Animation<double> _bioOpacity;
  late final Animation<double> _bioOffsetY;

  late final Animation<double> _beamProgress;
  late final Animation<double> _beamOpacity;

  late final Animation<double> _statCountProgress;
  late final Animation<double> _symbolScaleProgress;
  late final Animation<double> _statLabelOpacity;
  late final Animation<double> _statLabelOffsetY;

  final List<bool> _itemActivated = [false, false, false, false];
  bool _hasStartedSequence = false;

  @override
  void initState() {
    super.initState();
    _masterController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4500),
    );

    // 1. Heading (0..500ms)
    _headingOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.0, 0.111, curve: Curves.easeOut),
      ),
    );
    _headingOffsetY = Tween<double>(begin: 20.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.0, 0.111, curve: Curves.easeOut),
      ),
    );

    // 2. Paragraph Bio (200ms..700ms)
    _bioOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.044, 0.155, curve: Curves.easeOut),
      ),
    );
    _bioOffsetY = Tween<double>(begin: 15.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.044, 0.155, curve: Curves.easeOut),
      ),
    );

    // 3. Beam of Light Traveling Down Timeline (600ms..2800ms)
    _beamProgress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.133, 0.622, curve: Curves.easeInOutCubic),
      ),
    );

    // 4. Beam head fade out (2800ms..3100ms)
    _beamOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.622, 0.688, curve: Curves.easeOut),
      ),
    );

    // 5. Statistics Counters (3000ms..4000ms)
    _statCountProgress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.666, 0.888, curve: Curves.easeOut),
      ),
    );

    // 6. Plus & Percent Symbols Pop (3900ms..4200ms)
    _symbolScaleProgress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.866, 0.933, curve: Curves.easeOutBack),
      ),
    );

    // 7. Stat Labels Fade & Slide Up (4100ms..4400ms)
    _statLabelOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.911, 0.977, curve: Curves.easeOut),
      ),
    );
    _statLabelOffsetY = Tween<double>(begin: 10.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.911, 0.977, curve: Curves.easeOut),
      ),
    );

    _masterController.addListener(_checkTimelineActivation);
  }

  void _checkTimelineActivation() {
    final double beamP = _beamProgress.value;
    final thresholds = [0.08, 0.35, 0.62, 0.88];
    bool updated = false;

    for (int i = 0; i < 4; i++) {
      if (beamP >= thresholds[i] && !_itemActivated[i]) {
        _itemActivated[i] = true;
        updated = true;
      }
    }

    if (updated && mounted) {
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newController =
        Provider.of<ShellViewModel>(context, listen: false).scrollController;
    if (_scrollController != newController) {
      _scrollController?.removeListener(_checkViewportTrigger);
      _scrollController = newController;
      _scrollController?.addListener(_checkViewportTrigger);
      WidgetsBinding.instance.addPostFrameCallback((_) => _checkViewportTrigger());
    }
  }

  void _checkViewportTrigger() {
    if (_hasStartedSequence || !mounted) return;
    final renderBox =
        _sectionKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.attached) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final double top = position.dy;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Trigger when ~30% of section enters viewport (top <= screenHeight * 0.75)
    if (top <= screenHeight * 0.75) {
      _hasStartedSequence = true;
      _masterController.forward();
    }
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_checkViewportTrigger);
    _masterController.removeListener(_checkTimelineActivation);
    _masterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.isMobile(context);

    return NotificationListener<ScrollNotification>(
      onNotification: (_) {
        _checkViewportTrigger();
        return false;
      },
      child: Container(
        key: _sectionKey,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? AppSpacing.lg : AppSpacing.xxl,
          vertical: isMobile ? 48 : 80,
        ),
        child: Consumer<AboutViewModel>(
          builder: (context, viewModel, child) {
            return AnimatedBuilder(
              animation: _masterController,
              builder: (context, child) {
                return Flex(
                  direction: isMobile ? Axis.vertical : Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left Column: Beam of Light Timeline Services
                    Expanded(
                      flex: isMobile ? 0 : 5,
                      child: _buildTimelineServices(isMobile),
                    ),

                    if (isMobile)
                      const SizedBox(height: 48)
                    else
                      const SizedBox(width: 60),

                    // Right Column: Heading, Bio, and Key Stats
                    Expanded(
                      flex: isMobile ? 0 : 7,
                      child: _buildRightContent(isMobile),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildTimelineServices(bool isMobile) {
    final services = [
      {
        'icon': Icons.flutter_dash_rounded,
        'title': 'Flutter Development',
        'subtitle': 'Cross-platform iOS, Android, and Desktop apps',
      },
      {
        'icon': Icons.phone_iphone_rounded,
        'title': 'Mobile Applications',
        'subtitle': 'Native feel with pixel-perfect UI & state management',
      },
      {
        'icon': Icons.desktop_windows_outlined,
        'title': 'Windows Desktop Systems',
        'subtitle': 'High-performance desktop apps & local storage',
      },
      {
        'icon': Icons.api_rounded,
        'title': 'REST API & Firebase',
        'subtitle': 'Cloud syncing, auth, and real-time backend services',
      },
    ];

    return Stack(
      children: [
        // Custom Painter for Beam of Light traveling down vertical timeline
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          width: 20,
          child: CustomPaint(
            painter: _TimelineBeamPainter(
              progress: _beamProgress.value,
              beamOpacity: _beamOpacity.value,
            ),
          ),
        ),

        // 4 Timeline Items
        Column(
          children: List.generate(4, (index) {
            final s = services[index];
            return _TimelineItemWidget(
              icon: s['icon'] as IconData,
              title: s['title'] as String,
              subtitle: s['subtitle'] as String,
              isActivated: _itemActivated[index],
            );
          }),
        ),
      ],
    );
  }

  Widget _buildRightContent(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Heading "About me" with slide up (20px -> 0) & fade in over 500ms
        Transform.translate(
          offset: Offset(0, _headingOffsetY.value),
          child: Opacity(
            opacity: _headingOpacity.value,
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
          offset: Offset(0, _bioOffsetY.value),
          child: Opacity(
            opacity: _bioOpacity.value,
            child: Text(
              AppConstants.bioFull,
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

        // Stats Counters Row (3+ Years, 10+ Projects, 100% Satisfaction)
        Wrap(
          spacing: isMobile ? 24 : 40,
          runSpacing: 20,
          children: [
            StatCard(
              countValue: 3,
              symbol: '+',
              label: 'Years of\nexperience',
              countProgress: _statCountProgress.value,
              symbolScale: _symbolScaleProgress.value,
              labelOpacity: _statLabelOpacity.value,
              labelOffsetY: _statLabelOffsetY.value,
            ),
            StatCard(
              countValue: 10,
              symbol: '+',
              label: 'Completed\nProjects',
              countProgress: _statCountProgress.value,
              symbolScale: _symbolScaleProgress.value,
              labelOpacity: _statLabelOpacity.value,
              labelOffsetY: _statLabelOffsetY.value,
            ),
            StatCard(
              countValue: 100,
              symbol: '%',
              label: 'Client\nsatisfaction',
              countProgress: _statCountProgress.value,
              symbolScale: _symbolScaleProgress.value,
              labelOpacity: _statLabelOpacity.value,
              labelOffsetY: _statLabelOffsetY.value,
            ),
          ],
        ),
      ],
    );
  }
}

class _TimelineBeamPainter extends CustomPainter {
  final double progress;
  final double beamOpacity;

  _TimelineBeamPainter({
    required this.progress,
    required this.beamOpacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;
    final Offset start = Offset(width / 2, 40);
    final Offset end = Offset(width / 2, height - 40);
    final double totalLen = height - 80;

    // 1. Inactive background track (faint dark red)
    final Paint inactivePaint = Paint()
      ..color = AppColors.dotAccent.withValues(alpha: 0.15)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    canvas.drawLine(start, end, inactivePaint);

    if (progress <= 0) return;

    final double activeLen = totalLen * progress;
    final Offset activeEnd = Offset(width / 2, 40 + activeLen);

    // 2. Bright illuminated line behind the beam
    final Paint activePaint = Paint()
      ..color = AppColors.dotAccent
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;
    canvas.drawLine(start, activeEnd, activePaint);

    // 3. Subtle glow along illuminated line
    final Paint lineGlowPaint = Paint()
      ..color = AppColors.dotAccent.withValues(alpha: 0.4)
      ..strokeWidth = 6.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4)
      ..style = PaintingStyle.stroke;
    canvas.drawLine(start, activeEnd, lineGlowPaint);

    // 4. Traveling Beam Head (energy core + bloom + outer glow)
    if (beamOpacity > 0.01 && activeLen > 0 && activeLen <= totalLen) {
      final Paint bloomPaint = Paint()
        ..color = const Color(0xFFE63946).withValues(alpha: 0.7 * beamOpacity)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
      canvas.drawCircle(activeEnd, 8.0, bloomPaint);

      final Paint corePaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.95 * beamOpacity);
      canvas.drawCircle(activeEnd, 3.5, corePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _TimelineBeamPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.beamOpacity != beamOpacity;
  }
}

class _TimelineItemWidget extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isActivated;

  const _TimelineItemWidget({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isActivated,
  });

  @override
  State<_TimelineItemWidget> createState() => _TimelineItemWidgetState();
}

class _TimelineItemWidgetState extends State<_TimelineItemWidget>
    with TickerProviderStateMixin {
  late final AnimationController _activateController;
  late final Animation<double> _dotScale;
  late final Animation<double> _rippleScale;
  late final Animation<double> _rippleOpacity;
  late final Animation<double> _cardSlideX;
  late final Animation<double> _cardOpacity;
  late final Animation<double> _cardScale;
  late final Animation<double> _textOffsetY;
  late final Animation<double> _textOpacity;

  bool _hasTriggered = false;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _activateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    // Dot scale 0.8 -> 1.25 -> 1.0 (0..350ms)
    _dotScale = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween<double>(begin: 0.8, end: 1.25), weight: 50),
      TweenSequenceItem(
          tween: Tween<double>(begin: 1.25, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(
      parent: _activateController,
      curve: const Interval(0.0, 0.55, curve: Curves.easeOutCubic),
    ));

    // Ripple pulse expanding 1.0 -> 2.0 (0..450ms)
    _rippleScale = Tween<double>(begin: 1.0, end: 2.0).animate(CurvedAnimation(
      parent: _activateController,
      curve: const Interval(0.0, 0.70, curve: Curves.easeOut),
    ));
    _rippleOpacity = Tween<double>(begin: 0.8, end: 0.0).animate(CurvedAnimation(
      parent: _activateController,
      curve: const Interval(0.0, 0.70, curve: Curves.easeOut),
    ));

    // Icon card slide X -30 -> 0, opacity 0 -> 1, scale 0.95 -> 1.0 (100..450ms)
    _cardSlideX = Tween<double>(begin: -30.0, end: 0.0).animate(CurvedAnimation(
      parent: _activateController,
      curve: const Interval(0.15, 0.70, curve: Curves.easeOutCubic),
    ));
    _cardOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _activateController,
      curve: const Interval(0.15, 0.70, curve: Curves.easeOut),
    ));
    _cardScale = Tween<double>(begin: 0.95, end: 1.0).animate(CurvedAnimation(
      parent: _activateController,
      curve: const Interval(0.15, 0.70, curve: Curves.easeOutCubic),
    ));

    // Text fade & slide 10px -> 0 (250..550ms)
    _textOffsetY = Tween<double>(begin: 10.0, end: 0.0).animate(CurvedAnimation(
      parent: _activateController,
      curve: const Interval(0.35, 0.85, curve: Curves.easeOut),
    ));
    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _activateController,
      curve: const Interval(0.35, 0.85, curve: Curves.easeOut),
    ));

    if (widget.isActivated) {
      _trigger();
    }
  }

  @override
  void didUpdateWidget(covariant _TimelineItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActivated && !_hasTriggered) {
      _trigger();
    }
  }

  void _trigger() {
    _hasTriggered = true;
    _activateController.forward();
  }

  @override
  void dispose() {
    _activateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _activateController,
      builder: (context, child) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            height: 90,
            transform: _isHovered
                ? Matrix4.translationValues(0.0, -4.0, 0.0)
                : Matrix4.identity(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Timeline Dot with ripple pulse & glow
                SizedBox(
                  width: 20,
                  height: 90,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (_hasTriggered && _rippleOpacity.value > 0.01)
                        Transform.scale(
                          scale: _rippleScale.value,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.dotAccent.withValues(
                                  alpha: _rippleOpacity.value,
                                ),
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      Transform.scale(
                        scale: _hasTriggered ? _dotScale.value : 0.8,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _hasTriggered
                                ? AppColors.dotAccent
                                : Colors.white.withValues(alpha: 0.2),
                            boxShadow: _hasTriggered
                                ? [
                                    BoxShadow(
                                      color: AppColors.dotAccent
                                          .withValues(alpha: 0.7),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    ),
                                  ]
                                : [],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),

                // Card Container (Icon + Text) with slide, scale, fade & hover
                Expanded(
                  child: Transform.translate(
                    offset: Offset(_cardSlideX.value, 0),
                    child: Opacity(
                      opacity: _cardOpacity.value,
                      child: Transform.scale(
                        scale: _cardScale.value,
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: _isHovered
                                ? Colors.white.withValues(alpha: 0.05)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: _isHovered
                                  ? AppColors.dotAccent.withValues(alpha: 0.35)
                                  : Colors.transparent,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              // Icon Box
                              Container(
                                width: 46,
                                height: 46,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.03),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: _hasTriggered
                                        ? AppColors.dotAccent
                                            .withValues(alpha: 0.3)
                                        : Colors.white.withValues(alpha: 0.08),
                                    width: 1,
                                  ),
                                ),
                                child: Icon(
                                  widget.icon,
                                  size: 24,
                                  color: _hasTriggered
                                      ? Colors.white
                                      : Colors.white38,
                                ),
                              ),
                              const SizedBox(width: 18),

                              // Title & Subtitle with 10px upward slide & fade
                              Expanded(
                                child: Transform.translate(
                                  offset: Offset(0, _textOffsetY.value),
                                  child: Opacity(
                                    opacity: _textOpacity.value,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.title,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.5,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.2,
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          widget.subtitle,
                                          style: const TextStyle(
                                            color: Color(0xFF94A3B8),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}





