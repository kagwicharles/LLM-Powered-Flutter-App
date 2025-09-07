import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/layout_instruction.dart';
import '../model/layout_state.dart';
import '../model/textfield_data.dart';

part 'layout_event.dart';

class LayoutBloc extends Bloc<LayoutEvent, LayoutState> {
  LayoutBloc() : super(LayoutState()) {
    on<ApplyInstruction>(_onApplyInstruction);
    on<ResetLayout>((event, emit) => emit(LayoutState()));
  }

  void _onApplyInstruction(ApplyInstruction event, Emitter<LayoutState> emit) {
    final instruction = event.layoutInstruction;
    if (instruction.reset) {
      emit(LayoutState());
    }

    var newState = state;
    if (instruction.title != null) {
      newState = newState.copyWith(title: instruction.title);
    }
    if (instruction.background != null) {
      newState = newState.copyWith(background: instruction.background);
    }

    for (final component in instruction.components) {
      switch (component.type) {
        case 'profile_card':
          newState = newState.copyWith(
            showProfile: true,
            profileName:
                component.props['name'] as String? ?? newState.profileName,
            profileRole:
                component.props['role'] as String? ?? newState.profileRole,
            largeCard: component.props['large'] == true
                ? true
                : newState.largeCard,
          );
          break;
        case 'textfield':
          var label = component.props['label'] as String? ?? 'Input';
          TextFieldData textFieldData = TextFieldData(label: label);
          newState = newState.copyWith(
            textFields: [...?newState.textFields, textFieldData],
          );
          break;
        case 'button':
          newState = newState.copyWith(showSubmitButton: true);
          break;
      }
    }
    emit(newState);
  }
}
