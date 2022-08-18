import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/create_order/create_order_bloc.dart';
import 'package:shopping/blocs/products_list/products_list_bloc.dart';
import 'package:shopping/ui/pages/create-order/widgets/product_item.dart';
import 'package:shopping/ui/widgets/products_list.dart';

class FrontLayer extends StatefulWidget {
  const FrontLayer({super.key});

  @override
  State<FrontLayer> createState() => _FrontLayerState();
}

class _FrontLayerState extends State<FrontLayer> {
  late final ProductsListBloc _productsListBloc;
  late final CreateOrderBloc _createOrderBloc;

  @override
  void initState() {
    super.initState();
    _productsListBloc = context.read();
    _createOrderBloc = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _productsListBloc,
      child: ProductsList(
        productBuilder: (product) {
          return ProductItem(
            product: product,
            productsListBloc: _productsListBloc,
            createOrderBloc: _createOrderBloc,
          );
        },
      ),
    );
  }
}
