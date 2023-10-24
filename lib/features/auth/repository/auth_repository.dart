import 'package:reddit_fb_rp/export.dart';
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

  void signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: (googleAuth)?.accessToken,
        idToken: (googleAuth)?.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      print("User credential: $userCredential");
      print("userCredential.user?.email: ${userCredential.user?.email}");
      print("userCredential.user: ${userCredential.user}");
    } catch (e) {
      print("Error: $e");
    }
  }
}
