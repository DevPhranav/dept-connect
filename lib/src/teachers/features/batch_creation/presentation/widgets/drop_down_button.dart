import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/batch_senior_tutor_select_bloc/batch_senior_tutor_dropdown_bloc.dart';
import '../bloc/batch_senior_tutor_select_bloc/batch_senior_tutor_dropdown_event.dart';
import '../bloc/batch_senior_tutor_select_bloc/batch_senior_tutor_dropdown_state.dart';

class SimpleDropDownField extends StatefulWidget {
  final String hintText;

  const SimpleDropDownField({
    super.key,
    required this.hintText,
  });

  @override
  _SimpleDropDownFieldState createState() => _SimpleDropDownFieldState();
}

class _SimpleDropDownFieldState extends State<SimpleDropDownField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    context.read<DropdownBloc>().add(FetchDropdownItemsEvent());
    _controller.addListener(_filterItems);
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      context.read<DropdownBloc>().add(ToggleDropdownVisibilityEvent());
    } else {
      context.read<DropdownBloc>().add(HideDropdownEvent());
    }
  }

  void _filterItems() {
    final String filter = _controller.text.toLowerCase();
    context.read<DropdownBloc>().add(FilterDropdownItemsEvent(filter));
  }

  void _onItemSelected(String item) {
    _controller.text = item;
    FocusScope.of(context).unfocus(); // Close the keyboard
    context.read<DropdownBloc>().add(SelectDropdownItemEvent(item));
    context.read<DropdownBloc>().add(HideDropdownEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DropdownBloc, DropdownState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              focusNode: _focusNode,
              controller: _controller,
              decoration: InputDecoration(
                hintText: widget.hintText,
                border: const OutlineInputBorder(),
                suffixIcon: GestureDetector(
                  onTap: () {
                    context.read<DropdownBloc>().add(ToggleDropdownVisibilityEvent());
                  },
                  child: Icon(
                    state.showDropdown ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  ),
                ),
              ),
              onChanged: (_) => _filterItems(),
            ),
            if (state.showDropdown && state.status == DropdownStatus.success)
              Container(
                constraints: const BoxConstraints(maxHeight: 200),
                child: ListView(
                  children: state.filteredItems.map((item) {
                    return ListTile(
                      title: Text(item),
                      onTap: () {
                        _onItemSelected(item);
                      },
                    );
                  }).toList(),
                ),
              ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}