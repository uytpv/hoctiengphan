import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivityFilterState {
  final String searchQuery;
  final int pageIndex;
  final int pageSize;

  ActivityFilterState({
    this.searchQuery = '',
    this.pageIndex = 0,
    this.pageSize = 10,
  });

  ActivityFilterState copyWith({
    String? searchQuery,
    int? pageIndex,
    int? pageSize,
  }) {
    return ActivityFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      pageIndex: pageIndex ?? this.pageIndex,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}

class ActivityFilterNotifier extends Notifier<ActivityFilterState> {
  @override
  ActivityFilterState build() => ActivityFilterState();

  void updateSearch(String query) =>
      state = state.copyWith(searchQuery: query, pageIndex: 0);
  void setPage(int index) => state = state.copyWith(pageIndex: index);
}

final activityFilterProvider =
    NotifierProvider<ActivityFilterNotifier, ActivityFilterState>(
      ActivityFilterNotifier.new,
    );
