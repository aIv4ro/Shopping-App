import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:shopping/ui/pages/create-order/widgets/back_layer.dart';
import 'package:shopping/ui/pages/create-order/widgets/front_layer.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({super.key});

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      frontLayerActiveFactor: .95,
      backLayerBackgroundColor: Theme.of(context).colorScheme.onPrimary,
      frontLayerBackgroundColor: const Color(0xFFf5ebe0),
      appBar: AppBar(
        title: const Text('Create order'),
        actions: const [
          BackdropToggleButton(
            icon: AnimatedIcons.menu_close,
          )
        ],
      ),
      backLayer: const BackLayer(),
      frontLayer: const FrontLayer(),
    );
  }
}
