class HomeScreenState {

  final bool loading;
  final int percent;

  HomeScreenState({this.loading = true, this.percent = 0});

  HomeScreenState init() {
    return HomeScreenState();
  }

  HomeScreenState clone({bool? loading, int? percent}) {
    return HomeScreenState(loading: loading ?? this.loading, percent: percent ?? this.percent);
  }
}
