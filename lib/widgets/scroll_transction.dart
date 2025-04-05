import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ScrollingText extends StatefulWidget {
  @override
  _ScrollingTextState createState() => _ScrollingTextState();
}

class _ScrollingTextState extends State<ScrollingText>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Offset>? _animation;

  @override
  void initState() {
    super.initState();

    // AnimationController setup
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 9), // Animation duration
    )..repeat(); // Repeat animation indefinitely

    // Animation setup
    _animation = Tween<Offset>(
      begin: const Offset(1.0, 0.0), // Start from right (1.0 means fully right)
      end: const Offset(-1.0, 0.0), // Move to left (-1.0 means fully left)
    ).animate(_controller!);
  }

  @override
  void dispose() {
    _controller!.dispose(); // Dispose controller to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation!,
      child: const Center(
        child: AutoSizeText(
          'JODI RATE 10 ka 890, HARUF RATE 100 KA 890',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          maxLines: 1,
          minFontSize: 10,
        ),
      ),
    );
  }
}
