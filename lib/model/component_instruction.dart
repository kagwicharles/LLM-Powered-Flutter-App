class ComponentInstruction {
  final String type;
  final Map<String, dynamic> props;

  ComponentInstruction({required this.type, this.props = const {}});

  factory ComponentInstruction.fromJson(Map<String, dynamic> json) {
    return ComponentInstruction(
      type: json['type'] as String,
      props: (json['props'] as Map<String, dynamic>? ?? {}),
    );
  }
}