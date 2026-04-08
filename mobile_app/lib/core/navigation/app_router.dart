import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/data/firebase_auth_repository.dart';
import '../../features/auth/presentation/auth_screen.dart';
import '../../features/study_plan/presentation/study_plan_list_screen.dart';
import '../../features/study_plan/presentation/study_plan_detail_screen.dart';
import '../../features/lesson/presentation/lesson_screen.dart';
import '../../features/exercise/presentation/exercise_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../common/widgets/main_shell.dart';

final _authRepository = FirebaseAuthRepository();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final user = _authRepository.currentUser;
      final isLoginRoute = state.matchedLocation == '/login';

      if (user == null && !isLoginRoute) return '/login';
      if (user != null && isLoginRoute) return '/';
      return null;
    },
    refreshListenable: _authRepository.authStateNotifier,
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const AuthScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const StudyPlanListScreen(),
          ),
          GoRoute(
            path: '/study-plan/:id',
            builder: (context, state) => StudyPlanDetailScreen(
              planId: state.pathParameters['id']!,
            ),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
      // Full-screen routes (no shell/bottom bar)
      GoRoute(
        path: '/lesson/:id',
        builder: (context, state) => LessonScreen(
          lessonId: state.pathParameters['id']!,
          planId: state.uri.queryParameters['planId'] ?? '',
          dayId: state.uri.queryParameters['dayId'] ?? '',
          weekId: state.uri.queryParameters['weekId'] ?? '',
          activityId: state.uri.queryParameters['activityId'] ?? '',
        ),
      ),
      GoRoute(
        path: '/exercise/:id',
        builder: (context, state) => ExerciseScreen(
          exerciseId: state.pathParameters['id']!,
          planId: state.uri.queryParameters['planId'] ?? '',
          dayId: state.uri.queryParameters['dayId'] ?? '',
          weekId: state.uri.queryParameters['weekId'] ?? '',
          activityId: state.uri.queryParameters['activityId'] ?? '',
        ),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Sivua ei löydy',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => context.go('/'),
              child: const Text('Palaa etusivulle'),
            ),
          ],
        ),
      ),
    ),
  );
});
