import 'package:flutter/material.dart';

class TimerButton extends StatefulWidget {
  final Function() onTap;
  bool? isRunning;
  TimerButton({super.key, required this.onTap, this.isRunning});

  @override
  State<TimerButton> createState() => _TimerButtonState();
}

class _TimerButtonState extends State<TimerButton> {
  bool _isRunning = false;

  void _onTap() {
    widget.onTap();
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  @override
  Widget build(BuildContext context) {
    _isRunning = widget.isRunning ?? _isRunning;
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