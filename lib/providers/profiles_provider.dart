import 'package:flutter/material.dart';
import '../models/character_profile.dart';

class ProfilesProvider with ChangeNotifier {
  List<CharacterProfile> _profiles = [];

  List<CharacterProfile> get profiles => _profiles;

  void addProfile(CharacterProfile profile) {
    _profiles.add(profile);
    notifyListeners();
    // Здесь можно добавить сохранение в SharedPreferences или базу данных
  }

  void updateProfile(String id, CharacterProfile newProfile) {
    final index = _profiles.indexWhere((p) => p.id == id);
    if (index != -1) {
      _profiles[index] = newProfile;
      notifyListeners();
    }
  }

void updateSpells(String profileId, List<String> newSpellIds) {
  final index = _profiles.indexWhere((p) => p.id == profileId);
  if (index != -1) {
    _profiles[index] = _profiles[index].copyWith(
      spellIds: newSpellIds,
    );
    notifyListeners();
  }
}

void removeSpellFromProfile(String profileId, String spellId) {
  final index = _profiles.indexWhere((p) => p.id == profileId);
  if (index != -1) {
    _profiles[index] = _profiles[index].copyWith(
      spellIds: _profiles[index].spellIds.where((id) => id != spellId).toList(),
    );
    notifyListeners();
  }
}

void addSpellToProfile(String profileId, String spellId) {
    final index = _profiles.indexWhere((p) => p.id == profileId);
    if (index != -1) {
      final profile = _profiles[index];
      if (!profile.spellIds.contains(spellId)) {
        _profiles[index] = profile.copyWith(
          spellIds: [...profile.spellIds, spellId],
        );
        notifyListeners();
      }
    }
  }
}