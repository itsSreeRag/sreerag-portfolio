import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/responsive/responsive_breakpoints.dart';
import '../../../core/theme/app_spacing.dart';
import '../../shell/viewmodels/shell_viewmodel.dart';
import '../viewmodels/about_viewmodel.dart';
import '../widgets/about_bio_section.dart';
import '../widgets/about_timeline_services.dart';

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
                      child: AboutTimelineServices(
                        isMobile: isMobile,
                        beamProgress: _beamProgress.value,
                        beamOpacity: _beamOpacity.value,
                        itemActivated: _itemActivated,
                        services: viewModel.services,
                      ),
                    ),

                    if (isMobile)
                      const SizedBox(height: 48)
                    else
                      const SizedBox(width: 60),

                    // Right Column: Heading, Bio, and Key Stats
                    Expanded(
                      flex: isMobile ? 0 : 7,
                      child: AboutBioSection(
                        isMobile: isMobile,
                        headingOpacity: _headingOpacity.value,
                        headingOffsetY: _headingOffsetY.value,
                        bioOpacity: _bioOpacity.value,
                        bioOffsetY: _bioOffsetY.value,
                        statCountProgress: _statCountProgress.value,
                        symbolScaleProgress: _symbolScaleProgress.value,
                        statLabelOpacity: _statLabelOpacity.value,
                        statLabelOffsetY: _statLabelOffsetY.value,
                        bioText: viewModel.bio,
                        stats: viewModel.stats,
                      ),
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
}
