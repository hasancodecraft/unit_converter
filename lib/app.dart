import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/converter_provider.dart';
import 'screens/converter_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ConverterProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Unit Converter',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF3179DC),
          ),
          scaffoldBackgroundColor: const Color(0xFFFAFAFD),
        ),
        home: const ConverterScreen(),
      ),
    );
  }
}
