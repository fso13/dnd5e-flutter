import 'package:flutter/material.dart';
import '../../models/spell.dart';
import '../../data/spells_data.dart';

class SpellListScreen extends StatefulWidget {
  final List<String>? initialSelection;
  
  const SpellListScreen({super.key, this.initialSelection});

  @override
  State<SpellListScreen> createState() => _SpellListScreenState();
}

class _SpellListScreenState extends State<SpellListScreen> {
  late List<Spell> _filteredSpells;
  final TextEditingController _searchController = TextEditingController();
  Set<int> _selectedLevels = {};
  Set<String> _selectedClasses = {};
  Set<String> _selectedSchools = {};

  @override
  void initState() {
    super.initState();
    _filteredSpells = spells;
    _initializeFilters();
  }

  void _initializeFilters() {
    // Получаем все уникальные классы и школы из списка заклинаний
    _selectedClasses = {
      'Бард', 'Жрец', 'Друид', 'Паладин', 'Рейнджер', 
      'Чародей', 'Колдун', 'Волшебник', 'Изобретатель'
    };
    
    _selectedSchools = {
      for (var spell in spells) spell.school
    };
    
    _selectedLevels = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Библиотека заклинаний'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Поиск по названию...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _applyFilters();
                  },
                ),
              ),
              onChanged: (value) => _applyFilters(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredSpells.length,
              itemBuilder: (context, index) {
                final spell = _filteredSpells[index];
                return _buildSpellCard(spell);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpellCard(Spell spell) {
    final isSelected = widget.initialSelection?.contains(spell.id) ?? false;
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getLevelColor(spell.level),
          child: Text(spell.level.toString()),
        ),
        title: Text(spell.name),
        subtitle: Text('${spell.school} • ${_getAvailableClasses(spell)}'),
        trailing: isSelected 
            ? const Icon(Icons.check, color: Colors.green)
            : null,
        onTap: () {
          Navigator.pop(context, spell.id);
        },
      ),
    );
  }

  Color _getLevelColor(String level) {
    final lvl = int.tryParse(level) ?? 0;
    return Colors.primaries[lvl % Colors.primaries.length].withOpacity(0.7);
  }

  String _getAvailableClasses(Spell spell) {
    // В реальном приложении здесь должна быть логика определения классов
    return 'Бард, Волшебник';
  }

  void _applyFilters() {
    final searchQuery = _searchController.text.toLowerCase();
    
    setState(() {
      _filteredSpells = spells.where((spell) {
        // Фильтр по поиску
        final matchesSearch = spell.name.toLowerCase().contains(searchQuery);
        
        // Фильтр по уровню
        final spellLevel = int.tryParse(spell.level) ?? 0;
        final matchesLevel = _selectedLevels.contains(spellLevel);
        
        // Фильтр по школе (упрощенный пример)
        final matchesSchool = _selectedSchools.contains(spell.school);
        
        return matchesSearch && matchesLevel && matchesSchool;
      }).toList();
    });
  }

  Future<void> _showFilterDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Фильтры'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildLevelFilter(setState),
                    const Divider(),
                    _buildSchoolFilter(setState),
                    const Divider(),
                    _buildClassFilter(setState),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Сбросить'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _applyFilters();
                  },
                  child: const Text('Применить'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildLevelFilter(StateSetter setState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Уровень заклинания:', style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 8,
          children: List.generate(10, (level) {
            return FilterChip(
              label: Text(level == 0 ? 'Заговоры' : '$level уровень'),
              selected: _selectedLevels.contains(level),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedLevels.add(level);
                  } else {
                    _selectedLevels.remove(level);
                  }
                });
              },
            );
          }),
        ),
      ],
    );
  }

  Widget _buildSchoolFilter(StateSetter setState) {
    final allSchools = {
      for (var spell in spells) spell.school
    };
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Школа магии:', style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 8,
          children: allSchools.map((school) {
            return FilterChip(
              label: Text(school),
              selected: _selectedSchools.contains(school),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedSchools.add(school);
                  } else {
                    _selectedSchools.remove(school);
                  }
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildClassFilter(StateSetter setState) {
    const allClasses = [
      'Бард', 'Жрец', 'Друид', 'Паладин', 'Рейнджер',
      'Чародей', 'Колдун', 'Волшебник', 'Изобретатель'
    ];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Доступно классам:', style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 8,
          children: allClasses.map((cls) {
            return FilterChip(
              label: Text(cls),
              selected: _selectedClasses.contains(cls),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedClasses.add(cls);
                  } else {
                    _selectedClasses.remove(cls);
                  }
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}