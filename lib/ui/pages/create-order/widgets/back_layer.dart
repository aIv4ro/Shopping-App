import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/create_order/create_order_bloc.dart';
import 'package:shopping/blocs/create_order/create_order_state.dart';
import 'package:shopping/domain/entities/user_entity.dart';
import 'package:shopping/ui/pages/create-order/widgets/date_field.dart';
import 'package:shopping/ui/pages/create-order/widgets/order_product_item.dart';
import 'package:shopping/ui/pages/create-order/widgets/search_user_field.dart';

class BackLayer extends StatefulWidget {
  const BackLayer({super.key});

  @override
  State<BackLayer> createState() => BackLayerState();
}

class BackLayerState extends State<BackLayer> {
  User? selectedUser;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchUserField(
          controller: TextEditingController(),
          onSelected: (value) {
            selectedUser = value;
          },
          validator: (value) {
            if (selectedUser == null) {
              return 'You have to select a user';
            }

            return null;
          },
        ),
        DateField(
          padding: const EdgeInsets.all(10),
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.calendar_month,
            ),
          ),
          onchange: (value) {
            selectedDate = value;
          },
          validator: (value) {
            if (selectedDate == null) {
              return 'You have to pick a date';
            }

            return null;
          },
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Added products',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder<CreateOrderBloc, CreateOrderState>(
            builder: (context, state) {
              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
                itemBuilder: (context, index) {
                  final orderProduct = state.orderProducts[index];

                  return OrderProductItem(
                    orderProduct: orderProduct,
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: state.orderProducts.length,
              );
            },
          ),
        ),
      ],
    );
  }
}
