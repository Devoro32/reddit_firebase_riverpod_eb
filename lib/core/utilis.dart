//https://youtu.be/B8Sx7wGiY-s?t=5427

import 'package:reddit_fb_rp/export.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
}
