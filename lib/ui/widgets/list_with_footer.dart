import 'package:flutter/material.dart';

class ListWithFooter extends StatelessWidget {
  const ListWithFooter({
    super.key,
    required this.children,
    required this.footer,
  });

  final List<Widget> children;
  final Widget footer;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(children),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: footer,
        ),
      ],
    );
  }
}
