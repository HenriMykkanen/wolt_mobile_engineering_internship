import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wolt_mobile_engineering_internship/constants/theme.dart';
import 'package:wolt_mobile_engineering_internship/presentation/screens/home_screen.dart';

// If you're reading this, hi and welcome to my version of the preliminary assignment
// for Wolt 2024 Mobile Engineering Internships.
// The application was developed and tested on:
// Pixel_3a_API_extension_level_7_x86_64(android-x-64-emulator)
//
// To run the app you should simply need to launch it in either debug mode or not
// The initial application state just loads location data from a hard coded
// position that is set to Kuopio. You can find the logic and data for locations
// in the location_provider.dart file.
//
// You can click on the "start loop" - button in the AppBar to start the loop
// that starts cycling through the locations provided in the assignment input.
// I chose to not initiate the loop straight at the start so that it's a bit easier
// to play around with the UI when it doesn't change constantly, unless you choose so.
//
// I hope that you enjoy my submission an that it satisfies the
// requirements listed in the assignment :)
//
// Henri Mykkänen 31/01/2024

main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getAppTheme(context),
      home: const HomeScreen(),
    );
  }
}
