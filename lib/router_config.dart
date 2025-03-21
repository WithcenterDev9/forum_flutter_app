import 'package:forum_firebase_app/global.dart';
import 'package:forum_firebase_app/screens/forum/forum.screen.dart';
import 'package:forum_firebase_app/screens/home/home.screen.dart';
import 'package:forum_firebase_app/screens/forum/post.create.screen.dart';
import 'package:go_router/go_router.dart';

// i believe that there is global key here

final routerConfig = GoRouter(
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: HomeScreenScreen.routeName,
      builder: (context, state) => HomeScreenScreen(),
    ),
    GoRoute(
      path: ForumScreen.routeName,
      builder:
          (context, state) => ForumScreen(
            category:
                state.extra != null
                    ? (state.extra as Map<String, dynamic>)['category']
                    : Category.discussion,
          ),
    ),

    GoRoute(
      path: PostCreateScreen.routeName,
      builder:
          (context, state) => PostCreateScreen(
            category:
                state.extra != null
                    ? (state.extra as Map<String, dynamic>)['category']
                    : Category.discussion,
          ),
    ),
  ],
);
