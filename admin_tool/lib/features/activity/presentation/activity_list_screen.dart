import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_tool/features/activity/data/activity_repository.dart';
import 'package:admin_tool/features/activity/domain/activity.dart';
import 'package:admin_tool/features/activity/presentation/widgets/activity_form_dialog.dart';
import 'package:admin_tool/features/activity/presentation/providers/activity_filter_provider.dart';
import 'package:admin_tool/features/activity/presentation/providers/filtered_activities_provider.dart';

class ActivityListScreen extends ConsumerWidget {
  const ActivityListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activitiesAsync = ref.watch(paginatedActivitiesProvider);
    final allActivitiesAsync = ref.watch(filteredActivitiesProvider);
    final filters = ref.watch(activityFilterProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Activity List'),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ElevatedButton.icon(
              onPressed: () => _showFormDialog(context, null),
              icon: const Icon(Icons.add),
              label: const Text('ADD ACTIVITY'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent.shade700,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (val) =>
                  ref.read(activityFilterProvider.notifier).updateSearch(val),
              decoration: const InputDecoration(
                hintText: 'Search activity...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: activitiesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) => Center(child: Text('Error: $e')),
              data: (items) {
                final totalItems = allActivitiesAsync.value?.length ?? 0;
                final totalPages = (totalItems / filters.pageSize).ceil();

                if (items.isEmpty && filters.searchQuery.isEmpty) {
                  return const Center(child: Text('No activities found.'));
                }

                if (items.isEmpty && filters.searchQuery.isNotEmpty) {
                  return const Center(child: Text('No activities match search.'));
                }

                return Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: items.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return ListTile(
                            title: Text(
                              item.title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              '${item.type.name.toUpperCase()} | ID: ${item.id}',
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon:
                                      const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () =>
                                      _showFormDialog(context, item),
                                ),
                                IconButton(
                                  icon:
                                      const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () =>
                                      _confirmDelete(context, ref, item.id),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    _buildPagination(ref, filters, totalItems, totalPages),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPagination(
    WidgetRef ref,
    ActivityFilterState filters,
    int totalItems,
    int totalPages,
  ) {
    if (totalItems == 0) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total: $totalItems items',
            style: const TextStyle(color: Colors.grey),
          ),
          Row(
            children: [
              IconButton(
                onPressed: filters.pageIndex > 0
                    ? () => ref
                        .read(activityFilterProvider.notifier)
                        .setPage(filters.pageIndex - 1)
                    : null,
                icon: const Icon(Icons.chevron_left),
              ),
              Text('Page ${filters.pageIndex + 1} of $totalPages'),
              IconButton(
                onPressed: filters.pageIndex < totalPages - 1
                    ? () => ref
                        .read(activityFilterProvider.notifier)
                        .setPage(filters.pageIndex + 1)
                    : null,
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showFormDialog(BuildContext context, Activity? activity) {
    showDialog(
      context: context,
      builder: (context) => ActivityFormDialog(activity: activity),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Activity?'),
        content: const Text('Are you sure you want to delete this activity?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await ref.read(activityRepositoryProvider).deleteActivity(id);
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
