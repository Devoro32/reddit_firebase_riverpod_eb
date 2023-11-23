import 'package:reddit_fb_rp/export.dart';

//https://youtu.be/B8Sx7wGiY-s?t=12822
class ModToolsScreen extends StatelessWidget {
  final String name;
  const ModToolsScreen({Key? key, required this.name}) : super(key: key);

  //https://youtu.be/B8Sx7wGiY-s?t=13092
  void navigateToModTools(BuildContext context) {
    Routemaster.of(context).push('/edit-community/$name');
  }

  //https://youtu.be/B8Sx7wGiY-s?t=17991
  void navigateToAddMods(BuildContext context) {
    Routemaster.of(context).push('/add-mods/$name');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mod Tools'),
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.add_moderator),
            title: const Text('Add Moderators'),
            onTap: () => navigateToAddMods(context),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit Communities'),
            onTap: () => navigateToModTools(context),
          )
        ],
      ),
    );
  }
}
