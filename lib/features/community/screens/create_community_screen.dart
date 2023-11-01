import 'package:reddit_fb_rp/export.dart';

//https://youtu.be/B8Sx7wGiY-s?t=8835
class CreateCommunityScreen extends ConsumerStatefulWidget {
  const CreateCommunityScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends ConsumerState<CreateCommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//https://youtu.be/B8Sx7wGiY-s?t=8860
      appBar: AppBar(
        title: const Text('Create Community'),
      ),
      body: const Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Text('Create Community'),
            const SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'r/Community_name',
                filled: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
