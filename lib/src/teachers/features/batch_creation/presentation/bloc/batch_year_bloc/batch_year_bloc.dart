import 'package:flutter_bloc/flutter_bloc.dart';

import 'batch_year_event.dart';
import 'batch_year_state.dart';

class BatchYearBloc extends Bloc<BatchYearEvent, BatchYearState> {
  BatchYearBloc() : super(const BatchYearState('')) {
    on<BatchYearInitialEvent>((event, emit) {
        emit(const BatchYearState(''));
    });

    on<BatchYearChanged>((event, emit) {
      emit(BatchYearState(event.batchYear));
    });
  }
}
