import 'package:fpdart/fpdart.dart';
import 'package:reddit_fb_rp/export.dart';
//https://youtu.be/B8Sx7wGiY-s?t=19708

final userProfileRepositoryProvider = Provider(
  (ref) {
    return UserProfileRepository(firestore: ref.watch(firestoreProvider));
  },
);

class UserProfileRepository {
  final FirebaseFirestore _firestore;

  UserProfileRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  FutureVoid editCommunity(UserModel user) async {
    try {
      return right(
        _users.doc(user.uid).update(
              user.toMap(),
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
}
