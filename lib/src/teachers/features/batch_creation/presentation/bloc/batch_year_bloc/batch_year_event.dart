import 'package:equatable/equatable.dart';

abstract class BatchYearEvent extends Equatable {
  const BatchYearEvent();

  @override
  List<Object> get props => [];
}

class BatchYearInitialEvent extends BatchYearEvent{}
class BatchYearChanged extends BatchYearEvent {
  final String batchYear;

  const BatchYearChanged(this.batchYear);

  @override
  List<Object> get props => [batchYear];
}

