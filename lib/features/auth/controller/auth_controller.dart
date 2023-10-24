//https://youtu.be/B8Sx7wGiY-s?t=2713

import 'package:reddit_fb_rp/export.dart';

final authControllerProvider = Provider((ref) => AuthController(
    //https://youtu.be/B8Sx7wGiY-s?t=3322
    authRepository: ref.read(authRepositoryProvider)));

class AuthController {
  final AuthRepository _authRepository;

  AuthController({required AuthRepository authRepository})
      : _authRepository = authRepository;

  void signInWithGoogle() {
    _authRepository.signInWithGoogle();
  }
}
