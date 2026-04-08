import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/study_plan.dart';

class StudyPlanRepository {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String? get _uid => _auth.currentUser?.uid;

  // Fetch all study plans
  Stream<List<StudyPlan>> watchStudyPlans() {
    return _db.collection('study_plans').snapshots().map(
          (snap) => snap.docs.map(StudyPlan.fromDoc).toList(),
        );
  }

  // Fetch weeks for a plan
  Stream<List<StudyPlanWeek>> watchWeeks(String planId) {
    return _db
        .collection('study_plan_weeks')
        .where('planId', isEqualTo: planId)
        .orderBy('weekNumber')
        .snapshots()
        .map(
          (snap) => snap.docs
              .map(StudyPlanWeek.fromDoc)
              .toList(),
        );
  }

  // Get a single plan
  Future<StudyPlan?> getPlan(String planId) async {
    final doc =
        await _db.collection('study_plans').doc(planId).get();
    if (!doc.exists) return null;
    return StudyPlan.fromDoc(doc);
  }

  /// Load Activity documents by their IDs from the activities collection
  Future<List<Activity>> getActivitiesByIds(
      List<String> ids) async {
    if (ids.isEmpty) return [];
    // Firestore 'whereIn' supports max 30 per query
    final chunks = <List<String>>[];
    for (var i = 0; i < ids.length; i += 30) {
      chunks.add(
          ids.sublist(i, i + 30 > ids.length ? ids.length : i + 30));
    }
    final results = <Activity>[];
    for (final chunk in chunks) {
      final snap = await _db
          .collection('activities')
          .where(FieldPath.documentId, whereIn: chunk)
          .get();
      results.addAll(snap.docs.map(Activity.fromDoc));
    }
    // Preserve original order from ids
    final byId = {for (final a in results) a.id: a};
    return ids
        .map((id) => byId[id])
        .whereType<Activity>()
        .toList();
  }

  /// Load a week with its days' activities resolved
  Future<StudyPlanWeek> resolveWeekActivities(
      StudyPlanWeek week) async {
    final resolvedDays = <Day>[];
    for (final day in week.days) {
      if (day.activityIds.isEmpty) {
        resolvedDays.add(day);
      } else {
        final acts =
            await getActivitiesByIds(day.activityIds);
        resolvedDays.add(day.copyWith(activities: acts));
      }
    }
    return week.copyWith(days: resolvedDays);
  }

  /// Mark an activity as done and update user progress in Firestore
  Future<void> markActivityDone({
    required String planId,
    required String weekId,
    required String dayId,
    required String activityId,
  }) async {
    if (_uid == null) return;

    final progressRef = _db
        .collection('user_progress')
        .doc(_uid)
        .collection('plans')
        .doc(planId);

    await progressRef.set(
      {
        'activities': {
          activityId: {
            'status': 'done',
            'completedAt': FieldValue.serverTimestamp(),
          }
        },
        'updatedAt': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );
  }

  /// Load user progress for a plan
  Future<Map<String, String>> getUserProgress(String planId) async {
    if (_uid == null) return {};

    final doc = await _db
        .collection('user_progress')
        .doc(_uid)
        .collection('plans')
        .doc(planId)
        .get();

    if (!doc.exists) return {};

    final data = doc.data() ?? {};
    final activities =
        (data['activities'] as Map<String, dynamic>?) ?? {};
    return activities.map(
      (key, value) => MapEntry(
          key,
          (value as Map<String, dynamic>)['status'] as String? ??
              'todo'),
    );
  }
}

final studyPlanRepositoryProvider =
    Provider((_) => StudyPlanRepository());

final studyPlansProvider =
    StreamProvider<List<StudyPlan>>((ref) {
  return ref.read(studyPlanRepositoryProvider).watchStudyPlans();
});

final weekListProvider =
    StreamProvider.family<List<StudyPlanWeek>, String>(
        (ref, planId) {
  return ref
      .read(studyPlanRepositoryProvider)
      .watchWeeks(planId);
});

/// Provider that loads a week with all activity details resolved
final resolvedWeekProvider =
    FutureProvider.family<StudyPlanWeek, StudyPlanWeek>(
        (ref, week) {
  return ref
      .read(studyPlanRepositoryProvider)
      .resolveWeekActivities(week);
});
