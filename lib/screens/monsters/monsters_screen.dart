import 'package:flutter/material.dart';
import 'monster_detail_screen.dart';
import '../../data/monsters_data.dart';

class MonstersScreen extends StatelessWidget {
  const MonstersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: monsters.length,
      itemBuilder: (context, index) {
        final monster = monsters[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            leading: const Icon(Icons.pets, color: Colors.deepPurple),
            title: Text(monster.name),
            subtitle: Text(
              '${monster.type} • ОП: ${monster.challengeRating}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MonsterDetailScreen(monster: monster),
                ),
              );
            },
          ),
        );
      },
    );
  }
}