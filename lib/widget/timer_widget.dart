import 'dart:async';
import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Duration remaining = const Duration(hours: 1, minutes: 20, seconds: 47);

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        remaining -= const Duration(seconds: 1);
      });
      if (remaining.inSeconds <= 0) timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _timeBox(twoDigits(remaining.inHours)),
        const SizedBox(width: 4),
        const Text(":", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 4),
        _timeBox(twoDigits(remaining.inMinutes % 60)),
        const SizedBox(width: 4),
        const Text(":", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 4),
        _timeBox(twoDigits(remaining.inSeconds % 60)),
      ],
    );
  }

  Widget _timeBox(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
