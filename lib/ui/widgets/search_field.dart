import 'package:flutter/material.dart';

class SearchField<T> extends StatefulWidget {
  const SearchField({
    super.key,
    this.items = const [],
    this.labelText,
    this.padding = EdgeInsets.zero,
    this.prefixIcon,
    this.maxSuggestionsHeight = double.infinity,
    this.onItemSelected,
    this.match,
    this.buildItem,
    this.itemSelectedString,
    required this.controller,
    this.validator,
  });

  final List<T> items;
  final String? labelText;
  final Widget? prefixIcon;
  final bool Function(T item, String input)? match;
  final Widget Function(T item)? buildItem;
  final Function(T? value)? onItemSelected;
  final String Function(T value)? itemSelectedString;
  final EdgeInsets padding;
  final double maxSuggestionsHeight;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  @override
  State<StatefulWidget> createState() => SearchFieldState<T>();
}

class SearchFieldState<T> extends State<SearchField<T>> {
  List<T> suggestions = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: widget.labelText,
              prefixIcon: widget.prefixIcon,
            ),
            controller: widget.controller,
            onChanged: onChanged,
            validator: widget.validator,
          ),
          Container(
            constraints: BoxConstraints(
              maxHeight: widget.maxSuggestionsHeight,
            ),
            width: double.infinity,
            child: Card(
              elevation: 10,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: suggestions.map((item) {
                    return InkWell(
                      onTap: () => _onItemSelected(item),
                      child: widget.buildItem?.call(item) ??
                          _buildDefaultWidget(item),
                    );
                  }).toList(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void onChanged(String value) {
    final newSuggestions = widget.items.where((item) {
      return widget.match?.call(item, value) ?? item.toString().contains(value);
    }).toList();

    widget.onItemSelected?.call(null);

    setState(() => suggestions = [...newSuggestions]);
  }

  void clearSuggestions() => setState(() => suggestions = []);

  void _onItemSelected(T? item) {
    widget.onItemSelected?.call(item);

    if (item == null) {
      return;
    }

    widget.controller.text =
        widget.itemSelectedString?.call(item) ?? item.toString();

    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.focusedChild?.unfocus();
    }

    clearSuggestions();
  }

  Widget _buildDefaultWidget(T item) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: Text(item.toString()),
    );
  }
}
