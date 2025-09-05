import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'model/layout_instruction.dart';

class GemmaPromptParser {
  static String _buildStructuredPrompt(String userInput) {
    return '''
              You are a UI layout interpreter. Convert natural language UI commands into JSON.
              
              Available components:
                - profile_card: {
                    "type": "profile_card",
                    "props": {
                      "name": "string",
                      "role": "string"
                    }
                  }
                - textfield: {
                    "type": "textfield",
                    "props": {
                      "label": "string"
                    }
                  }
                - button: {
                    "type": "button",
                    "props": {
                      "label": "string"
                    }
                  }
              
              Available actions:
                - Change background:
                    {
                      "background": {
                        "type": "color",
                        "values": ["color_name"]
                      }
                    }
                - Update title:
                    {
                      "title": "new_title"
                    }
                - Add components:
                    {
                      "components": [component_objects]
                    }
                - Reset:
                    {
                      "reset": true
                    }
              
              Examples:
                Input: "change background to red"
                Output: {
                  "background": {
                    "type": "color",
                    "values": ["red"]
                  }
                }
              
                Input: "add email input field"
                Output: {
                  "components": [
                    {
                      "type": "textfield",
                      "props": {
                        "label": "Email"
                      }
                    }
                  ]
                }
              
                Input: "show profile for John as Developer"
                Output: {
                  "components": [
                    {
                      "type": "profile_card",
                      "props": {
                        "name": "John",
                        "role": "Developer"
                      }
                    }
                  ]
                }
              
              User command: "$userInput"
              
              Output only valid JSON, no explanation:
              ''';
  }

  static LayoutInstruction? _parseModelResponse(String response) {
    try {
      String cleanedResponse = response.trim();

      final jsonRegex = RegExp(r'```(?:json)?\s*(\{.*\})\s*```', dotAll: true);
      final match = jsonRegex.firstMatch(cleanedResponse);
      if (match != null) {
        cleanedResponse = match.group(1)!;
      }

      final jsonObjectRegex = RegExp(r'\{[^}]*\}');
      final jsonMatch = jsonObjectRegex.firstMatch(cleanedResponse);
      if (jsonMatch != null) {
        cleanedResponse = jsonMatch.group(0)!;
      }

      final jsonData = jsonDecode(cleanedResponse) as Map<String, dynamic>;
      return LayoutInstruction.fromJson(jsonData);
    } catch (e) {
      debugPrint('Error parsing model response: $e>>>>>>>>>>>>>');
      debugPrint('Raw response: $response>>>>>>>>>>>>>>');
      return null;
    }
  }
}
