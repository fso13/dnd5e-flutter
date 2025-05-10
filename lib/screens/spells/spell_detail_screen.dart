import 'package:flutter/material.dart';
import '../../models/spell.dart';

class SpellDetailScreen extends StatelessWidget {
  final Spell spell;

  const SpellDetailScreen({super.key, required this.spell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(spell.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Уровень', spell.level),
            _buildDetailRow('Школа', spell.school),
            _buildDetailRow('Время накладывания', spell.castingTime),
            _buildDetailRow('Дистанция', spell.range),
            _buildDetailRow('Компоненты', spell.components),
            _buildDetailRow('Длительность', spell.duration),
            const SizedBox(height: 16),
            Text(
              'Описание',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(spell.description),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}