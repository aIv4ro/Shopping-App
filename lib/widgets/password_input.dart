import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({
    super.key,
    this.controller,
    this.prefixIcon,
    this.labelText,
    this.border,
    this.padding = EdgeInsets.zero,
    this.validator,
    this.autovalidateMode,
  });

  final TextEditingController? controller;
  final Widget? prefixIcon;
  final String? labelText;
  final InputBorder? border;
  final EdgeInsets padding;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;

  @override
  State<StatefulWidget> createState() {
    return PasswordInputState();
  }
}

class PasswordInputState extends State<PasswordInput> {
  bool isHidden = true;

  void toggleVisibility() => setState(() => isHidden = !isHidden);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: TextFormField(
        obscureText: isHidden,
        autovalidateMode: widget.autovalidateMode,
        validator: widget.validator,
        controller: widget.controller,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: toggleVisibility,
            icon: Icon(isHidden ? Icons.visibility_off : Icons.visibility),
          ),
          prefixIcon: widget.prefixIcon,
          labelText: widget.labelText,
          border: widget.border,
        ),
      ),
    );
  }
}
