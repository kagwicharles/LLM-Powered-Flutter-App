import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:llmapp/play_ground_screen.dart';

import 'bloc/layout_bloc.dart';

void main() {
  runApp(const PlaygroundApp());
}

/// Root app with BlocProvider
class PlaygroundApp extends StatelessWidget {
  const PlaygroundApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mobile UI Playground',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light,
      ),
      home: BlocProvider(
        create: (_) => LayoutBloc(),
        child: const PlaygroundScreen(),
      ),
    );
  }
}

