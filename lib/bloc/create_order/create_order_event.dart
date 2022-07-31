import 'package:equatable/equatable.dart';

abstract class CreateOrderEvent extends Equatable {
  const CreateOrderEvent();

  @override
  List<Object> get props => [];
}


class CreateProductEvent extends CreateOrderEvent {
  const CreateProductEvent({
    required this.name,
    this.description = '',
  });

  final String name;
  final String description;

  @override
  List<Object> get props => [name, description];
}