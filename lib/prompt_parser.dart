import 'dart:convert';

import 'package:llmapp/model/layout_instruction.dart';

class PromptParser {
  static final Map<String, String> _mappings = {
    'change background to blue': jsonEncode({
      'background': {
        'type': 'color',
        'values': ['blue'],
      },
    }),
    'update title to hello world': jsonEncode({'title': 'Hello World'}),
    'show profile card': jsonEncode({
      'components': {
        'type': 'profile_card',
        'props': {'name': 'Charles', 'role': "Mobile Developer"},
      },
    }),
    'add textfield email': jsonEncode({
      'components': [
        {
          'type': 'textfield',
          'props': {'label': 'email'},
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
          'pros': {'label': 'Password'},
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
    if (payload == null) {
      return _tryPatternMatching(input);
    }
    final map = jsonDecode(payload) as Map<String, dynamic>;
    return LayoutInstruction.fromJson(map);
  }

  static LayoutInstruction? _tryPatternMatching(String input) {
    final normalized = _normalize(input);

    final bgColorRegex = RegExp(
      r'(?:change|make|set)\s+background\s+(?:to\s+)?(\w+)',
    );
    final bgMatch = bgColorRegex.firstMatch(normalized);
    if (bgMatch != null) {
      final color = bgMatch.group(1)!;
      return LayoutInstruction.fromJson({
        'background': {
          'type': 'color',
          'values': [color],
        },
      });
    }

    final titleRegex = RegExp(
      r'(?:update|change|set)\s+title\s+(?:to\s+)?(.+)',
    );
    final titleMatch = titleRegex.firstMatch(normalized);
    if (titleMatch != null) {
      final title = titleMatch.group(1)!;
      return LayoutInstruction.fromJson({'title': title});
    }

    final profileRegex = RegExp(
      r'(?:show|add)\s+profile\s+(?:card\s+)?(?:for\s+)?(\w+)(?:\s+as\s+(.+))?',
    );
    final profileMatch = profileRegex.firstMatch(normalized);
    if (profileMatch != null) {
      final name = profileMatch.group(1)!;
      final role = profileMatch.group(2) ?? 'User';
      return LayoutInstruction.fromJson({
        'components': [
          {
            'type': 'profile_card',
            'props': {'name': name, 'role': role},
          },
        ],
      });
    }

    final fieldRegex = RegExp(r'(?:add|create)\s+(\w+)\s+(?:field|input)');
    final fieldMatch = fieldRegex.firstMatch(normalized);
    if (fieldMatch != null) {
      final fieldType = fieldMatch.group(1)!;
      return LayoutInstruction.fromJson({
        'components': [
          {
            'type': 'textfield',
            'props': {'label': fieldType.toLowerCase()},
          },
        ],
      });
    }

    final buttonRegex = RegExp(r'(?:add|create)\s+(\w+)\s+button');
    final buttonMatch = buttonRegex.firstMatch(normalized);
    if (buttonMatch != null) {
      final label = buttonMatch.group(1)!;
      return LayoutInstruction.fromJson({
        'components': [
          {
            'type': 'button',
            'props': {'label': label},
          },
        ],
      });
    }
    return null;
  }

  static String _normalize(String s) {
    return s.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
  }
}
