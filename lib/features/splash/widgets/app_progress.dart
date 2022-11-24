import 'package:financial_app/design_sys/colors.dart';
import 'package:flutter/material.dart';

class AppProgress extends StatefulWidget {
  const AppProgress({super.key});

  @override
  State<AppProgress> createState() => _AppProgressState();
}

class _AppProgressState extends State<AppProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      duration: const Duration(seconds: 1),
      turns: _controller.value,
      child: Transform.scale(
        scale: 3.6,
        child: CircularProgressIndicator(
          valueColor: const AlwaysStoppedAnimation(AppColors.white),
          strokeWidth: 0.5,
          value: _controller.value,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
