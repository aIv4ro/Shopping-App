import 'package:flutter/material.dart';

class ListWithFooter extends StatelessWidget {
  const ListWithFooter({
    super.key,
    required this.children,
    required this.footer,
    this.padding = EdgeInsets.zero,
  });

  final List<Widget> children;
  final List<Widget> footer;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(delegate: SliverChildListDelegate(children)),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: footer,
          ),
        ),
      ],
    );
  }
}
