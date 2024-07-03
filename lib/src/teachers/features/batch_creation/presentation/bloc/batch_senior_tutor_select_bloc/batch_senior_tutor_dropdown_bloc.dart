import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/fetch_drop_down_items_usecase.dart';
import 'batch_senior_tutor_dropdown_event.dart';
import 'batch_senior_tutor_dropdown_state.dart';

class DropdownBloc extends Bloc<DropdownEvent, DropdownState> {
  final FetchDropdownItemsUseCase? fetchDropdownItemsUseCase;

  DropdownBloc(this.fetchDropdownItemsUseCase)
      : super(DropdownState.initial()) {
    on<DropDownInitialEvent>(_onInitial);
    on<FetchDropdownItemsEvent>(_mapFetchDropdownItemsToState);
    on<FilterDropdownItemsEvent>(_mapFilterDropdownItemsToState);
    on<SelectDropdownItemEvent>(_mapSelectDropdownItemToState);
    on<ToggleDropdownVisibilityEvent>(_mapToggleDropdownVisibilityToState);
    on<HideDropdownEvent>(_mapHideDropdownToState);
  }


  void _onInitial(event,emit)
  {
    emit(DropdownState.initial());
  }

  void _mapFetchDropdownItemsToState(
      FetchDropdownItemsEvent event,
      Emitter<DropdownState> emit,
      ) async {
    emit(state.copyWith(status: DropdownStatus.loading));
    try {
      final items = await fetchDropdownItemsUseCase!();
      emit(state.copyWith(
        status: DropdownStatus.success,
        items: items,
        filteredItems: items,
      ));
    } catch (_) {
      emit(state.copyWith(status: DropdownStatus.failure));
    }
  }

  void _mapFilterDropdownItemsToState(
      FilterDropdownItemsEvent event,
      Emitter<DropdownState> emit,
      ) async {
    final filter = event.filter.toLowerCase();
    final filteredItems = state.items.where((item) {
      return item.toLowerCase().contains(filter);
    }).toList();
    emit(state.copyWith(filteredItems: filteredItems));
  }

  void _mapSelectDropdownItemToState(
      SelectDropdownItemEvent event,
      Emitter<DropdownState> emit,
      ) async {
    emit(state.copyWith(
      selectedItem: event.item,
      showDropdown: false,  // Hide dropdown when an item is selected
    ));
  }

  void _mapToggleDropdownVisibilityToState(
      ToggleDropdownVisibilityEvent event,
      Emitter<DropdownState> emit,
      ) async {
    emit(state.copyWith(showDropdown: !state.showDropdown));
  }

  void _mapHideDropdownToState(
      HideDropdownEvent event,
      Emitter<DropdownState> emit,
      ) async {
    emit(state.copyWith(showDropdown: false));
  }
}
