class Spell {
  final String id;
  final String name;
  final String description;
  final String level;
  final String school;
  final String castingTime;
  final String range;
  final String components;
  final String duration;

  Spell({
    required this.id,
    required this.name,
    required this.description,
    required this.level,
    required this.school,
    required this.castingTime,
    required this.range,
    required this.components,
    required this.duration,
  });
}