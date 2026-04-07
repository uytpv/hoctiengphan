import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/vocabulary_provider.dart';
import '../models/vocabulary.dart';
import '../repositories/vocabulary_repository.dart';
import '../../lesson/domain/lesson.dart';
import 'widgets/vocabulary_form_dialog.dart';

class VocabularyListScreen extends ConsumerWidget {
  const VocabularyListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(vocabularyFilterProvider);
    final allItems = ref.watch(vocabularyListProvider).value ?? [];
    final items = ref.watch(paginatedVocabProvider);
    final lessons = ref.watch(lessonsProvider).value ?? [];

    final totalPages = (allItems.length / filters.pageSize).ceil();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Vocabulary Management',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => ref.invalidate(vocabularyListProvider),
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh Data',
          ),
          const SizedBox(width: 16),
          ElevatedButton.icon(
            onPressed: () => _openForm(context),
            icon: const Icon(Icons.add),
            label: const Text('Add Vocabulary'),
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
          _buildFilterBar(context, ref, filters, lessons),

          // List
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Card(
                elevation: 4,
                shadowColor: Colors.black12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildTable(context, ref, items, filters, lessons),
                    _buildPagination(ref, filters, allItems.length, totalPages),
                  ],
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
    VocabularyFilterState filters,
    List lessons,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: Colors.blueGrey.shade50,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: TextField(
              onChanged: (val) =>
                  ref.read(vocabularyFilterProvider.notifier).updateSearch(val),
              decoration: InputDecoration(
                hintText: 'Search word or translation...',
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
          Expanded(
            child: DropdownButtonFormField<String>(
              value: filters.lessonId,
              decoration: InputDecoration(
                labelText: 'Filter by Lesson',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              items: [
                const DropdownMenuItem(value: null, child: Text('All Lessons')),
                const DropdownMenuItem(
                  value: 'unknown',
                  child: Text('Unknown (No Lesson)'),
                ),
                ...lessons.map(
                  (l) => DropdownMenuItem(
                    value: l.id,
                    child: Text(l.title, overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
              onChanged: (val) =>
                  ref.read(vocabularyFilterProvider.notifier).updateLesson(val),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              onChanged: (val) => ref
                  .read(vocabularyFilterProvider.notifier)
                  .updateCategory(val),
              decoration: InputDecoration(
                labelText: 'Filter by Category',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTable(
    BuildContext context,
    WidgetRef ref,
    List<Vocabulary> items,
    VocabularyFilterState filters,
    List lessons,
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
            DataColumn(label: const Text('Image')),
            DataColumn(
              label: const Row(
                children: [Text('Finnish'), Icon(Icons.sort, size: 16)],
              ),
              onSort: (index, ascending) => ref
                  .read(vocabularyFilterProvider.notifier)
                  .toggleSort('finnish'),
            ),
            DataColumn(label: const Text('Phiên âm')),
            DataColumn(
              label: const Row(
                children: [Text('Vietnamese'), Icon(Icons.sort, size: 16)],
              ),
              onSort: (index, ascending) => ref
                  .read(vocabularyFilterProvider.notifier)
                  .toggleSort('vietnamese'),
            ),
            DataColumn(
              label: const Row(
                children: [Text('English'), Icon(Icons.sort, size: 16)],
              ),
              onSort: (index, ascending) => ref
                  .read(vocabularyFilterProvider.notifier)
                  .toggleSort('english'),
            ),
            DataColumn(label: const Text('Lesson')),
            DataColumn(label: const Text('Category')),
            DataColumn(label: const Text('Actions')),
          ],
          rows: items.map((voc) {
            final lesson = lessons
                .where((l) => l.id == voc.lessonId)
                .firstOrNull;

            return DataRow(
              cells: [
                DataCell(
                  voc.imageUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            voc.imageUrl!,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, s) =>
                                const Icon(Icons.broken_image),
                          ),
                        )
                      : const Icon(
                          Icons.image_not_supported,
                          color: Colors.grey,
                        ),
                ),
                DataCell(
                  SizedBox(
                    width: 150,
                    child: Text(
                      voc.finnish,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                DataCell(
                  SizedBox(
                    width: 120,
                    child: Text(
                      voc.pronunciation ?? '',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                DataCell(
                  SizedBox(
                    width: 150,
                    child: Text(
                      voc.vietnamese,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                DataCell(
                  SizedBox(
                    width: 150,
                    child: Text(voc.english, overflow: TextOverflow.ellipsis),
                  ),
                ),
                DataCell(
                  SizedBox(
                    width: 150,
                    child: Text(
                      lesson?.title ?? 'Unknown',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                DataCell(
                  SizedBox(
                    width: 100,
                    child: Text(
                      voc.category ?? '-',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                DataCell(
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.volume_up,
                          color: Colors.green,
                          size: 18,
                        ),
                        onPressed: () {
                          // TODO: Implement audio playback using voc.audioUrl
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Audio playback not implemented yet',
                              ),
                            ),
                          );
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        tooltip: 'Listen',
                      ),
                      const SizedBox(width: 4),
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                          size: 18,
                        ),
                        onPressed: () => _openForm(context, vocabulary: voc),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: 4),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 18,
                        ),
                        onPressed: () => _confirmDelete(context, ref, voc),
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

  Widget _buildPagination(
    WidgetRef ref,
    VocabularyFilterState filters,
    int totalItems,
    int totalPages,
  ) {
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
                          .read(vocabularyFilterProvider.notifier)
                          .setPage(filters.pageIndex - 1)
                    : null,
                icon: const Icon(Icons.chevron_left),
              ),
              Text('Page ${filters.pageIndex + 1} of $totalPages'),
              IconButton(
                onPressed: filters.pageIndex < totalPages - 1
                    ? () => ref
                          .read(vocabularyFilterProvider.notifier)
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

  Future<void> _openForm(BuildContext context, {Vocabulary? vocabulary}) async {
    showDialog(
      context: context,
      builder: (context) => VocabularyFormDialog(vocabulary: vocabulary),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    Vocabulary voc,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Vocabulary'),
        content: Text('Are you sure you want to delete "${voc.finnish}"?'),
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
      await ref.read(vocabularyRepositoryProvider).deleteVocabulary(voc.id);
      ref.invalidate(vocabularyListProvider);
    }
  }
}
