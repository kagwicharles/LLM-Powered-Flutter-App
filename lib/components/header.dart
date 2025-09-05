import 'package:flutter/material.dart';
import 'package:llmapp/extensions.dart';

class HeaderBar extends StatelessWidget {
  final String title;
  final VoidCallback onReset;

  const HeaderBar({required this.title, required this.onReset});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title.capitalize(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          IconButton(
            onPressed: onReset,
            icon: const Row(children: [Icon(Icons.refresh), Text('Reset')]),
          ),
        ],
      ),
    );
  }
}
