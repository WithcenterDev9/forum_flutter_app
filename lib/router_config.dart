import 'package:forum_firebase_app/screens/discussions/discussion.screen.dart';
import 'package:forum_firebase_app/screens/posts/post.add.screen.dart';
import 'package:forum_firebase_app/screens/posts/post.screen.dart';
import 'package:forum_firebase_app/screens/qna/qna.screen.dart';
import 'package:go_router/go_router.dart';

// i believe that there is global key here

final routerConfig = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/discussion',
  routes: [
    GoRoute(
      path: "/discussion",
      builder: (context, state) => DiscussionScreen(),
    ),
    GoRoute(path: '/qna', builder: (context, state) => QnaScreen()),
    GoRoute(path: '/add_post', builder: (context, state) => PostAddScreen()),
    GoRoute(
      path: '/post/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'];
        return PostScreen(id: id!);
      },
    ),
  ],
);
