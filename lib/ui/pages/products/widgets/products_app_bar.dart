import 'package:flutter/material.dart';

class ProductsAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ProductsAppBar({super.key, this.onFilterChanged});

  final ValueChanged<String>? onFilterChanged;

  @override
  State<ProductsAppBar> createState() => _ProductsAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ProductsAppBarState extends State<ProductsAppBar> {
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
          : const Text('Products'),
      actions: _isSearchOpen
          ? null
          : [
              IconButton(
                onPressed: _toggleSearch,
                icon: const Icon(Icons.search),
              ),
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
        color: Colors.white,
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
