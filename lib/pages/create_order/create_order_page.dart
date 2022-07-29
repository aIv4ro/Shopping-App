import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopping/widgets/expandable_fab.dart';
import 'package:shopping/widgets/search_field.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CreateOrderPageState();
}

class CreateOrderPageState extends State<CreateOrderPage> {
  final formKey = GlobalKey<FormState>();
  final dateController = TextEditingController();
  final userController = TextEditingController();
  String? itemSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Order'),
      ),
      floatingActionButton: ExpandableFab(
        distance: 100,
        children: [
          ActionButton(
            icon: const Icon(Icons.shopping_basket_outlined),
            onPressed: () {},
          ),
          ActionButton(
            icon: const Icon(Icons.check),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SearchField<String>(
                items: const [
                  'Alvaro',
                  'Rodrigo',
                  'Andres',
                  'Carlos',
                  'Sergio',
                  'Pepe',
                  'Maximiliano',
                  'Jose'
                ],
                labelText: 'Send to...',
                padding: const EdgeInsets.all(10),
                match: (item, input) => item.contains(input),
                buildItem: (item) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    child: Text(item),
                  );
                },
                onItemSelected: (item) => itemSelected = item,
                controller: userController,
                itemSelectedString: (item) => item,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Date',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  controller: dateController,
                  readOnly: true,
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );

                    if (pickedDate != null) {
                      final formatter = DateFormat.yMMMMEEEEd();
                      final dateFormatted = formatter.format(pickedDate);

                      dateController.text = dateFormatted;
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
