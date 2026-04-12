import 'package:flutter_riverpod/flutter_riverpod.dart';

class GrammarFilterState {
  final String searchQuery;
  final int pageIndex;
  final int pageSize;

  GrammarFilterState({
    this.searchQuery = '',
    this.pageIndex = 0,
    this.pageSize = 10,
  });

  GrammarFilterState copyWith({
    String? searchQuery,
    int? pageIndex,
    int? pageSize,
  }) {
    return GrammarFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      pageIndex: pageIndex ?? this.pageIndex,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}

class GrammarFilterNotifier extends Notifier<GrammarFilterState> {
  @override
  GrammarFilterState build() => GrammarFilterState();

  void updateSearch(String query) =>
      state = state.copyWith(searchQuery: query, pageIndex: 0);
  void setPage(int index) => state = state.copyWith(pageIndex: index);
}

final grammarFilterProvider =
    NotifierProvider<GrammarFilterNotifier, GrammarFilterState>(
      GrammarFilterNotifier.new,
    );
