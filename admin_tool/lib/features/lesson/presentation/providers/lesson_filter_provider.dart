import 'package:flutter_riverpod/flutter_riverpod.dart';

class LessonFilterState {
  final String searchQuery;
  final String sortBy;
  final bool ascending;

  LessonFilterState({
    this.searchQuery = '',
    this.sortBy = 'title',
    this.ascending = true,
  });

  LessonFilterState copyWith({
    String? searchQuery,
    String? sortBy,
    bool? ascending,
  }) {
    return LessonFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      sortBy: sortBy ?? this.sortBy,
      ascending: ascending ?? this.ascending,
    );
  }
}

class LessonFilterNotifier extends Notifier<LessonFilterState> {
  @override
  LessonFilterState build() => LessonFilterState();

  void updateSearch(String query) => state = state.copyWith(searchQuery: query);

  void toggleSort(String column) {
    if (state.sortBy == column) {
      state = state.copyWith(ascending: !state.ascending);
    } else {
      state = state.copyWith(sortBy: column, ascending: true);
    }
  }
}

final lessonFilterProvider =
    NotifierProvider<LessonFilterNotifier, LessonFilterState>(
      LessonFilterNotifier.new,
    );
