import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/activity_repository.dart';
import '../../domain/activity.dart';
import 'activity_filter_provider.dart';

final filteredActivitiesProvider = Provider<AsyncValue<List<Activity>>>((ref) {
  final activitiesAsync = ref.watch(activitiesStreamProvider);
  final filters = ref.watch(activityFilterProvider);

  return activitiesAsync.whenData((activities) {
    var filtered = [...activities];

    if (filters.searchQuery.isNotEmpty) {
      final query = filters.searchQuery.toLowerCase();
      filtered = filtered.where((a) {
        return a.title.toLowerCase().contains(query);
      }).toList();
    }

    return filtered;
  });
});

final paginatedActivitiesProvider = Provider<AsyncValue<List<Activity>>>((ref) {
  final filteredActivitiesAsync = ref.watch(filteredActivitiesProvider);
  final filters = ref.watch(activityFilterProvider);

  return filteredActivitiesAsync.whenData((all) {
    int start = filters.pageIndex * filters.pageSize;
    if (start >= all.length) return [];

    int end = start + filters.pageSize;
    if (end > all.length) end = all.length;

    return all.sublist(start, end);
  });
});
