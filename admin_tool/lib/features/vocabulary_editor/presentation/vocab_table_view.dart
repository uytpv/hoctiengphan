import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/vocabulary_repository.dart';
import '../../lesson/data/lesson_repository.dart';
import '../domain/vocabulary.dart';
import '../../lesson/domain/lesson.dart';

class VocabTableView extends ConsumerStatefulWidget {
  const VocabTableView({super.key});

  @override
  ConsumerState<VocabTableView> createState() => _VocabTableViewState();
}

class _VocabTableViewState extends ConsumerState<VocabTableView> {
  int rowsPerPage = 10;

  @override
  Widget build(BuildContext context) {
    final vocabulariesAsync = ref.watch(vocabulariesStreamProvider);
    final lessonsAsync = ref.watch(lessonsStreamProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Vocabulary Editor',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // Open Dialog logic here
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Word'),
            )
          ],
        ),
        const SizedBox(height: 24),
        Expanded(
          child: Card(
            elevation: 2,
            child: vocabulariesAsync.when(
              data: (vocabularies) {
                if (vocabularies.isEmpty) {
                  return const Center(child: Text('No vocabulary words found.'));
                }
                final dataSource = VocabDataSource(vocabularies, lessonsAsync, ref);

                return SingleChildScrollView(
                  child: PaginatedDataTable(
                    source: dataSource,
                    columns: const [
                      DataColumn(label: Text('Finnish')),
                      DataColumn(label: Text('Pronunciation')),
                      DataColumn(label: Text('Vietnamese')),
                      DataColumn(label: Text('English')),
                      DataColumn(label: Text('Lesson')),
                      DataColumn(label: Text('Actions')),
                    ],
                    rowsPerPage: rowsPerPage,
                    availableRowsPerPage: const [10, 20, 50, 100],
                    onRowsPerPageChanged: (value) {
                      if (value != null) {
                        setState(() {
                          rowsPerPage = value;
                        });
                      }
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ),
        )
      ],
    );
  }
}

class VocabDataSource extends DataTableSource {
  final List<Vocabulary> vocabularies;
  final AsyncValue<List<Lesson>> lessonsAsync;
  final WidgetRef ref;

  VocabDataSource(this.vocabularies, this.lessonsAsync, this.ref);

  @override
  DataRow? getRow(int index) {
    if (index >= vocabularies.length) return null;
    final vocab = vocabularies[index];
    
    return DataRow(cells: [
      DataCell(Text(vocab.finnish)),
      DataCell(Text(vocab.pronunciation ?? '')),
      DataCell(Text(vocab.vietnamese)),
      DataCell(Text(vocab.english ?? '')),
      DataCell(
        lessonsAsync.when(
          data: (lessons) {
            final lesson = lessons.where((l) => l.id == vocab.lessonId).firstOrNull;
            return Text(lesson?.title ?? vocab.lessonId);
          },
          loading: () => const Text('Loading...'),
          error: (_, __) => const Text('Error'),
        ),
      ),
      DataCell(
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                // Edit logic here
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                ref.read(vocabularyRepositoryProvider).deleteVocabulary(vocab.id);
              },
            ),
          ],
        ),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => vocabularies.length;

  @override
  int get selectedRowCount => 0;
}
