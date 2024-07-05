import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecase/fetch_batch_ids_use_case.dart';
part 'hod_batch_event.dart';
part 'hod_batch_state.dart';

class HodBatchBloc extends Bloc<HodBatchEvent, HodBatchState> {
  final FetchBatchIdsUseCase fetchBatchIdsUseCase;

  HodBatchBloc({required this.fetchBatchIdsUseCase}) : super(HodBatchInitial()) {
    on<HodBatchLoadRequestedEvent>(_mapLoadRequestedToState);
  }

  void _mapLoadRequestedToState(
      HodBatchLoadRequestedEvent event,
      Emitter<HodBatchState> emit,
      ) async {
    emit(HodBatchLoading());
    try {
      final batches = await fetchBatchIdsUseCase(event.dept,event.facultyId,event.role);
      emit(HodBatchLoaded(batches));
    } catch (e) {
      emit(HodBatchError('Failed to load batches: $e'));
    }
  }
}
