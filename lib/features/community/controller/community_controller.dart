import 'package:reddit_fb_rp/export.dart';
//https://youtu.be/B8Sx7wGiY-s?t=10928

final userCommunitiesProvider = StreamProvider((ref) {
  final communityController = ref.watch(communityControllerProvider.notifier);
  return communityController.getUserCommunities();
});

//https://youtu.be/B8Sx7wGiY-s
final communityControllerProvider =
    StateNotifierProvider<CommunityController, bool>((ref) {
  final communityRespository = ref.watch(communityRepositoryProvider);
  return CommunityController(
    communityRespository: communityRespository,
    ref: ref,
  );
});

//https://youtu.be/B8Sx7wGiY-s?t=9967

class CommunityController extends StateNotifier<bool> {
  final CommunityRespository _communityRespository;
  final Ref _ref;

  CommunityController({
    required CommunityRespository communityRespository,
    required Ref ref,
  })  : _communityRespository = communityRespository,
        _ref = ref,
        //https://youtu.be/B8Sx7wGiY-s?t=10279
        //want the state to be false for the loading
        super(false);

  void createCommunity(String name, BuildContext context) async {
    final uid = _ref.read(userProvider)?.uid ?? '';
    state = true;
    Community community = Community(
      id: name,
      name: name,
      banner: Constants.bannerDefault,
      avatar: Constants.avatarDefault,
      members: [uid],
      mods: [uid],
    );

    final result = await _communityRespository.createCommunity(community);
    state = false;
    result.fold((l) => showSnackBar(context, l.message), (r) {
      showSnackBar(context, 'Community created successfully!');
      Routemaster.of(context).pop();
    });
  }

  Stream<List<Community>> getUserCommunities() {
    final uid = _ref.read(userProvider)!.uid;
    return _communityRespository.getUserCommunities(uid);
  }
}
