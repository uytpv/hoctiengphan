import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/vocabulary.dart';
import '../../lesson/domain/lesson.dart';
import '../../lesson/data/lesson_repository.dart';

// Current active Filters/Sorting state
class VocabularyFilterState {
  final String searchQuery;
  final String? lessonId;
  final String? category;
  final String sortBy;
  final bool ascending;
  final int pageIndex;
  final int pageSize;

  VocabularyFilterState({
    this.searchQuery = '',
    this.lessonId,
    this.category,
    this.sortBy = 'finnish',
    this.ascending = true,
    this.pageIndex = 0,
    this.pageSize = 20,
  });

  VocabularyFilterState copyWith({
    String? searchQuery,
    String? lessonId,
    String? category,
    String? sortBy,
    bool? ascending,
    int? pageIndex,
    int? pageSize,
  }) {
    return VocabularyFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      lessonId: lessonId == '' ? null : (lessonId ?? this.lessonId),
      category: category == '' ? null : (category ?? this.category),
      sortBy: sortBy ?? this.sortBy,
      ascending: ascending ?? this.ascending,
      pageIndex: pageIndex ?? this.pageIndex,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}

class VocabularyFilterNotifier extends Notifier<VocabularyFilterState> {
  @override
  VocabularyFilterState build() => VocabularyFilterState();

  void updateSearch(String query) => state = state.copyWith(searchQuery: query, pageIndex: 0);
  void updateLesson(String? id) => state = state.copyWith(lessonId: id ?? '', pageIndex: 0);
  void updateCategory(String? categoryName) => state = state.copyWith(category: categoryName ?? '', pageIndex: 0);
  void toggleSort(String column) {
    if (state.sortBy == column) {
      state = state.copyWith(ascending: !state.ascending);
    } else {
      state = state.copyWith(sortBy: column, ascending: true);
    }
  }
  void setPage(int index) => state = state.copyWith(pageIndex: index);
}

final vocabularyFilterProvider = NotifierProvider<VocabularyFilterNotifier, VocabularyFilterState>(VocabularyFilterNotifier.new);

// Fetch all Lessons for Select dropdown
// We now use the lessonsStreamProvider from the lesson feature
// But for compatibility with existing UI that expects FutureProvider<List<Lesson>>
// we can keep the name but wrap the stream.
final lessonsProvider = Provider<AsyncValue<List<Lesson>>>((ref) {
  return ref.watch(lessonsStreamProvider);
});

// Main Vocabulary stream/future with filtering
final vocabularyListProvider = FutureProvider<List<Vocabulary>>((ref) async {
  final filters = ref.watch(vocabularyFilterProvider);
  
  Query query = FirebaseFirestore.instance.collection('vocabularies');
  
  // Only apply firestore filter if targeting a specific ID
  if (filters.lessonId != null && filters.lessonId != 'unknown') {
    query = query.where('lessonId', isEqualTo: filters.lessonId);
  }

  // Firestore get
  final snapshot = await query.get();
  var list = snapshot.docs.map(Vocabulary.fromFirestore).toList();

  // In-memory filter: Unknown lesson
  if (filters.lessonId == 'unknown') {
    list = list.where((v) => v.lessonId == null || v.lessonId!.isEmpty).toList();
  }

  // In-memory filter: Search
  if (filters.searchQuery.isNotEmpty) {
    final search = filters.searchQuery.toLowerCase();
    list = list.where((v) {
      return v.finnish.toLowerCase().contains(search) || 
             v.vietnamese.toLowerCase().contains(search) ||
             v.english.toLowerCase().contains(search);
    }).toList();
  }

  // In-memory filter: Category (String equals)
  if (filters.category != null) {
    list = list.where((v) => v.category == filters.category).toList();
  }

  // Sort
  list.sort((a, b) {
    dynamic valA, valB;
    switch (filters.sortBy) {
      case 'finnish': valA = a.finnish; valB = b.finnish; break;
      case 'vietnamese': valA = a.vietnamese; valB = b.vietnamese; break;
      case 'english': valA = a.english; valB = b.english; break;
      case 'category': valA = a.category ?? ''; valB = b.category ?? ''; break;
      case 'lesson': valA = a.lessonId ?? ''; valB = b.lessonId ?? ''; break;
      default: valA = a.finnish; valB = b.finnish;
    }
    
    int cmp = (valA as String).compareTo(valB as String);
    return filters.ascending ? cmp : -cmp;
  });

  return list;
});

// Paginated view of the list
final paginatedVocabProvider = Provider<List<Vocabulary>>((ref) {
  final all = ref.watch(vocabularyListProvider).value ?? [];
  final filters = ref.watch(vocabularyFilterProvider);
  
  int start = filters.pageIndex * filters.pageSize;
  if (start >= all.length) return [];
  
  int end = start + filters.pageSize;
  if (end > all.length) end = all.length;
  
  return all.sublist(start, end);
});
