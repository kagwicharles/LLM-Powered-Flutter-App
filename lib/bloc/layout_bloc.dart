import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/layout_instruction.dart';
import '../model/layout_state.dart';

part 'bloc_layout_event.dart';

class LayoutBloc extends Bloc<LayoutEvent, LayoutState> {
  LayoutBloc() : super(LayoutState()) {
    on<ApplyInstruction>(_onApplyInstruction);
    on<ResetLayout>((event, emit) => emit(LayoutState()));
  }

  void _onApplyInstruction(ApplyInstruction event, Emitter<LayoutState> emit) {
    final ins = event.instruction;
    if (ins.reset) {
      emit(LayoutState());
      return;
    }

    var newState = state;
    if (ins.title != null) newState = newState.copyWith(title: ins.title);
    if (ins.background != null) {
      newState = newState.copyWith(background: ins.background);
    }

    for (final c in ins.components) {
      switch (c.type) {
        case 'profile_card':
          newState = newState.copyWith(
            showProfile: true,
            profileName: c.props['name'] as String? ?? newState.profileName,
            profileRole: c.props['role'] as String? ?? newState.profileRole,
            largeCard: c.props['large'] == true ? true : newState.largeCard,
          );
          break;
        case 'info':
          newState = newState.copyWith(
            showInfo: c.props['visible'] != false,
            infoText: c.props['text'] as String? ?? newState.infoText,
          );
          break;
      }
    }
    emit(newState);
  }
}