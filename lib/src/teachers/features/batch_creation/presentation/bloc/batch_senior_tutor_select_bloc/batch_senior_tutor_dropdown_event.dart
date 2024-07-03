import 'package:equatable/equatable.dart';

// Define the base class for all dropdown events
abstract class DropdownEvent extends Equatable {
  const DropdownEvent();

  @override
  List<Object?> get props => [];
}

class DropDownInitialEvent extends DropdownEvent{}

// Event to fetch dropdown items from the repository
class FetchDropdownItemsEvent extends DropdownEvent {}

// Event for when a dropdown item is selected
class SelectDropdownItemEvent extends DropdownEvent {
  final String item;

  const SelectDropdownItemEvent(this.item);

  @override
  List<Object?> get props => [item];
}

// Event for filtering dropdown items
class FilterDropdownItemsEvent extends DropdownEvent {
  final String filter;

  const FilterDropdownItemsEvent(this.filter);

  @override
  List<Object?> get props => [filter];
}

// Event to toggle the dropdown visibility
class ToggleDropdownVisibilityEvent extends DropdownEvent {}

class HideDropdownEvent extends DropdownEvent {}