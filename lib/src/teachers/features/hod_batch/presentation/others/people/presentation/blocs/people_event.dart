import 'package:equatable/equatable.dart';

abstract class PeopleEvent extends Equatable {
  const PeopleEvent();

  @override
  List<Object> get props => [];
}

class LoadPeople extends PeopleEvent {
  final String batchId;
  final String section;

  const LoadPeople({ required this.batchId, required this.section});

  @override
  List<Object> get props => [batchId, section];
}
