import 'dart:convert';

import 'model/layout_instruction.dart';

class PromptParser {
  static final Map<String, String> _mappings = {
    'change background to blue': jsonEncode({
      'background': {
        'type': 'color',
        'values': ['blue'],
      },
      'components': [
        {
          'type': 'info',
          'props': {'text': 'Background set to BLUE'},
        },
      ],
    }),
    'update title to hello world': jsonEncode({'title': 'Hello World'}),
    'show profile card': jsonEncode({
      'components': [
        {
          'type': 'profile_card',
          'props': {'name': 'Charles', 'role': 'Mobile Engineer'},
        },
      ],
    }),
    'add textfield email': jsonEncode({
      'components': [
        {
          'type': 'textfield',
          'props': {'label': 'Email'},
        },
      ],
    }),
    'add textfield username': jsonEncode({
      'components': [
        {
          'type': 'textfield',
          'props': {'label': 'Username'},
        },
      ],
    }),
    'add textfield password': jsonEncode({
      'components': [
        {
          'type': 'textfield',
          'props': {'label': 'Password'},
        },
      ],
    }),
    'add submit button': jsonEncode({
      'components': [
        {
          'type': 'button',
          'props': {'label': 'Submit'},
        },
      ],
    }),
    'reset': jsonEncode({'reset': true}),
  };

  static LayoutInstruction? tryParse(String input) {
    final normalized = _normalize(input);
    final payload = _mappings[normalized];
    if (payload == null) return null;
    final map = jsonDecode(payload) as Map<String, dynamic>;
    return LayoutInstruction.fromJson(map);
  }

  static String _normalize(String s) {
    return s.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
  }
}
