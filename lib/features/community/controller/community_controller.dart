import 'package:fpdart/fpdart.dart';
import 'package:reddit_fb_rp/core/provider/storage_repository_provider.dart';
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
  //https://youtu.be/B8Sx7wGiY-s?t=15224
  final storageRepository = ref.watch(storageRepositoryProvider);
  return CommunityController(
    communityRespository: communityRespository,
    ref: ref,
    storageRepository: storageRepository,
  );
});

//https://youtu.be/B8Sx7wGiY-s?t=11690
final getCommunityByNameProvider = StreamProvider.family((ref, String name) {
  return ref
      .watch(communityControllerProvider.notifier)
      .getCommunityByName(name);
});

final searchCommunityProvider = StreamProvider.family((ref, String query) {
  return ref.watch(communityControllerProvider.notifier).searchCommunity(query);
});

//https://youtu.be/B8Sx7wGiY-s?t=9967

class CommunityController extends StateNotifier<bool> {
  final CommunityRespository _communityRespository;
  final Ref _ref;
  //https://youtu.be/B8Sx7wGiY-s?t=15201
  final StorageRepository _storageRepository;

  CommunityController({
    required CommunityRespository communityRespository,
    required StorageRepository storageRepository,
    required Ref ref,
    //https://youtu.be/B8Sx7wGiY-s?t=15201
  })  : _communityRespository = communityRespository,
        _ref = ref,
        _storageRepository = storageRepository,
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

  //https://youtu.be/B8Sx7wGiY-s?t=11656
  Stream<Community> getCommunityByName(String name) {
    return _communityRespository.getCommunityByName(name);
  }

  //https://youtu.be/B8Sx7wGiY-s?t=15063
  void editCommunity({
    required File? profileFile,
    required File? bannerFile,
    required Uint8List? profileWebFile,
    required Uint8List? bannerWebFile,
    required BuildContext context,
    required Community community,
  }) async {
    state = true;
    if (profileFile != null || profileWebFile != null) {
      //https://youtu.be/B8Sx7wGiY-s?t=15287
      //store the files in communities/profiles/meme
      final res = await _storageRepository.storeFile(
        path: 'communities/profile',
        id: community.name,
        file: profileFile,
        webFile: profileWebFile,
      );
      res.fold(
        (l) => showSnackBar(context, l.message),
        (r) => community = community.copyWith(avatar: r),
      );
    }
    if (bannerFile != null || bannerWebFile != null) {
      //https://youtu.be/B8Sx7wGiY-s?t=15429
      final res = await _storageRepository.storeFile(
        path: 'communities/banner',
        id: community.name,
        file: bannerFile,
        webFile: bannerWebFile,
      );
      res.fold(
        (l) => showSnackBar(context, l.message),
        (r) => community = community.copyWith(banner: r),
      );
    }

    final res = await _communityRespository.editCommunity(community);
    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) => Routemaster.of(context).pop(),
    );
  }

  //https://youtu.be/B8Sx7wGiY-s?t=16326
  Stream<List<Community>> searchCommunity(String query) {
    return _communityRespository.searchCommunity(query);
  }

  // https://youtu.be/B8Sx7wGiY-s?t=17505
  //leave or join the community
  void joinCommunity(Community community, BuildContext context) async {
    final user = _ref.read(userProvider)!;

    Either<Failure, void> res;
    if (community.members.contains(user.uid)) {
      res =
          await _communityRespository.leaveCommunity(community.name, user.uid);
    } else {
      res = await _communityRespository.joinCommunity(community.name, user.uid);
    }
    res.fold((l) => showSnackBar(context, l.message), (r) {
      if (community.members.contains(user.uid)) {
        showSnackBar(context, 'Communit left successfully!');
      } else {
        showSnackBar(context, 'Community joined successfully!');
      }
    });
  }

  //https://youtu.be/B8Sx7wGiY-s?t=18704
  void addMods(
      String communityName, List<String> uids, BuildContext context) async {
    final res = await _communityRespository.addMods(communityName, uids);
    res.fold((l) => showSnackBar(context, l.message),
        (r) => Routemaster.of(context).pop());
  }
}
