import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchFilterViewModelProvider = StateNotifierProvider<SearchFilterViewModel, SearchFilterState>((ref) {
  return SearchFilterViewModel();
});

class SearchFilterState {
  final String searchQuery;
  final String filter;

  SearchFilterState({this.searchQuery = '', this.filter = 'All'});

  SearchFilterState copyWith({String? searchQuery, String? filter}) {
    return SearchFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      filter: filter ?? this.filter,
    );
  }
}

class SearchFilterViewModel extends StateNotifier<SearchFilterState> {
  SearchFilterViewModel() : super(SearchFilterState());

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void setFilter(String filter) {
    state = state.copyWith(filter: filter);
  }
}