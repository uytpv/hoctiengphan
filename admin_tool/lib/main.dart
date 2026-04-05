import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'features/activity/presentation/activity_list_screen.dart';
import 'features/study_plan/presentation/study_plan_list_screen.dart';
import 'features/study_plan/presentation/study_plan_detail_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Import Admin Layout & Features
import 'core/widgets/admin_layout.dart';
import 'features/dashboard/presentation/dashboard_view.dart';
import 'features/auth/presentation/login_screen.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/vocabulary/presentation/vocabulary_list_screen.dart';
import 'features/lesson/presentation/lesson_list_screen.dart';
import 'features/lesson/presentation/lesson_edit_screen.dart';
import 'features/grammar/presentation/grammar_list_screen.dart';
import 'features/exercise/presentation/exercise_list_screen.dart';
import 'features/student/presentation/student_list_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (kDebugMode) {
    try {
      FirebaseFirestore.instance.useFirestoreEmulator('127.0.0.1', 8080);
      await FirebaseAuth.instance.useAuthEmulator('127.0.0.1', 9099);
      FirebaseStorage.instance.useStorageEmulator('127.0.0.1', 9199);
    } catch (e) {
      debugPrint('Emulator config failed: $e');
    }
  }

  runApp(const ProviderScope(child: OpiSuomeaAdminApp()));
}

// Config GoRouter with Authentication Guard
final _routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  final isAdmin = ref.watch(isAdminProvider);

  return GoRouter(
    initialLocation: '/dashboard',
    refreshListenable: Listenable.merge([
      // Re-trigger redirect when auth state changes
    ]),
    redirect: (context, state) {
      final loggingIn = state.matchedLocation == '/login';
      final isLoggedIn = authState.value != null;

      if (!isLoggedIn) {
        return loggingIn ? null : '/login';
      }

      if (isLoggedIn && !isAdmin && !loggingIn) {
        // This is a safety check: user is logged in but not admin
        return '/login';
      }

      if (isLoggedIn && isAdmin && loggingIn) {
        return '/dashboard';
      }

      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      ShellRoute(
        builder: (context, state, child) {
          // Wrapped in AdminLayout for authenticated users
          return AdminLayout(child: child);
        },
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const DashboardView(),
          ),
          GoRoute(
            path: '/activities',
            builder: (context, state) => const ActivityListScreen(),
          ),
          GoRoute(
            path: '/vocabulary',
            builder: (context, state) => const VocabularyListScreen(),
          ),
          GoRoute(
            path: '/lessons',
            builder: (context, state) => const LessonListScreen(),
            routes: [
              GoRoute(
                path: 'edit/:id',
                builder: (context, state) {
                  final id = state.pathParameters['id'];
                  return LessonEditScreen(lessonId: id == 'new' ? null : id);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/grammar',
            builder: (context, state) => const GrammarListScreen(),
          ),
          GoRoute(
            path: '/exercises',
            builder: (context, state) => const ExerciseListScreen(),
          ),
          GoRoute(
            path: '/study-plans',
            builder: (context, state) => const StudyPlanListScreen(),
            routes: [
              GoRoute(
                path: ':id',
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return StudyPlanDetailScreen(planId: id);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/students',
            builder: (context, state) => const StudentListScreen(),
          ),
        ],
      ),
    ],
  );
});

class OpiSuomeaAdminApp extends ConsumerWidget {
  const OpiSuomeaAdminApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(_routerProvider);

    return MaterialApp.router(
      title: 'Hoc Tieng Phan Admin CMS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2C3E50),
          primary: const Color(0xFF2C3E50),
        ),
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      routerConfig: router,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('vi', ''),
      ],
    );
  }
}
