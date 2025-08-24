import 'package:flutter/material.dart';

class PlayingIndicator extends StatefulWidget {
  final bool isPlaying;
  const PlayingIndicator({
    super.key,
    required this.isPlaying,
  });

  @override
  State<PlayingIndicator> createState() => _PlayingIndicatorState();
}

class _PlayingIndicatorState extends State<PlayingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isPlaying) {
      return const Icon(
        Icons.circle,
        size: 12,
        color: Colors.white,
      );
    }

    return SizedBox(
      width: 16,
      height: 12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(3, (index) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.3, end: 1.0).animate(
              CurvedAnimation(
                parent: _controller,
                curve: Interval(index * 0.2, 1.0, curve: Curves.easeInOut),
              ),
            ),
            child: Container(
              width: 2,
              height: 12,
              color: Colors.white,
            ),
          );
        }),
      ),
    );
  }
}
