class TextFieldData {
  final String label;
  final String value;

  TextFieldData({required this.label, this.value = ""});

  TextFieldData copyWith({String? label, String? value}) {
    return TextFieldData(
      label: label ?? this.label,
      value: value ?? this.value,
    );
  }
}