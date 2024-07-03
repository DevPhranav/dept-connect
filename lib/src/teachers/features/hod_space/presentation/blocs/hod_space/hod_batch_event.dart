part of 'hod_batch_bloc.dart';

class HodBatchEvent extends Equatable {
  const HodBatchEvent();

  @override
  List<Object> get props => [];
}

class HodBatchLoadRequestedEvent extends HodBatchEvent {
  final String dept;

  const HodBatchLoadRequestedEvent(this.dept);

  @override
  List<Object> get props => [dept];
}
