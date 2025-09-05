import 'background_spec.dart';

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
    );
  }
}