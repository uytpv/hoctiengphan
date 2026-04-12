import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/grammar_repository.dart';
import '../domain/grammar.dart';
import 'widgets/grammar_form_dialog.dart';

import 'providers/grammar_filter_provider.dart';
import 'providers/filtered_grammars_provider.dart';

class GrammarListScreen extends ConsumerWidget {
  const GrammarListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final grammarAsync = ref.watch(paginatedGrammarsProvider);
    final allGrammarAsync = ref.watch(filteredGrammarsProvider);
    final filters = ref.watch(grammarFilterProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Grammar List'),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ElevatedButton.icon(
              onPressed: () => _showFormDialog(context, null),
              icon: const Icon(Icons.add),
              label: const Text('ADD NEW GRAMMAR'),
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
                  ref.read(grammarFilterProvider.notifier).updateSearch(val),
              decoration: const InputDecoration(
                hintText: 'Search grammar...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: grammarAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) => Center(child: Text('Error: $e')),
              data: (items) {
                final totalItems = allGrammarAsync.value?.length ?? 0;
                final totalPages = (totalItems / filters.pageSize).ceil();

                if (items.isEmpty && filters.searchQuery.isEmpty) {
                  return const Center(child: Text('No grammar items found.'));
                }

                if (items.isEmpty && filters.searchQuery.isNotEmpty) {
                  return const Center(child: Text('No grammar match search.'));
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
                            subtitle: Text('ID: ${item.id}'),
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
    GrammarFilterState filters,
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
                        .read(grammarFilterProvider.notifier)
                        .setPage(filters.pageIndex - 1)
                    : null,
                icon: const Icon(Icons.chevron_left),
              ),
              Text('Page ${filters.pageIndex + 1} of $totalPages'),
              IconButton(
                onPressed: filters.pageIndex < totalPages - 1
                    ? () => ref
                        .read(grammarFilterProvider.notifier)
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

  void _showFormDialog(BuildContext context, Grammar? grammar) {
    showDialog(
      context: context,
      builder: (context) => GrammarFormDialog(grammar: grammar),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Grammar?'),
        content: const Text(
          'Are you sure you want to delete this grammar item? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await ref.read(grammarRepositoryProvider).deleteGrammar(id);
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

