import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/lesson_repository.dart';
import '../../domain/lesson.dart';
import 'lesson_filter_provider.dart';

final filteredLessonsProvider = Provider<AsyncValue<List<Lesson>>>((ref) {
  final lessonsAsync = ref.watch(lessonsStreamProvider);
  final filters = ref.watch(lessonFilterProvider);

  return lessonsAsync.whenData((lessons) {
    var filtered = [...lessons];

    // Search filter
    if (filters.searchQuery.isNotEmpty) {
      final query = filters.searchQuery.toLowerCase();
      filtered = filtered.where((l) {
        return l.title.toLowerCase().contains(query) ||
            (l.description?.toLowerCase().contains(query) ?? false);
      }).toList();
    }

    // Sort
    filtered.sort((a, b) {
      dynamic valA, valB;
      switch (filters.sortBy) {
        case 'title':
          valA = a.title;
          valB = b.title;
          break;
        default:
          valA = a.title;
          valB = b.title;
      }

      int cmp = (valA as String).compareTo(valB as String);
      return filters.ascending ? cmp : -cmp;
    });

    return filtered;
  });
});

final paginatedLessonsProvider = Provider<AsyncValue<List<Lesson>>>((ref) {
  final filteredLessonsAsync = ref.watch(filteredLessonsProvider);
  final filters = ref.watch(lessonFilterProvider);

  return filteredLessonsAsync.whenData((all) {
    int start = filters.pageIndex * filters.pageSize;
    if (start >= all.length) return [];

    int end = start + filters.pageSize;
    if (end > all.length) end = all.length;

    return all.sublist(start, end);
  });
});
