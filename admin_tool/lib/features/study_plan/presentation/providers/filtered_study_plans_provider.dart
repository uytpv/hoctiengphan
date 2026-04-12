import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/study_plan_repository.dart';
import '../../domain/study_plan.dart';
import 'study_plan_filter_provider.dart';

final filteredStudyPlansProvider = Provider<AsyncValue<List<StudyPlan>>>((ref) {
  final plansAsync = ref.watch(studyPlansStreamProvider);
  final filters = ref.watch(studyPlanFilterProvider);

  return plansAsync.whenData((plans) {
    var filtered = [...plans];

    if (filters.searchQuery.isNotEmpty) {
      final query = filters.searchQuery.toLowerCase();
      filtered = filtered.where((p) {
        return p.title.toLowerCase().contains(query) ||
            p.description.toLowerCase().contains(query);
      }).toList();
    }

    return filtered;
  });
});

final paginatedStudyPlansProvider = Provider<AsyncValue<List<StudyPlan>>>((ref) {
  final filteredPlansAsync = ref.watch(filteredStudyPlansProvider);
  final filters = ref.watch(studyPlanFilterProvider);

  return filteredPlansAsync.whenData((all) {
    int start = filters.pageIndex * filters.pageSize;
    if (start >= all.length) return [];

    int end = start + filters.pageSize;
    if (end > all.length) end = all.length;

    return all.sublist(start, end);
  });
});
