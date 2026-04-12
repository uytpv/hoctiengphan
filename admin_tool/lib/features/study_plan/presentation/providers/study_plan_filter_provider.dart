import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudyPlanFilterState {
  final String searchQuery;
  final int pageIndex;
  final int pageSize;

  StudyPlanFilterState({
    this.searchQuery = '',
    this.pageIndex = 0,
    this.pageSize = 10,
  });

  StudyPlanFilterState copyWith({
    String? searchQuery,
    int? pageIndex,
    int? pageSize,
  }) {
    return StudyPlanFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      pageIndex: pageIndex ?? this.pageIndex,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}

class StudyPlanFilterNotifier extends Notifier<StudyPlanFilterState> {
  @override
  StudyPlanFilterState build() => StudyPlanFilterState();

  void updateSearch(String query) =>
      state = state.copyWith(searchQuery: query, pageIndex: 0);
  void setPage(int index) => state = state.copyWith(pageIndex: index);
}

final studyPlanFilterProvider =
    NotifierProvider<StudyPlanFilterNotifier, StudyPlanFilterState>(
      StudyPlanFilterNotifier.new,
    );
