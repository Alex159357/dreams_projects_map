

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/manager/home_screen/home_screen_bloc.dart';

class Blocs{

  static List<BlocProvider> get getList => [
  BlocProvider<HomeScreenBloc>(create: (context)=> HomeScreenBloc()..init("https://maps.bmby.com/?lang=he&force=1")),];

}