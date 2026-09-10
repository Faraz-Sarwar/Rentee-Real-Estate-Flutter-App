class DataState {
  bool isLoading;
  String? error;
  DataState({this.isLoading = false, this.error});

  DataState copyWith({bool? isLoading, String? error}) {
    return DataState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
