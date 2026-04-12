import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../data/exercise_repository.dart';

import 'providers/exercise_filter_provider.dart';
import 'providers/filtered_exercises_provider.dart';

class ExerciseListScreen extends ConsumerWidget {
  const ExerciseListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercisesAsync = ref.watch(paginatedExercisesProvider);
    final allExercisesAsync = ref.watch(filteredExercisesProvider);
    final filters = ref.watch(exerciseFilterProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Exercise List'),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ElevatedButton.icon(
              onPressed: () => context.go('/exercises/new'),
              icon: const Icon(Icons.add),
              label: const Text('ADD NEW EXERCISE'),
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
                  ref.read(exerciseFilterProvider.notifier).updateSearch(val),
              decoration: const InputDecoration(
                hintText: 'Search exercise...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: exercisesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) => Center(child: Text('Error: $e')),
              data: (items) {
                final totalItems = allExercisesAsync.value?.length ?? 0;
                final totalPages = (totalItems / filters.pageSize).ceil();

                if (items.isEmpty && filters.searchQuery.isEmpty) {
                  return const Center(child: Text('No exercises found.'));
                }

                if (items.isEmpty && filters.searchQuery.isNotEmpty) {
                  return const Center(child: Text('No exercises match search.'));
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
                            subtitle: Text('${item.type} | ID: ${item.id}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon:
                                      const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () =>
                                      context.go('/exercises/edit/${item.id}'),
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
    ExerciseFilterState filters,
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
                        .read(exerciseFilterProvider.notifier)
                        .setPage(filters.pageIndex - 1)
                    : null,
                icon: const Icon(Icons.chevron_left),
              ),
              Text('Page ${filters.pageIndex + 1} of $totalPages'),
              IconButton(
                onPressed: filters.pageIndex < totalPages - 1
                    ? () => ref
                        .read(exerciseFilterProvider.notifier)
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

  void _confirmDelete(BuildContext context, WidgetRef ref, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Exercise?'),
        content: const Text(
          'Are you sure you want to delete this exercise item? This will remove it from any linked lessons too.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await ref.read(exerciseRepositoryProvider).deleteExercise(id);
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
