import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'custom_widget.dart';
import 'drawing_bloc.dart';
import 'states/drawing_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<DrawingBloc>(
            create: (_) => DrawingBloc(DrawingState(DrawingStates.drawing)),
          ),
        ],
        child: const AppHomePage(title: 'Flutter ECG Demo'),
      ),
    );
  }
}

class AppHomePage extends StatelessWidget {
  const AppHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 12)),
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white), // Icon widget
        onPressed: () {
          // Add your onPressed logic here
        },
      ),
      backgroundColor: Colors.deepPurple,
    );

    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: appBar,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 16.0),
              CustomWidget(
                width: 320,
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

