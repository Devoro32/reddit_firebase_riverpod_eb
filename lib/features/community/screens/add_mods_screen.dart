//https://youtu.be/B8Sx7wGiY-s?t=17888
import 'package:reddit_fb_rp/export.dart';

class AddModScreen extends ConsumerStatefulWidget {
  final String name;
  const AddModScreen({
    required this.name,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddModScreenState();
}

class _AddModScreenState extends ConsumerState<AddModScreen> {
  //https://youtu.be/B8Sx7wGiY-s?t=18273
  //set doesn't allow for repeating values
  Set<String> uids = {};
  int ctr = 0;

  void addUids(String uid) {
    setState(() {
      uids.add(uid);
    });
  }

  void removeUids(String uid) {
    setState(() {
      uids.remove(uid);
    });
  }

  //https://youtu.be/B8Sx7wGiY-s?t=18756
  void saveMods() {
    ref.read(communityControllerProvider.notifier).addMods(
          widget.name,
          uids.toList(),
          context,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: saveMods,
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: ref
          .watch(getCommunityByNameProvider(widget.name))
          .
          //https://youtu.be/B8Sx7wGiY-s?t=18108
          when(
            data: (community) => ListView.builder(
              itemCount: community.members.length,
              itemBuilder: (BuildContext context, int index) {
                final member = community.members[index];
                return ref.watch(getUserDataProvider(member)).when(
                      data: (user) {
                        //https://youtu.be/B8Sx7wGiY-s?t=18551
                        if (community.mods.contains(member) && ctr == 0) {
                          uids.add(member);
                        }
                        ctr++;
                        return CheckboxListTile(
                          value: uids.contains(user.uid),
                          onChanged: (value) {
                            if (value!) {
                              addUids(user.uid);
                            } else {
                              removeUids(user.uid);
                            }
                          },
                          title: Text(user.name),
                        );
                      },
                      error: (error, stackTrace) =>
                          ErrorText(error: error.toString()),
                      loading: () => const Loader(),
                    );
              },
            ),
            error: (error, StackTrace) => ErrorText(error: error.toString()),
            loading: () => const Loader(),
          ),
    );
  }
}
