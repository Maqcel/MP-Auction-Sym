import 'package:auction_sym/simulation/simulation_page.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MacosApp(
        theme: MacosThemeData(),
        home: const SimulationPage(),
      );
}
