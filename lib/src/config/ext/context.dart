

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/manager/home_screen/home_screen_bloc.dart';

extension Values on BuildContext{
  HomeScreenBloc get homeScreenBloc => BlocProvider.of<HomeScreenBloc>(this);
}