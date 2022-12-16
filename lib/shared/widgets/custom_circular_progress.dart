import 'package:flutter/material.dart';

class CustomCircularProgress extends StatefulWidget {
  const CustomCircularProgress({super.key});

  @override
  State<CustomCircularProgress> createState() => _CustomCircularProgressState();
}

class _CustomCircularProgressState extends State<CustomCircularProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
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
        scale: 2.5,
        child: CircularProgressIndicator(
          strokeWidth: 1,
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
