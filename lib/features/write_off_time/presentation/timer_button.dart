import 'dart:async';

import 'package:flutter/material.dart';

class TimerButton extends StatefulWidget {
  final Function(int) onTimeChanged; // функция нужна для обработки значения таймера
  const TimerButton({super.key, required this.onTimeChanged});

  @override
  State<TimerButton> createState() => _TimerButtonState();
}

class _TimerButtonState extends State<TimerButton> {
  Timer? _timer;
  int _seconds = 0;
  bool _isRunning = false;

  void _onTap() {
    if (_isRunning) {
      _timer?.cancel();
      setState(() {
        _isRunning = false;
      });
    } else {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _seconds++;
        });
      widget.onTimeChanged(_seconds);
      });
      setState(() {
        _isRunning = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      iconSize: 30,
      // TODO replace with Theme
      style: const ButtonStyle(
        backgroundColor: WidgetStatePropertyAll<Color>(Colors.amber),
      ),
      onPressed: _onTap, 
      icon: _isRunning
      ? const Icon(Icons.pause_rounded) 
      : const Icon(Icons.play_arrow_rounded),
    );
  }
}