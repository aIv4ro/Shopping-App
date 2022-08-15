import 'package:equatable/equatable.dart';

class PendingOrdersEvent extends Equatable {
  const PendingOrdersEvent();

  @override
  List<Object?> get props => [];
}

class LoadPendingOrdersEvent extends PendingOrdersEvent {
  const LoadPendingOrdersEvent();
}
