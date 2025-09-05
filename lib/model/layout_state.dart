import 'dart:ui';

import 'background_spec.dart';
import 'textfield_data.dart';

class LayoutState {
  final String title;
  final BackgroundSpec background;
  final bool showProfile;
  final bool largeCard;
  final String profileName;
  final String profileRole;
  final bool showCounter;
  final int counter;
  final bool showInfo;
  final String infoText;
  final List<TextFieldData>? textFields;
  final Color? textFieldColor;
  final bool showSubmitButton;

  LayoutState({
    this.title = 'Mobile UI Playground',
    this.background = const BackgroundSpec(
      type: 'gradient',
      values: ['#0ea5e9', '#22c55e'],
    ),
    this.showProfile = true,
    this.largeCard = false,
    this.profileName = 'Charles Kagwi',
    this.profileRole = 'Flutter Developer',
    this.showCounter = true,
    this.counter = 0,
    this.showInfo = true,
    this.infoText = 'Type a prompt below, e.g.\n"change background to blue"',
    this.textFields,
    this.textFieldColor,
    this.showSubmitButton = false,
  });

  LayoutState copyWith({
    String? title,
    BackgroundSpec? background,
    bool? showProfile,
    bool? largeCard,
    String? profileName,
    String? profileRole,
    bool? showCounter,
    int? counter,
    bool? showInfo,
    String? infoText,
    List<TextFieldData>? textFields,
    Color? textFieldColor,
    bool? showSubmitButton,
  }) {
    return LayoutState(
      title: title ?? this.title,
      background: background ?? this.background,
      showProfile: showProfile ?? this.showProfile,
      largeCard: largeCard ?? this.largeCard,
      profileName: profileName ?? this.profileName,
      profileRole: profileRole ?? this.profileRole,
      showCounter: showCounter ?? this.showCounter,
      counter: counter ?? this.counter,
      showInfo: showInfo ?? this.showInfo,
      infoText: infoText ?? this.infoText,
      textFields: textFields ?? this.textFields,
      textFieldColor: textFieldColor ?? this.textFieldColor,
      showSubmitButton: showSubmitButton ?? this.showSubmitButton,
    );
  }
}
