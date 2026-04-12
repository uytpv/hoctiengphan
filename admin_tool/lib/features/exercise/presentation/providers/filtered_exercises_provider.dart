import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/exercise_repository.dart';
import '../../domain/exercise.dart';
import 'exercise_filter_provider.dart';

final filteredExercisesProvider = Provider<AsyncValue<List<Exercise>>>((ref) {
  final exercisesAsync = ref.watch(exercisesStreamProvider);
  final filters = ref.watch(exerciseFilterProvider);

  return exercisesAsync.whenData((exercises) {
    var filtered = [...exercises];

    if (filters.searchQuery.isNotEmpty) {
      final query = filters.searchQuery.toLowerCase();
      filtered = filtered.where((ex) {
        return ex.title.toLowerCase().contains(query);
      }).toList();
    }

    return filtered;
  });
});

final paginatedExercisesProvider = Provider<AsyncValue<List<Exercise>>>((ref) {
  final filteredExercisesAsync = ref.watch(filteredExercisesProvider);
  final filters = ref.watch(exerciseFilterProvider);

  return filteredExercisesAsync.whenData((all) {
    int start = filters.pageIndex * filters.pageSize;
    if (start >= all.length) return [];

    int end = start + filters.pageSize;
    if (end > all.length) end = all.length;

    return all.sublist(start, end);
  });
});
