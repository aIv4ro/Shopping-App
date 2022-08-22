import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchBar({
    super.key,
    this.title = '',
    this.onFilterChanged,
    this.actions = const [],
  });

  final ValueChanged<String>? onFilterChanged;
  final String title;
  final List<Widget> actions;

  @override
  State<SearchBar> createState() => _SearchBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchBarState extends State<SearchBar> {
  bool _isSearchOpen = false;

  void _toggleSearch() => setState(() => _isSearchOpen = !_isSearchOpen);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _isSearchOpen
          ? SearchInput(
              onPressed: _toggleSearch,
              onChanged: widget.onFilterChanged,
            )
          : Text(widget.title),
      actions: _isSearchOpen
          ? null
          : [
              IconButton(
                onPressed: _toggleSearch,
                icon: const Icon(Icons.search),
              ),
              ...widget.actions,
            ],
    );
  }
}

class SearchInput extends StatelessWidget {
  const SearchInput({
    super.key,
    this.onPressed,
    this.onChanged,
  });

  final VoidCallback? onPressed;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: TextField(
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: onPressed,
            ),
            hintText: 'Search...',
            border: InputBorder.none,
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
