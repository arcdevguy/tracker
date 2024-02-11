import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/injector.dart';
import 'src/page/home_page.dart';
import 'src/provider/location_provider.dart';

void main() {
  Injector.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tracking',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
        create: (context) => getIt<LocationProvider>(),
        child: const HomePage(),
      ),
    );
  }
}
