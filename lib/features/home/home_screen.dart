import 'dart:io';

import 'package:reddit_fb_rp/export.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: false,
        leading: Builder(builder: (context) {
          return IconButton(
            //https://youtu.be/B8Sx7wGiY-s?t=8470
            onPressed: () => displayDrawer(context),
            icon: const Icon(Icons.menu),
          );
        }),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const CircleAvatar(
                // backgroundColor: Colors.white,
                backgroundImage:
                    //  AssetImage(
                    //   Constants.googlepath,
                    // )

                    //TODO: replace the picture with the one coming from firebase
                    //NetworkImage(user.profilePic),
                    NetworkImage(Constants.avatarDefault)),
          )
        ],
      ),
      drawer: CommunityListDrawer(),
      body: const Center(child: Text('text')
          // Text(user.name),
          ),
    );
  }
}
