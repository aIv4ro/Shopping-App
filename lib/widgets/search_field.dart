import 'package:flutter/material.dart';

class SearchField<T> extends StatefulWidget {
  const SearchField({
    Key? key,
    this.items = const [],
    this.labelText,
    this.padding = EdgeInsets.zero,
    this.prefixIcon,
    this.maxSuggestionsHeight = double.infinity,
    required this.onItemSelected,
    required this.match,
    required this.buildItem,
    required this.itemSelectedString,
    required this.controller,
  }) : super(key: key);

  final List<T> items;
  final String? labelText;
  final Widget? prefixIcon;
  final bool Function(T item, String input) match;
  final Widget Function(T item) buildItem;
  final void Function(T value) onItemSelected;
  final String Function(T value) itemSelectedString;
  final EdgeInsets padding;
  final double maxSuggestionsHeight;
  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() => SearchFieldState<T>();
}

class SearchFieldState<T> extends State<SearchField<T>> {
  List<T> suggestions = [];

  void onChanged(String value) {
    final newSuggestions = widget.items.where((item) {
      return widget.match(item, value);
    }).toList();

    setState(() => suggestions = [...newSuggestions]);
  }

  void clearSuggestions() => setState(() => suggestions = []);

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
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: widget.maxSuggestionsHeight,
            ),
            child: Card(
              elevation: 10,
              child: SingleChildScrollView(
                child: Column(
                  children: suggestions.map((item) {
                    return InkWell(
                      onTap: () {
                        widget.onItemSelected(item);
                        widget.controller.text =
                            widget.itemSelectedString(item);

                        final currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.focusedChild?.unfocus();
                        }

                        clearSuggestions();
                      },
                      child: widget.buildItem(item),
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
}
