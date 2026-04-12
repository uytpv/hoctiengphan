import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/grammar_repository.dart';
import '../../domain/grammar.dart';
import 'grammar_filter_provider.dart';

final filteredGrammarsProvider = Provider<AsyncValue<List<Grammar>>>((ref) {
  final grammarsAsync = ref.watch(grammarsStreamProvider);
  final filters = ref.watch(grammarFilterProvider);

  return grammarsAsync.whenData((grammars) {
    var filtered = [...grammars];

    if (filters.searchQuery.isNotEmpty) {
      final query = filters.searchQuery.toLowerCase();
      filtered = filtered.where((g) {
        return g.title.toLowerCase().contains(query);
      }).toList();
    }

    return filtered;
  });
});

final paginatedGrammarsProvider = Provider<AsyncValue<List<Grammar>>>((ref) {
  final filteredGrammarsAsync = ref.watch(filteredGrammarsProvider);
  final filters = ref.watch(grammarFilterProvider);

  return filteredGrammarsAsync.whenData((all) {
    int start = filters.pageIndex * filters.pageSize;
    if (start >= all.length) return [];

    int end = start + filters.pageSize;
    if (end > all.length) end = all.length;

    return all.sublist(start, end);
  });
});
