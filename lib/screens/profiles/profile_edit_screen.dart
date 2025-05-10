import 'package:flutter/material.dart';
import '../../models/character_profile.dart';


class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _levelController = TextEditingController(text: '1');
  final _proficiencyController = TextEditingController(text: '2');
  final _descriptionController = TextEditingController();
  final _inventoryController = TextEditingController();
  final _skillsController = TextEditingController();

  String _selectedClass = 'Бард';
  String _selectedRace = 'Человек';
  
  final Map<String, int> _stats = {
    'strength': 10,
    'dexterity': 10,
    'constitution': 10,
    'intelligence': 10,
    'wisdom': 10,
    'charisma': 10,
  };

  final List<String> _classes = [
    "Бард",
    "Жрец",
    "Друид",
    "Паладин",
    "Рейнджер",
    "Чародей",
    "Колдун",
    "Волшебник",
    "Изобретатель"
  ];

  final List<String> _races = [
    "Дварф",
    "Полурослик",
    "Человек",
    "Эльф",
    "Гном",
    "Драконорожденный",
    "Полуорк",
    "Полуэльф",
    "Тифлинг"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Создать персонажа'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveProfile,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBasicInfoSection(),
              const SizedBox(height: 20),
              _buildStatsSection(),
              const SizedBox(height: 20),
              _buildSkillsSection(),
              const SizedBox(height: 20),
              _buildInventorySection(),
              const SizedBox(height: 20),
              _buildDescriptionSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBasicInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Основная информация', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(labelText: 'Имя персонажа'),
          validator: (value) => value?.isEmpty ?? true ? 'Введите имя' : null,
        ),
        DropdownButtonFormField<String>(
          value: _selectedClass,
          decoration: const InputDecoration(labelText: 'Класс'),
          items: _classes.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) => setState(() => _selectedClass = value!),
        ),
        DropdownButtonFormField<String>(
          value: _selectedRace,
          decoration: const InputDecoration(labelText: 'Раса'),
          items: _races.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) => setState(() => _selectedRace = value!),
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _levelController,
                decoration: const InputDecoration(labelText: 'Уровень'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Введите уровень';
                  final level = int.tryParse(value!);
                  if (level == null || level < 1 || level > 20) {
                    return 'Уровень должен быть от 1 до 20';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _proficiencyController,
                decoration: const InputDecoration(labelText: 'Бонус мастерства'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Введите бонус';
                  final bonus = int.tryParse(value!);
                  if (bonus == null || bonus < 2 || bonus > 6) {
                    return 'Бонус должен быть от 2 до 6';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Характеристики', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _buildStatInput('Сила', 'strength'),
        _buildStatInput('Ловкость', 'dexterity'),
        _buildStatInput('Телосложение', 'constitution'),
        _buildStatInput('Интеллект', 'intelligence'),
        _buildStatInput('Мудрость', 'wisdom'),
        _buildStatInput('Харизма', 'charisma'),
      ],
    );
  }

  Widget _buildStatInput(String label, String statKey) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(label)),
          Expanded(
            child: TextFormField(
              initialValue: _stats[statKey]?.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
              ),
              onChanged: (value) {
                final intValue = int.tryParse(value) ?? 10;
                _stats[statKey] = intValue.clamp(1, 20);
              },
            ),
          ),
          SizedBox(
            width: 40,
            child: Text(
              '(${((_stats[statKey]! - 10) / 2).floor()})',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Навыки', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        TextFormField(
          controller: _skillsController,
          decoration: const InputDecoration(
            labelText: 'Навыки (через запятую)',
            hintText: 'Акробатика, Атлетика, Обман...'
          ),
          maxLines: 2,
        ),
      ],
    );
  }

  Widget _buildInventorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Инвентарь', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        TextFormField(
          controller: _inventoryController,
          decoration: const InputDecoration(
            labelText: 'Инвентарь (через запятую)',
            hintText: 'Меч, Щит, Зелье лечения...'
          ),
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Описание', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        TextFormField(
          controller: _descriptionController,
          decoration: const InputDecoration(
            labelText: 'Описание персонажа',
            hintText: 'Внешность, характер, история...'
          ),
          maxLines: 5,
        ),
      ],
    );
  }

  void _saveProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      final newProfile = CharacterProfile(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        characterClass: _selectedClass,
        race: _selectedRace,
        level: int.parse(_levelController.text),
        proficiencyBonus: int.parse(_proficiencyController.text),
        stats: Map.from(_stats),
        skills: _skillsController.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
        inventory: _inventoryController.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
        description: _descriptionController.text,
      );
      
      Navigator.pop(context, newProfile);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _levelController.dispose();
    _proficiencyController.dispose();
    _descriptionController.dispose();
    _inventoryController.dispose();
    _skillsController.dispose();
    super.dispose();
  }
}