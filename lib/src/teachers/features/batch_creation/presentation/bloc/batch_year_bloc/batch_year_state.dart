import 'package:equatable/equatable.dart';

class BatchYearState extends Equatable {
  final String batchYear;

  const BatchYearState(this.batchYear);

  @override
  List<Object> get props => [batchYear];
}
