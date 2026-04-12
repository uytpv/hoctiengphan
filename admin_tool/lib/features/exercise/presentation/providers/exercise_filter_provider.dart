import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExerciseFilterState {
  final String searchQuery;
  final int pageIndex;
  final int pageSize;

  ExerciseFilterState({
    this.searchQuery = '',
    this.pageIndex = 0,
    this.pageSize = 10,
  });

  ExerciseFilterState copyWith({
    String? searchQuery,
    int? pageIndex,
    int? pageSize,
  }) {
    return ExerciseFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      pageIndex: pageIndex ?? this.pageIndex,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}

class ExerciseFilterNotifier extends Notifier<ExerciseFilterState> {
  @override
  ExerciseFilterState build() => ExerciseFilterState();

  void updateSearch(String query) =>
      state = state.copyWith(searchQuery: query, pageIndex: 0);
  void setPage(int index) => state = state.copyWith(pageIndex: index);
}

final exerciseFilterProvider =
    NotifierProvider<ExerciseFilterNotifier, ExerciseFilterState>(
      ExerciseFilterNotifier.new,
    );
