import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/products_list/products_list_bloc.dart';
import 'package:shopping/blocs/products_list/products_list_event.dart';
import 'package:shopping/ui/pages/create-order/widgets/back_layer.dart';
import 'package:shopping/ui/pages/create-order/widgets/front_layer.dart';
import 'package:shopping/ui/widgets/search_bar.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({super.key});

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  late final ProductsListBloc _productsListBloc;

  @override
  void initState() {
    super.initState();
    _productsListBloc = context.read();
  }

  void _handleFilterChange(String value) {
    _productsListBloc.add(FilterChangeEvent(newFilterValue: value));
  }

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      frontLayerActiveFactor: .95,
      backLayerBackgroundColor: Theme.of(context).colorScheme.onPrimary,
      frontLayerBackgroundColor: const Color(0xFFf5ebe0),
      appBar: SearchBar(
        title: 'Create order',
        actions: const [
          BackdropToggleButton(
            icon: AnimatedIcons.menu_close,
          )
        ],
        onFilterChanged: _handleFilterChange,
      ),
      subHeader: const Padding(
        padding: EdgeInsets.only(left: 10, top: 20, bottom: 10),
        child: Text(
          'Products',
          style: TextStyle(fontSize: 20),
        ),
      ),
      backLayer: const BackLayer(),
      frontLayer: const FrontLayer(),
    );
  }
}
