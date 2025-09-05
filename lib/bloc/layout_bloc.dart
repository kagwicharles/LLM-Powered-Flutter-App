import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/layout_instruction.dart';
import '../model/layout_state.dart';
import '../model/textfield_data.dart';

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
      debugPrint(
        'Applying component: ${ins.components.length} ${c.type} ${c.props}>>>>>>',
      );
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
        case 'textfield':
          var label = c.props['label'] as String? ?? 'Input';
          TextFieldData textFieldData = TextFieldData(label: label);
          newState = newState.copyWith(
            textFields: [...?newState.textFields, textFieldData],
          );
          break;
        case 'button':
          newState = newState.copyWith(showSubmitButton: true,);
          break;
      }
    }
    emit(newState);
  }
}
