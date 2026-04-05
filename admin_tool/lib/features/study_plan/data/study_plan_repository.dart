import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_tool/features/study_plan/domain/study_plan.dart';

class StudyPlanRepository {
  final FirebaseFirestore _firestore;

  StudyPlanRepository(this._firestore);

  CollectionReference<StudyPlan> get _planCollection =>
      _firestore.collection('study_plans').withConverter<StudyPlan>(
            fromFirestore: (snapshot, _) => StudyPlan.fromJson(snapshot.data()!..['id'] = snapshot.id),
            toFirestore: (plan, _) => plan.toJson()..remove('id'),
          );

  CollectionReference<StudyPlanWeek> get _weekCollection =>
      _firestore.collection('study_plan_weeks').withConverter<StudyPlanWeek>(
            fromFirestore: (snapshot, _) => StudyPlanWeek.fromJson(snapshot.data()!..['id'] = snapshot.id),
            toFirestore: (week, _) => week.toJson()..remove('id'),
          );

  // Plans CRUD
  Future<String> createPlan(StudyPlan plan) async {
    final docRef = await _planCollection.add(plan);
    return docRef.id;
  }

  Future<void> updatePlan(StudyPlan plan) => _planCollection.doc(plan.id).set(plan);

  Future<void> deletePlan(String id) => _planCollection.doc(id).delete();

  Stream<List<StudyPlan>> getPlans() =>
      _planCollection.snapshots().map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

  // Weeks CRUD
  Future<void> createWeek(StudyPlanWeek week) => _weekCollection.add(week);

  Future<void> updateWeek(StudyPlanWeek week) => _weekCollection.doc(week.id).set(week);

  Future<void> deleteWeek(String id) => _weekCollection.doc(id).delete();

  Stream<List<StudyPlanWeek>> getWeeksForPlan(String planId) =>
      _weekCollection.where('planId', isEqualTo: planId).orderBy('weekNumber').snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => doc.data()).toList());
  
  Future<List<StudyPlanWeek>> getWeeksForPlanOnce(String planId) async {
    final snapshot = await _weekCollection.where('planId', isEqualTo: planId).orderBy('weekNumber').get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}

final studyPlanRepositoryProvider = Provider((ref) => StudyPlanRepository(FirebaseFirestore.instance));

final studyPlansStreamProvider = StreamProvider<List<StudyPlan>>((ref) {
  return ref.watch(studyPlanRepositoryProvider).getPlans();
});
