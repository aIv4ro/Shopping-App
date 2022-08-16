import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable {}

class LoadOrderEvent extends OrderEvent {
  LoadOrderEvent({required this.id});

  final String id;

  @override
  List<Object?> get props => [id];
}
