part of 'hod_batch_bloc.dart';

class HodBatchEvent extends Equatable {
  const HodBatchEvent();

  @override
  List<Object> get props => [];
}

class HodBatchLoadRequestedEvent extends HodBatchEvent {
  final String dept;
  final String facultyId;
  final String role;
  const HodBatchLoadRequestedEvent(this.dept,this.facultyId,this.role);

  @override
  List<Object> get props => [dept];
}
