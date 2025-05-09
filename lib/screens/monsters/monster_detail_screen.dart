import 'package:flutter/material.dart';
import '../../models/monster.dart';

class MonsterDetailScreen extends StatelessWidget {
  final Monster monster;

  MonsterDetailScreen({required this.monster});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(monster.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Тип: ${monster.type}', style: TextStyle(fontSize: 18)),
            Text('Опасность: ${monster.challengeRating}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('Класс брони: ${monster.armorClass}'),
            Text('Хиты: ${monster.hitPoints}'),
            SizedBox(height: 20),
            Text('Описание:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(monster.description),
          ],
        ),
      ),
    );
  }
}