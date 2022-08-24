import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/create_order/create_order_bloc.dart';
import 'package:shopping/blocs/create_order/create_order_state.dart';
import 'package:shopping/domain/entities/user_entity.dart';

class SearchUserField extends StatelessWidget {
  const SearchUserField({
    required this.controller,
    this.onSelected,
    this.validator,
  });

  final TextEditingController controller;
  final Function(User value)? onSelected;
  final FormFieldValidator<String>? validator;

  Widget _fieldViewBuilder(
    BuildContext context,
    TextEditingController textEditingController,
    FocusNode focusNode,
    _,
  ) {
    return TextFormField(
      controller: textEditingController,
      focusNode: focusNode,
      decoration: const InputDecoration(
        labelText: 'User',
        prefixIcon: Icon(Icons.person),
      ),
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrderBloc, CreateOrderState>(
      buildWhen: (previous, current) => previous.users != current.users,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Autocomplete<User>(
            optionsBuilder: (textEditingValue) {
              if (textEditingValue.text.isEmpty) {
                return const Iterable.empty();
              }

              return state.users.where((user) {
                return user.match(textEditingValue.text);
              });
            },
            onSelected: onSelected,
            displayStringForOption: (user) => user.fullName,
            fieldViewBuilder: _fieldViewBuilder,
            optionsViewBuilder: (context, onSelected, options) {
              final suggestions = options.toList();

              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 20,
                  color: Theme.of(context).backgroundColor,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 20,
                    height: 200,
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final suggestion = suggestions[index];

                        return ListTile(
                          title: Text(suggestion.fullName),
                          subtitle: Text(suggestion.email),
                          onTap: () => onSelected(suggestion),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          thickness: 2,
                        );
                      },
                      itemCount: suggestions.length,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
