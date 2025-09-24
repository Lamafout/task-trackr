part of 'write_off_bloc.dart';

class WriteOffEvent {}

class WriteOffAndPostComment extends WriteOffEvent {
  final String comment;
  final int time;
  final String task;
  WriteOffAndPostComment({required this.comment, required this.time, required this.task});
}