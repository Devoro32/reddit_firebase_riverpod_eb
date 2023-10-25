import 'package:reddit_fb_rp/export.dart';
import 'package:fpdart/fpdart.dart';
//logic for the firebase calls
//https://youtu.be/B8Sx7wGiY-s?t=2200

//creating a provider so we do not call the auth repository every time we need to use it
//https://youtu.be/B8Sx7wGiY-s?t=2933

final authRepositoryProvider = Provider((ref) => AuthRepository(
      //https://youtu.be/B8Sx7wGiY-s?t=3145
      //* ref.read-> outside build context, ref.watch-> inside build context
      firestore: ref.read(firestoreProvider),
      auth: ref.read(authProvider),
      googleSignIn: ref.read(googleSignInProvider),
    ));

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
        _firestore = firestore,
        _googleSignIn = googleSignIn;

  CollectionReference get _users => _firestore.collection(
        FirebaseConstants.usersCollection,
      );

//https://youtu.be/B8Sx7wGiY-s?t=5085
//*with either, you indicate the type of failure vs success
  FutureEither<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: (googleAuth)?.accessToken,
        idToken: (googleAuth)?.idToken,
      );
//completed
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      /* print("User credential: $userCredential");
      print("userCredential.user?.email: ${userCredential.user?.email}");
      print("userCredential.user: ${userCredential.user}");
      */
      late UserModel userModel;
      //https://youtu.be/B8Sx7wGiY-s?t=4741
      if (userCredential.additionalUserInfo!.isNewUser) {
        //https://youtu.be/B8Sx7wGiY-s?t=4325
        userModel = UserModel(
          name: userCredential.user!.displayName!,
          profilePic: userCredential.user!.photoURL ?? Constants.avatarDefault,
          banner: Constants.bannerDefault,
          uid: userCredential.user!.uid,
          isAuthenticated: true,
          karma: 0,
          awards: [],
        );
        await _users.doc(userCredential.user!.uid).set(userModel.toMap());
      }
      //* this is due to the typedef and indicate that it is a success
      //https://youtu.be/B8Sx7wGiY-s?t=5300
      return right(userModel);
      //TODO: If not a new user;
    } on FirebaseException catch (e) {
      //throw ensure that it goes to the next catch blocks
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
      print("Error: $e");
    }
  }
}
