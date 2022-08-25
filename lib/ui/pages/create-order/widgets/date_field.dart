import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateField extends StatefulWidget {
  const DateField({
    super.key,
    this.padding = EdgeInsets.zero,
    this.onchange,
    this.controller,
    this.decoration,
    this.validator,
  });

  final EdgeInsets padding;
  final TextEditingController? controller;
  final Function(DateTime? value)? onchange;
  final InputDecoration? decoration;
  final FormFieldValidator<String>? validator;

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
  }

  void _handleTap() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 15)),
    ).then((pickedDate) {
      widget.onchange?.call(pickedDate);
      if (pickedDate != null) {
        final formatter = DateFormat.yMMMMEEEEd();
        controller.text = formatter.format(pickedDate);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: TextFormField(
        readOnly: true,
        onTap: _handleTap,
        controller: controller,
        decoration: widget.decoration,
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
