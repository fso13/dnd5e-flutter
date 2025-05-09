import 'package:flutter/material.dart';
import 'spell_detail_screen.dart';
import '../../data/spells_data.dart';

class SpellsScreen extends StatelessWidget {
  const SpellsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: spells.length,
      itemBuilder: (context, index) {
        final spell = spells[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            leading: const Icon(Icons.auto_awesome, color: Colors.deepPurple),
            title: Text(spell.name),
            subtitle: Text(
              '${spell.level} уровень • ${spell.school}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SpellDetailScreen(spell: spell),
                ),
              );
            },
          ),
        );
      },
    );
  }
}