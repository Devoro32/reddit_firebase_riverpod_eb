import 'package:reddit_fb_rp/export.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(
        child: LoginScreen(),
      )
});

//login route
final loggedInRoute = RouteMap(routes: {
  '/': (_) => MaterialPage(child: const HomeScreen()),
  '/create-community': (_) =>
      const MaterialPage(child: CreateCommunityScreen()),
  //https://youtu.be/B8Sx7wGiY-s?t=11435#
  //call slugged
  '/r:name': (route) =>
      MaterialPage(child: CommunityScreen(name: route.pathParameters['name']!)),
  '/mod-tools/:name': (routeData) => MaterialPage(
        child: ModToolsScreen(name: routeData.pathParameters['name']!),
      ),
  '/edit-community/:name': (routeData) => MaterialPage(
        child: EditCommunityScreen(name: routeData.pathParameters['name']!),
      ),
});

//login route