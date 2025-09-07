part of 'layout_bloc.dart';

abstract class LayoutEvent {}

class ApplyInstruction extends LayoutEvent {
  final LayoutInstruction layoutInstruction;

  ApplyInstruction(this.layoutInstruction);
}

class ResetLayout extends LayoutEvent {}
