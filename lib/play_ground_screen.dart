import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:llmapp/hardcoded_prompt_parser.dart';

import 'bloc/layout_bloc.dart';
import 'components/header.dart';
import 'components/profile_card.dart';
import 'components/prompt_card.dart';
import 'constants.dart';
import 'model/background_spec.dart';
import 'model/layout_state.dart';

class PlaygroundScreen extends StatelessWidget {
  const PlaygroundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<LayoutBloc, LayoutState>(
          builder: (context, state) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeInOut,
              decoration: _buildBackground(state.background),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  HeaderBar(
                    title: state.title,
                    onReset: () =>
                        context.read<LayoutBloc>().add(ResetLayout()),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          if (state.showProfile)
                            ProfileCard(
                              name: state.profileName,
                              role: state.profileRole,
                              large: state.largeCard,
                            ),
                          ...?state.textFields?.asMap().entries.map((entry) {
                            final field = entry.value;
                            return Container(
                              margin: EdgeInsets.all(4),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4.0,
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor:
                                        state.textFieldColor ?? Colors.white,
                                    labelText: field.label,
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            );
                          }),
                          SizedBox(height: 24),
                          if (state.showSubmitButton)
                            ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                minimumSize: WidgetStatePropertyAll(
                                  Size(double.infinity, 48),
                                ),
                              ),
                              child: Text('Submit'),
                            ),
                          SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                  PromptCard(
                    onSubmit: (text) {
                      final ins = HardcodedPromptParser.tryParse(text);
                      if (ins != null) {
                        context.read<LayoutBloc>().add(ApplyInstruction(ins));
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  BoxDecoration _buildBackground(BackgroundSpec bg) {
    if (bg.type == 'gradient' && bg.values.length >= 2) {
      return BoxDecoration(
        gradient: LinearGradient(colors: bg.values.map(_parseColor).toList()),
      );
    }
    return BoxDecoration(color: _parseColor(bg.values.first));
  }

  Color _parseColor(String v) {
    final named = namedColors[v];
    if (named != null) return named;
    if (v.startsWith('#')) {
      final hex = v.replaceFirst('#', '');
      final full = hex.length == 6 ? 'ff$hex' : hex;
      final val = int.tryParse(full, radix: 16) ?? 0xff111827;
      return Color(val);
    }
    return Colors.blueGrey.shade900;
  }
}
