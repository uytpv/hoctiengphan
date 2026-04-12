import 'package:flutter_riverpod/flutter_riverpod.dart';

class LessonFilterState {
  final String searchQuery;
  final String sortBy;
  final bool ascending;
  final int pageIndex;
  final int pageSize;

  LessonFilterState({
    this.searchQuery = '',
    this.sortBy = 'title',
    this.ascending = true,
    this.pageIndex = 0,
    this.pageSize = 10,
  });

  LessonFilterState copyWith({
    String? searchQuery,
    String? sortBy,
    bool? ascending,
    int? pageIndex,
    int? pageSize,
  }) {
    return LessonFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      sortBy: sortBy ?? this.sortBy,
      ascending: ascending ?? this.ascending,
      pageIndex: pageIndex ?? this.pageIndex,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}

class LessonFilterNotifier extends Notifier<LessonFilterState> {
  @override
  LessonFilterState build() => LessonFilterState();

  void updateSearch(String query) =>
      state = state.copyWith(searchQuery: query, pageIndex: 0);

  void toggleSort(String column) {
    if (state.sortBy == column) {
      state = state.copyWith(ascending: !state.ascending, pageIndex: 0);
    } else {
      state = state.copyWith(sortBy: column, ascending: true, pageIndex: 0);
    }
  }

  void setPage(int index) => state = state.copyWith(pageIndex: index);
}

final lessonFilterProvider =
    NotifierProvider<LessonFilterNotifier, LessonFilterState>(
      LessonFilterNotifier.new,
    );
