import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class BatchCreationState extends Equatable {
  const BatchCreationState();

  @override
  List<Object?> get props => [];
}

class BatchCreationInitial extends BatchCreationState {}

class BatchCreationLoading extends BatchCreationState {}

class BatchValidationSuccess extends BatchCreationState {
  final String message;

  const BatchValidationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class BatchCreationFailure extends BatchCreationState {
  final String error;

  const BatchCreationFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class BatchCreationSuccess extends BatchCreationState{}
