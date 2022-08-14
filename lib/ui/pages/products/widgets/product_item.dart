import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/products_bloc/products_bloc.dart';
import 'package:shopping/blocs/products_bloc/products_event.dart';
import 'package:shopping/domain/entities/product_entity.dart';
import 'package:shopping/ui/pages/products/widgets/confirm_dialog.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  State<StatefulWidget> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  late final ProductsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read();
  }

  Future<bool?> _confirmDismiss(DismissDirection direction) async {
    if (direction != DismissDirection.endToStart) {
      return false;
    }

    final remove = await showConfirmationDialog(
      context,
      'You are going to delete the product, do you want to continue?',
    );

    return remove ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.product.id),
      confirmDismiss: _confirmDismiss,
      onDismissed: (direction) {
        _bloc.add(DeleteProductEvent(id: widget.product.id));
      },
      child: ListTile(
        title: Text(widget.product.name),
        subtitle: widget.product.description == null
            ? null
            : Text(
                widget.product.description!,
              ),
        trailing: IconButton(
          onPressed: () async {},
          icon: const Icon(Icons.edit),
        ),
      ),
    );
  }
}
