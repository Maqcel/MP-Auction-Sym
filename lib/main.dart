import 'package:auction_sym/data/service/auction_service_impl.dart';
import 'package:auction_sym/data/service/generator_service_impl.dart';
import 'package:auction_sym/generated/l10n.dart';
import 'package:auction_sym/simulation/cubit/simulation_cubit.dart';
import 'package:auction_sym/simulation/simulation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:macos_ui/macos_ui.dart';

const englishLanguageCode = 'en';

Future<void> main() async => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MacosApp(
        debugShowCheckedModeBanner: false,
        theme: MacosThemeData(),
        home: BlocProvider(
          create: (context) => SimulationCubit(
            GeneratorServiceImpl(),
            AuctionServiceImpl(),
          )..startSimulation(),
          child: const SimulationPage(),
        ),
        localizationsDelegates: const [
          Strings.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: const Locale(englishLanguageCode),
        supportedLocales: const [
          Locale(englishLanguageCode),
        ],
      );
}
