import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router_navigation_system_flutter/navigation/events.dart';
import 'package:go_router_navigation_system_flutter/navigation/state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState(NavigationTab.home)) {
    on<NavigationTabChanged>((event, emit) {
      emit(NavigationState(event.tab));
    });
  }
}
