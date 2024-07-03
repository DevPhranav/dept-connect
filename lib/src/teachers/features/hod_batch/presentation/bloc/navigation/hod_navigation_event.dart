
// Define events
import 'package:equatable/equatable.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();
}

class NavigationEventStream extends NavigationEvent {

  const NavigationEventStream();

  @override
  List<Object> get props => [];
}

class NavigationEventCourse extends NavigationEvent {


  const NavigationEventCourse();

  @override
  List<Object> get props => [];
}

class NavigationEventPeople extends NavigationEvent {

  const NavigationEventPeople();

  @override
  List<Object> get props => [];
}
