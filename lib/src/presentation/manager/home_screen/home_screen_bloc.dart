import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'home_screen_event.dart';
import 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenState().init()) {
    on<InitEvent>(_init);
    on<OnLoadingPercentChanged>(_loadingPercentChanged);
  }

  void init(String url) => add(InitEvent(url));

  void onLoadingPercentChanged(int progress) => add(OnLoadingPercentChanged(progress));

//******************************************************************************

  void _init(InitEvent event, Emitter<HomeScreenState> emit) async {
    emit(state.clone());
  }

  FutureOr<void> _loadingPercentChanged(OnLoadingPercentChanged event, Emitter<HomeScreenState> emit) async {
    print("LoadingPercentNow -> ${event.percent}");
    await Future.delayed(const Duration(milliseconds: 500));
    if(event.percent >50){
      FlutterNativeSplash.remove();
    }
    emit(state.clone(percent: event.percent, loading: event.percent != 100));
  }
}
