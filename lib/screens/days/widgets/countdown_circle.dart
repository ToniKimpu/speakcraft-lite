import 'dart:async';
import 'package:flutter/material.dart';

class CountdownController {
  void Function()? _start;
  void Function()? _stop;
  void Function()? _reset;

  void start() => _start?.call();
  void stop() => _stop?.call();
  void reset() => _reset?.call();
}

class CountdownCircle extends StatefulWidget {
  final int start; // starting value
  final CountdownController controller;
  final VoidCallback? onComplete;

  const CountdownCircle({
    super.key,
    this.start = 30,
    required this.controller,
    this.onComplete,
  });

  @override
  State<CountdownCircle> createState() => _CountdownCircleState();
}

class _CountdownCircleState extends State<CountdownCircle> {
  late int _counter;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _counter = widget.start;

    // Bind controller methods
    widget.controller._start = _startCountdown;
    widget.controller._stop = _stopCountdown;
    widget.controller._reset = _resetCountdown;
  }

  void _startCountdown() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter <= 0) {
        timer.cancel();
        if (widget.onComplete != null) widget.onComplete!();
      } else {
        setState(() {
          _counter--;
        });
      }
    });
  }

  void _stopCountdown() {
    _timer?.cancel();
  }

  void _resetCountdown() {
    _timer?.cancel();
    setState(() {
      _counter = widget.start;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: Colors.deepOrangeAccent,
          width: 4,
        ),
      ),
      child: Center(
        child: Text(
          '$_counter',
          style: const TextStyle(
            color: Colors.deepOrangeAccent,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'ArchivoBlack Regular',
          ),
        ),
      ),
    );
  }
}
