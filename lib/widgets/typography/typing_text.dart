import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class TypingText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration charDuration;

  const TypingText({
    super.key,
    required this.text,
    required this.style,
    this.charDuration = const Duration(milliseconds: 60),
  });

  @override
  State<TypingText> createState() => _TypingTextState();
}

class _TypingTextState extends State<TypingText> {
  String _displayedText = '';
  Timer? _timer;
  int _charIndex = 0;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  @override
  void didUpdateWidget(covariant TypingText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _startTyping();
    }
  }

  void _startTyping() {
    _timer?.cancel();
    _displayedText = '';
    _charIndex = 0;

    _timer = Timer.periodic(widget.charDuration, (timer) {
      if (!mounted) {
        _timer?.cancel();
        return;
      }
      if (_charIndex < widget.text.length) {
        setState(() {
          _displayedText += widget.text[_charIndex];
          _charIndex++;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(_displayedText, style: widget.style),
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: 2,
          height: (widget.style.fontSize ?? 20) * 1.2,
          margin: const EdgeInsets.only(left: 4),
          color: AppColors.primaryLight,
        ),
      ],
    );
  }
}
