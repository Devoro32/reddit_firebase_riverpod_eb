//https://youtu.be/B8Sx7wGiY-s?t=2713

import 'package:reddit_fb_rp/export.dart';

final authControllerProvider = Provider((ref) => AuthController(
    //https://youtu.be/B8Sx7wGiY-s?t=3322
    authRepository: ref.read(authRepositoryProvider)));

class AuthController {
  final AuthRepository _authRepository;

  AuthController({required AuthRepository authRepository})
      : _authRepository = authRepository;
//https://youtu.be/B8Sx7wGiY-s?t=5408
  void signInWithGoogle(BuildContext context) async {
    final user = await _authRepository.signInWithGoogle();
    //https://youtu.be/B8Sx7wGiY-s?t=5131
    //* l is failure, r is success
    user.fold((l) => showSnackBar(context, l.message), (r) => null);
  }
}
