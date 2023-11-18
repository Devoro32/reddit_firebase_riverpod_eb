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

  //https://youtu.be/B8Sx7wGiY-s?t=10545
  Stream<List<Community>> getUserCommunities(String uid) {
    return _communities
        .where('members', arrayContains: uid)
        .snapshots()
        .map((event) {
      List<Community> communities = [];
      for (var doc in event.docs) {
        communities.add(Community.fromMap(doc.data() as Map<String, dynamic>));
      }
      return communities;
    });
  }

  //https://youtu.be/B8Sx7wGiY-s?t=11577
  Stream<Community> getCommunityByName(String name) {
    return _communities.doc(name).snapshots().map(
          (event) => Community.fromMap(event.data() as Map<String, dynamic>),
        );
  }

  //https://youtu.be/B8Sx7wGiY-s?t=14938
  FutureVoid editCommunity(Community community) async {
    try {
      return right(
        _communities.doc(community.name).update(
              community.toMap(),
            ),
      );
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(
        Failure(e.toString()),
      );
    }
  }

  //https://youtu.be/B8Sx7wGiY-s?t=16040
  Stream<List<Community>> searchCommunity(String query) {
    return _communities
        .where(
          'name',
          isGreaterThanOrEqualTo: query.isEmpty ? 0 : query,
          isLessThan: query.isEmpty
              ? null
              : query.substring(0, query.length - 1) +
                  String.fromCharCode(
                    query.codeUnitAt(query.length - 1) + 1,
                  ),
        )
        .snapshots()
        .map(
      (event) {
        List<Community> communities = [];
        for (var community in event.docs) {
          communities
              .add(Community.fromMap(community.data() as Map<String, dynamic>));
        }
        return communities;
      },
    );
  }

  //https://youtu.be/B8Sx7wGiY-s?t=17294
  FutureVoid joinCommunity(String communityName, String userId) async {
    try {
      return right(_communities.doc(communityName).update({
        'members': FieldValue.arrayUnion([userId]),
      }));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //https://youtu.be/B8Sx7wGiY-s?t=17294
  FutureVoid leaveCommunity(String communityName, String userId) async {
    try {
      return right(_communities.doc(communityName).update({
        'members': FieldValue.arrayRemove([userId]),
      }));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
