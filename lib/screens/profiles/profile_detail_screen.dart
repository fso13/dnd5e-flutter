import 'package:dnd53_flutter/screens/spells/spell_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/character_profile.dart';
import '../../models/spell.dart';
import '../../data/spells_data.dart';
import '../spells/spell_detail_screen.dart';
import '../../providers/profiles_provider.dart';
import 'spell_add_screen.dart';

class ProfileDetailScreen extends StatelessWidget {
  final CharacterProfile profile;

  const ProfileDetailScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final profileSpells =
        spells.where((s) => profile.spellIds.contains(s.id)).toList();
    final statModifiers = {
      'Сила': profile.getStatModifier('strength'),
      'Ловкость': profile.getStatModifier('dexterity'),
      'Телосложение': profile.getStatModifier('constitution'),
      'Интеллект': profile.getStatModifier('intelligence'),
      'Мудрость': profile.getStatModifier('wisdom'),
      'Харизма': profile.getStatModifier('charisma'),
    };

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(profile.name),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.info_outline)),
              Tab(icon: Icon(Icons.auto_awesome)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Вкладка с общей информацией
            _buildGeneralInfoTab(context, statModifiers),

            // Вкладка с заклинаниями
            _buildSpellsTab(context, profileSpells),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            final updatedSpellIds = await Navigator.push<List<String>>(
              context,
              MaterialPageRoute(
                builder:
                    (context) =>
                        SpellListScreen(initialSelection: profile.spellIds),
              ),
            );

            if (updatedSpellIds != null) {
              context.read<ProfilesProvider>().updateSpells(
                profile.id,
                updatedSpellIds,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Добавлено ${updatedSpellIds.length - profile.spellIds.length} заклинаний',
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  // Вкладка с общей информацией
  Widget _buildGeneralInfoTab(
    BuildContext context,
    Map<String, int> statModifiers,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Основная информация
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildInfoRow('Раса', profile.race),
                  _buildInfoRow('Класс', profile.characterClass),
                  _buildInfoRow('Уровень', '${profile.level}'),
                  _buildInfoRow(
                    'Бонус мастерства',
                    '+${profile.proficiencyBonus}',
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Характеристики
          _buildSectionHeader('Характеристики'),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 2,
            children:
                statModifiers.entries.map((e) {
                  return _buildStatCard(
                    statName: e.key,
                    value: profile.stats[e.key.toLowerCase()] ?? 10,
                    modifier: e.value,
                  );
                }).toList(),
          ),

          // Навыки
          if (profile.skills.isNotEmpty) ...[
            const SizedBox(height: 20),
            _buildSectionHeader('Навыки'),
            Wrap(
              spacing: 8,
              children:
                  profile.skills
                      .map(
                        (skill) => Chip(
                          label: Text(skill),
                          backgroundColor: Theme.of(
                            context,
                          ).primaryColor.withOpacity(0.1),
                        ),
                      )
                      .toList(),
            ),
          ],

          // Инвентарь
          if (profile.inventory.isNotEmpty) ...[
            const SizedBox(height: 20),
            _buildSectionHeader('Инвентарь'),
            Column(
              children:
                  profile.inventory
                      .map(
                        (item) => ListTile(
                          leading: const Icon(Icons.chevron_right, size: 16),
                          title: Text(item),
                        ),
                      )
                      .toList(),
            ),
          ],

          // Описание
          if (profile.description.isNotEmpty) ...[
            const SizedBox(height: 20),
            _buildSectionHeader('Описание'),
            Text(profile.description),
          ],
        ],
      ),
    );
  }

  // Вкладка с заклинаниями
  Widget _buildSpellsTab(BuildContext context, List<Spell> spells) {
    if (spells.isEmpty) {
      return const Center(child: Text('Нет добавленных заклинаний'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: spells.length,
      itemBuilder: (context, index) {
        final spell = spells[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
              child: Text('${spell.level}'),
            ),
            title: Text(spell.name),
            subtitle: Text(spell.school),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                context.read<ProfilesProvider>().removeSpellFromProfile(
                  profile.id,
                  spell.id,
                );
              },
            ),
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

  // Вспомогательные методы
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String statName,
    required int value,
    required int modifier,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(statName, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '(${modifier >= 0 ? '+' : ''}$modifier)',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
