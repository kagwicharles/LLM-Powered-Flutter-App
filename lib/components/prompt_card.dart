import 'package:flutter/material.dart';

class PromptCard extends StatelessWidget {
  final void Function(String text) onSubmit;

  const PromptCard({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Container(
      padding: const EdgeInsets.all(12),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: (value) {
                if (value.trim().isEmpty) return;
                onSubmit(value);
                controller.clear();
              },
              decoration: const InputDecoration(
                hintText: 'Type a prompt…',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          FilledButton(
            onPressed: () {
              if (controller.text.trim().isEmpty) return;
              onSubmit(controller.text);
              controller.clear();
            },
            child: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
