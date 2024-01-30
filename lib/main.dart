import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wolt_mobile_engineering_internship/presentation/screens/home_screen.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // This might not need to be here so it's commented out for now
  // final prefs = await SharedPreferences.getInstance();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
