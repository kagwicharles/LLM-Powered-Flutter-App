class BackgroundSpec {
  final String type; // 'color' | 'gradient'
  final List<String> values;

  const BackgroundSpec({required this.type, required this.values});

  factory BackgroundSpec.fromJson(dynamic json) {
    if (json is String) {
      return BackgroundSpec(type: 'color', values: [json]);
    }
    final map = json as Map<String, dynamic>;
    return BackgroundSpec(
      type: map['type'] as String? ?? 'color',
      values: (map['values'] as List<dynamic>? ?? []).map((e) => '$e').toList(),
    );
  }
}