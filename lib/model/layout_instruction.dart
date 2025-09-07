import 'package:llmapp/model/background_spec.dart';
import 'package:llmapp/model/component_instruction.dart';

class LayoutInstruction {
  final String? title;
  final BackgroundSpec? background;
  final List<ComponentInstruction> components;
  final bool reset;

  LayoutInstruction({
    this.title,
    this.background,
    this.components = const [],
    this.reset = false,
  });

  factory LayoutInstruction.fromJson(Map<String, dynamic> json) {
    return LayoutInstruction(
      title: json['title'] as String?,
      background: json['background'] != null
          ? BackgroundSpec.fromJson(json['background'])
          : null,
      components: (json['components'] as List<dynamic>? ?? [])
          .map((e) => ComponentInstruction.fromJson(e as Map<String, dynamic>))
          .toList(),
      reset: json['reset'] == true,
    );
  }
}
