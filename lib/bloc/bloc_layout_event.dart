part of 'layout_bloc.dart';

abstract class LayoutEvent {}

class ApplyInstruction extends LayoutEvent {
  final LayoutInstruction instruction;

  ApplyInstruction(this.instruction);
}

class ResetLayout extends LayoutEvent {}
