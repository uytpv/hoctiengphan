import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentFilterState {
  final String searchQuery;
  final int pageIndex;
  final int pageSize;

  StudentFilterState({
    this.searchQuery = '',
    this.pageIndex = 0,
    this.pageSize = 10,
  });

  StudentFilterState copyWith({
    String? searchQuery,
    int? pageIndex,
    int? pageSize,
  }) {
    return StudentFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      pageIndex: pageIndex ?? this.pageIndex,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}

class StudentFilterNotifier extends Notifier<StudentFilterState> {
  @override
  StudentFilterState build() => StudentFilterState();

  void updateSearch(String query) =>
      state = state.copyWith(searchQuery: query, pageIndex: 0);
  void setPage(int index) => state = state.copyWith(pageIndex: index);
}

final studentFilterProvider =
    NotifierProvider<StudentFilterNotifier, StudentFilterState>(
      StudentFilterNotifier.new,
    );
