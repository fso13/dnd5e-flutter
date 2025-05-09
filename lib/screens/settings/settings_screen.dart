import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<AppSettings>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionHeader('Тема приложения'),
          _buildThemeOption(
            context,
            'Светлая',
            AppThemeMode.light,
            settings.themeMode,
          ),
          _buildThemeOption(
            context,
            'Тёмная',
            AppThemeMode.dark,
            settings.themeMode,
          ),
          _buildThemeOption(
            context,
            'Как в системе',
            AppThemeMode.system,
            settings.themeMode,
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('Масштаб текста'),
          _buildTextScaleOption(
            context,
            'Обычный (1x)',
            TextScale.normal,
            settings.textScale,
          ),
          _buildTextScaleOption(
            context,
            'Крупный (1.25x)',
            TextScale.large,
            settings.textScale,
          ),
          _buildTextScaleOption(
            context,
            'Очень крупный (1.5x)',
            TextScale.extraLarge,
            settings.textScale,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    String title,
    AppThemeMode mode,
    AppThemeMode selectedMode,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(title),
        leading: Radio<AppThemeMode>(
          value: mode,
          groupValue: selectedMode,
          onChanged: (value) {
            Provider.of<AppSettings>(context, listen: false)
                .setThemeMode(value!);
          },
        ),
        onTap: () {
          Provider.of<AppSettings>(context, listen: false)
              .setThemeMode(mode);
        },
      ),
    );
  }

  Widget _buildTextScaleOption(
    BuildContext context,
    String title,
    TextScale scale,
    TextScale selectedScale,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(title),
        leading: Radio<TextScale>(
          value: scale,
          groupValue: selectedScale,
          onChanged: (value) {
            Provider.of<AppSettings>(context, listen: false)
                .setTextScale(value!);
          },
        ),
        onTap: () {
          Provider.of<AppSettings>(context, listen: false)
              .setTextScale(scale);
        },
      ),
    );
  }
}