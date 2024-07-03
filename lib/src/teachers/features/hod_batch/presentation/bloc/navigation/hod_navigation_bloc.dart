import 'package:flutter_bloc/flutter_bloc.dart';

import 'hod_navigation_event.dart';
import 'hod_navigation_state.dart';


// NavigationBloc implementation
class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState(selectedIndex: 0,)) {
    on<NavigationEventStream>((event, emit) {
      emit(const NavigationState(selectedIndex: 0,));
    });
    on<NavigationEventCourse>((event, emit) {
      emit(const NavigationState(selectedIndex: 1,));
    });
    on<NavigationEventPeople>((event, emit) {
      emit(const NavigationState(selectedIndex: 2,));
    });
  }
}
