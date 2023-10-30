//https://youtu.be/B8Sx7wGiY-s?t=2713

import 'package:reddit_fb_rp/export.dart';

//https://youtu.be/B8Sx7wGiY-s?t=5900
final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    //https://youtu.be/B8Sx7wGiY-s?t=3322
    authRepository: ref.watch(authRepositoryProvider),
    ref: ref,
  ),
);

//https://youtu.be/B8Sx7wGiY-s?t=7341
final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

//https://youtu.be/B8Sx7wGiY-s?t=6336
class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({
    required AuthRepository authRepository,
    required Ref ref,
  })  : _authRepository = authRepository,
        _ref = ref,
        //this states represents 'isloading' variable
        super(false);
//https://youtu.be/B8Sx7wGiY-s?t=7314
  Stream<User?> get authStateChange => _authRepository.authStateChange;

//https://youtu.be/B8Sx7wGiY-s?t=5408
  void signInWithGoogle(BuildContext context) async {
    state = true;
    final user = await _authRepository.signInWithGoogle();
    state = false;
    //https://youtu.be/B8Sx7wGiY-s?t=5131
    //* l is failure, r is success
    user.fold(
        (l) => showSnackBar(context, l.message),
        (userModel) =>
            _ref.read(userProvider.notifier).update((state) => userModel));
  }

  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }
}
