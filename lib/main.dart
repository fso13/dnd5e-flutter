import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/settings.dart';
import 'providers/profiles_provider.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settings = AppSettings();
  final profilesProvider = ProfilesProvider();
  await settings.loadSettings();
  
  runApp(
     MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => settings),
        ChangeNotifierProvider(create: (_) => profilesProvider),
      ],
      child: const RPGApp(),
    ),
  );
}

class RPGApp extends StatelessWidget {
  const RPGApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<AppSettings>(context);
    
    return MaterialApp(
      title: 'RPG Guide',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.dark,
      ),
      themeMode: settings.themeMode == AppThemeMode.light 
          ? ThemeMode.light 
          : settings.themeMode == AppThemeMode.dark 
              ? ThemeMode.dark 
              : ThemeMode.system,
      home: Builder(
        builder: (context) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(settings.textScaleFactor),
            ),
            child: const HomeScreen(),
          );
        },
      ),
    );
  }
}