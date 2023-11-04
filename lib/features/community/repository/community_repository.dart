import 'package:reddit_fb_rp/export.dart';
import 'package:fpdart/fpdart.dart';

//https://youtu.be/B8Sx7wGiY-s?t=9335
class CommunityRespository {
  final FirebaseFirestore _firestore;
  CommunityRespository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  FutureVoid createCommunity() async {
    try {
      return right(true);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  CollectionReference get _communities =>
      _firestore.collection(FirebaseConstants.commentsCollection);
}
