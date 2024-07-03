import 'package:equatable/equatable.dart';

// Enum representing the possible states of the dropdown
enum DropdownStatus { initial, loading, success, failure }

class DropdownState extends Equatable {
  final DropdownStatus status;
  final List<String> items;
  final List<String> filteredItems;
  final String selectedItem;
  final bool showDropdown;

  const DropdownState({
    required this.status,
    required this.items,
    required this.filteredItems,
    required this.selectedItem,
    required this.showDropdown,
  });

  // Factory constructor for the initial state
  factory DropdownState.initial() {
    return const DropdownState(
      status: DropdownStatus.initial,
      items: [],
      filteredItems: [],
      selectedItem: '',
      showDropdown: false,
    );
  }

  // Method to create a copy of the state with new values
  DropdownState copyWith({
    DropdownStatus? status,
    List<String>? items,
    List<String>? filteredItems,
    String? selectedItem,
    bool? showDropdown,
  }) {
    return DropdownState(
      status: status ?? this.status,
      items: items ?? this.items,
      filteredItems: filteredItems ?? this.filteredItems,
      selectedItem: selectedItem ?? this.selectedItem,
      showDropdown: showDropdown ?? this.showDropdown,
    );
  }

  @override
  List<Object?> get props =>
      [status, items, filteredItems, selectedItem, showDropdown];
}
