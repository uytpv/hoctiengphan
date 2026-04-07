import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/lesson.dart';
import '../data/lesson_repository.dart';
import 'providers/filtered_lessons_provider.dart';
import 'providers/lesson_filter_provider.dart';
import 'package:go_router/go_router.dart'; // Added this

class LessonListScreen extends ConsumerWidget {
  const LessonListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonsAsync = ref.watch(filteredLessonsProvider);
    final filters = ref.watch(lessonFilterProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Lesson Management',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => ref.invalidate(lessonsStreamProvider),
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh Data',
          ),
          const SizedBox(width: 16),
          ElevatedButton.icon(
            onPressed: () => _openForm(context),
            icon: const Icon(Icons.add),
            label: const Text('Add Lesson'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueGrey.shade800,
              foregroundColor: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // Filter Bar
          _buildFilterBar(context, ref, filters),

          // List
          Expanded(
            child: lessonsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
              data: (items) => SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Card(
                  elevation: 4,
                  shadowColor: Colors.black12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _buildTable(context, ref, items, filters),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar(
    BuildContext context,
    WidgetRef ref,
    LessonFilterState filters,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: Colors.blueGrey.shade50,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (val) =>
                  ref.read(lessonFilterProvider.notifier).updateSearch(val),
              decoration: InputDecoration(
                hintText: 'Search title, chapter, display...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Additional space for alignment
          const Spacer(flex: 2),
        ],
      ),
    );
  }

  Widget _buildTable(
    BuildContext context,
    WidgetRef ref,
    List<Lesson> items,
    LessonFilterState filters,
  ) {
    if (items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(50),
        child: Center(
          child: Text(
            'No results found.',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 24,
          headingTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
          columns: [
            DataColumn(
              label: const Row(
                children: [Text('Title'), Icon(Icons.sort, size: 16)],
              ),
              onSort: (index, ascending) =>
                  ref.read(lessonFilterProvider.notifier).toggleSort('title'),
            ),
            DataColumn(label: const Text('Description')),
            DataColumn(label: const Text('Actions')),
          ],
          rows: items.map((lesson) {
            return DataRow(
              cells: [
                DataCell(
                  SizedBox(
                    width: 200,
                    child: Text(
                      lesson.title,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                DataCell(
                  SizedBox(
                    width: 500,
                    child: Text(
                      lesson.description ?? '-',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ),
                DataCell(
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                          size: 18,
                        ),
                        onPressed: () => _openForm(context, lesson: lesson),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 18,
                        ),
                        onPressed: () => _confirmDelete(context, ref, lesson),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  void _openForm(BuildContext context, {Lesson? lesson}) {
    final id = lesson?.id ?? 'new';
    context.push('/lessons/edit/$id');
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    Lesson lesson,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Lesson'),
        content: Text('Are you sure you want to delete "${lesson.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(lessonRepositoryProvider).deleteLesson(lesson.id);
    }
  }
}
