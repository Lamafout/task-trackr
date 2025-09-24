import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';

class LoggerHeader extends StatefulWidget {
  const LoggerHeader({required this.child, super.key});

  final Widget child;

  @override
  State<StatefulWidget> createState() => _LoggerHeaderState(child);
}

class _LoggerHeaderState extends State<LoggerHeader> {
  _LoggerHeaderState(this.child,);

  final Widget child;
  late int countOfTaps;

  void onTap() {
    if (countOfTaps < 10) {
      countOfTaps++;
      return;
    }
    countOfTaps = 0;
    Navigator.push(context, MaterialPageRoute(builder: (context) => TalkerScreen(talker: context.read<Talker>())));
  }

  @override
  void initState() {
    countOfTaps = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: child,
    );
  }
}