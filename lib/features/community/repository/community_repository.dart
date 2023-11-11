import 'package:reddit_fb_rp/export.dart';
import 'package:fpdart/fpdart.dart';

//https://youtu.be/B8Sx7wGiY-s?t=9923

final communityRepositoryProvider = Provider(
  (ref) {
    return CommunityRespository(firestore: ref.watch(firestoreProvider));
  },
);

//https://youtu.be/B8Sx7wGiY-s?t=9335
class CommunityRespository {
  final FirebaseFirestore _firestore;
  CommunityRespository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  FutureVoid createCommunity(Community community) async {
    try {
      //https://youtu.be/B8Sx7wGiY-s?t=9725
      //ensure that the same name does not exist
      var communityDoc = await _communities.doc(community.name).get();
      if (communityDoc.exists) {
        throw 'Community with the same name already exists';
        //if failed it will be catch (e)
      }
      return right(_communities.doc(community.name).set(community.toMap()));
    } on FirebaseException catch (e) {
      // throw e.message!;
      return left(Failure(e.message!));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

//https://youtu.be/B8Sx7wGiY-s?t=9445
  CollectionReference get _communities =>
      _firestore.collection(FirebaseConstants.communitiesCollection);
}
