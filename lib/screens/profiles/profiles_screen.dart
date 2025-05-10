import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profile_edit_screen.dart';
import 'profile_detail_screen.dart';
import '../../providers/profiles_provider.dart';

class ProfilesScreen extends StatelessWidget {
  const ProfilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profilesProvider = context.watch<ProfilesProvider>();
    final profiles = profilesProvider.profiles;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Профили персонажей'),
      ),
      body: ListView.builder(
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          final profile = profiles[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              title: Text(profile.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${profile.race} ${profile.characterClass} ${profile.level} уровня'),
                  Text('Бонус мастерства: +${profile.proficiencyBonus}'),
                  if (profile.description.isNotEmpty)
                    Text(
                      profile.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                ],
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileDetailScreen(profile: profile),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final newProfile = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProfileEditScreen(),
            ),
          );
          if (newProfile != null) {
            profilesProvider.addProfile(newProfile);
          }
        },
      ),
    );
  }
}