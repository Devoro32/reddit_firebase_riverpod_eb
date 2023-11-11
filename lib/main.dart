import 'package:reddit_fb_rp/export.dart';

void main() async {
  //30 minutes
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;
//https://youtu.be/B8Sx7wGiY-s?t=7930
  void getData(WidgetRef ref, User data) async {
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(data.uid)
        .first;
    ref.read(userProvider.notifier).update((state) => userModel);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //https://youtu.be/B8Sx7wGiY-s?t=7880
    return ref.watch(authStateChangeProvider).when(
          data: (data) => MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Reddit Tutorial',
            theme: Pallete.darkModeAppTheme,
            routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
              //TODO: uncomment when FB registration is done, going directly to home screen
              // if (data != null) {
              //   getData(ref, data);
              //   if (userModel != null) {
              //     return loggedInRoute;
              //   }
              // }
              // return loggedOutRoute;
              return loggedInRoute;
            }),
            routeInformationParser: const RoutemasterParser(),
          ),
          error: (error, StackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loader(),
        );
  }
}


  //https://youtu.be/B8Sx7wGiY-s?t=6768
    //https://youtu.be/B8Sx7wGiY-s?t=7625
