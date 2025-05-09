import 'package:flutter/material.dart';
import 'spells/spells_screen.dart';
import 'monsters/monsters_screen.dart';
import 'settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  // И добавим экран в _screens
  final List<Widget> _screens = [
    const SpellsScreen(),
    const MonstersScreen(),
    const SettingsScreen(),
  ];
  final List<Text> _titles = [
    Text("Заклинания"),
    Text("Монстры"),
    Text("Настройки"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _titles[_currentIndex],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Center(
                child: Text(
                  'RPG Guide',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.auto_awesome, color: Colors.deepPurple),
              title: const Text('Заклинания'),
              selected: _currentIndex == 0,
              onTap: () {
                setState(() => _currentIndex = 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.pets, color: Colors.deepPurple),
              title: const Text('Монстры'),
              selected: _currentIndex == 1,
              onTap: () {
                setState(() => _currentIndex = 1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.deepPurple),
              title: const Text('Настройки'),
              selected: _currentIndex == 2,
              onTap: () {
                setState(() => _currentIndex = 2);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _screens[_currentIndex],
      ),
    );
  }
}
