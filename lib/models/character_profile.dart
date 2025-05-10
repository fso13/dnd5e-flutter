class CharacterProfile {
  final String id;
  final String name;
  final String characterClass;
  final String race;
  final int level;
  final int proficiencyBonus;
  final Map<String, int> stats;
  final List<String> skills;
  final List<String> inventory;
  final String description;
  final List<String> spellIds;

  CharacterProfile({
    required this.id,
    required this.name,
    required this.characterClass,
    required this.race,
    required this.level,
    required this.proficiencyBonus,
    required this.stats,
    required this.skills,
    required this.inventory,
    required this.description,
    List<String>? spellIds,
  }) : spellIds = spellIds ?? [];

  int getStatModifier(String stat) => ((stats[stat]! - 10) / 2).floor();

  CharacterProfile copyWith({
    String? name,
    String? characterClass,
    String? race,
    int? level,
    int? proficiencyBonus,
    Map<String, int>? stats,
    List<String>? skills,
    List<String>? inventory,
    String? description,
    List<String>? spellIds,
  }) {
    return CharacterProfile(
      id: id,
      name: name ?? this.name,
      characterClass: characterClass ?? this.characterClass,
      race: race ?? this.race,
      level: level ?? this.level,
      proficiencyBonus: proficiencyBonus ?? this.proficiencyBonus,
      stats: stats ?? this.stats,
      skills: skills ?? this.skills,
      inventory: inventory ?? this.inventory,
      description: description ?? this.description,
      spellIds: spellIds ?? this.spellIds,
    );
  }
}