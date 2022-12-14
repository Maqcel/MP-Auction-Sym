import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class SimulationPage extends StatefulWidget {
  const SimulationPage({super.key});

  @override
  State<SimulationPage> createState() => _SimulationPageState();
}

class _SimulationPageState extends State<SimulationPage> {
  @override
  Widget build(BuildContext context) => const MacosWindow();
}
