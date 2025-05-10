import 'package:flutter/material.dart';
import '../../models/spell.dart';
import '../../data/spells_data.dart';

class SpellAddScreen extends StatefulWidget {
  final List<String> currentSpellIds;
  
  const SpellAddScreen({
    super.key,
    required this.currentSpellIds,
  });

  @override
  State<SpellAddScreen> createState() => _SpellAddScreenState();
}

class _SpellAddScreenState extends State<SpellAddScreen> {
  late Set<String> _selectedSpellIds;

  @override
  void initState() {
    super.initState();
    _selectedSpellIds = Set.from(widget.currentSpellIds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить заклинания'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              Navigator.pop(context, _selectedSpellIds.toList());
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: spells.length,
        itemBuilder: (context, index) {
          final spell = spells[index];
          final isSelected = _selectedSpellIds.contains(spell.id);
          
          return CheckboxListTile(
            title: Text(spell.name),
            subtitle: Text('${spell.level} уровень, ${spell.school}'),
            value: isSelected,
            onChanged: (bool? value) {
              setState(() {
                if (value == true) {
                  _selectedSpellIds.add(spell.id);
                } else {
                  _selectedSpellIds.remove(spell.id);
                }
              });
            },
            secondary: Icon(
              isSelected ? Icons.check_box : Icons.check_box_outline_blank,
              color: isSelected ? Colors.deepPurple : null,
            ),
          );
        },
      ),
    );
  }
}