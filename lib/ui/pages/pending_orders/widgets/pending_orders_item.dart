import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopping/domain/entities/order_entity.dart';
import 'package:shopping/ui/paths.dart';

class PendingOrderItem extends StatefulWidget {
  const PendingOrderItem({super.key, required this.order});

  final Order order;

  @override
  State<PendingOrderItem> createState() => _PendingOrderItemState();
}

class _PendingOrderItemState extends State<PendingOrderItem> {
  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(DateTime.now());

    return ListTile(
      title: Text('From: ${widget.order.fromUser.fullName}'),
      subtitle: Text('Date: $formatted'),
      trailing: TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            order,
            arguments: widget.order.id,
          );
        },
        child: const Text('See'),
      ),
    );
  }
}
