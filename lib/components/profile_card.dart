import 'package:flutter/material.dart';
import 'package:llmapp/extensions.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String role;
  final bool large;

  const ProfileCard({
    super.key,
    required this.name,
    required this.role,
    this.large = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(large ? 20 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(radius: large ? 30 : 24, child: Text(name[0])),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name.capitalize(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(role.capitalize()),
            ],
          ),
        ],
      ),
    );
  }
}
