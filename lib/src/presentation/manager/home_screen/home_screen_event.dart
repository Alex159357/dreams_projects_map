abstract class HomeScreenEvent {}

class InitEvent extends HomeScreenEvent {
  final String loading;

  InitEvent(this.loading);
}

class OnLoadingPercentChanged extends HomeScreenEvent{
  final int percent;

  OnLoadingPercentChanged(this.percent);
}