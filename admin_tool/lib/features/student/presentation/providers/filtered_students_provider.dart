import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/user_repository.dart';
import '../../domain/user_progress.dart';
import 'student_filter_provider.dart';

final filteredStudentsProvider = Provider<AsyncValue<List<UserProfile>>>((ref) {
  final usersAsync = ref.watch(usersStreamProvider);
  final filters = ref.watch(studentFilterProvider);

  return usersAsync.whenData((users) {
    var filtered = [...users];

    if (filters.searchQuery.isNotEmpty) {
      final query = filters.searchQuery.toLowerCase();
      filtered = filtered.where((u) {
        return (u.displayName.toLowerCase().contains(query)) ||
            (u.email?.toLowerCase().contains(query) ?? false);
      }).toList();
    }

    return filtered;
  });
});

final paginatedStudentsProvider = Provider<AsyncValue<List<UserProfile>>>((ref) {
  final filteredStudentsAsync = ref.watch(filteredStudentsProvider);
  final filters = ref.watch(studentFilterProvider);

  return filteredStudentsAsync.whenData((all) {
    int start = filters.pageIndex * filters.pageSize;
    if (start >= all.length) return [];

    int end = start + filters.pageSize;
    if (end > all.length) end = all.length;

    return all.sublist(start, end);
  });
});
