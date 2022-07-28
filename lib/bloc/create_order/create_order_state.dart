import 'package:equatable/equatable.dart';

enum CreateOrderStatus {
  initialStatus,
}

class CreateOrderState extends Equatable {
  const CreateOrderState({
    this.status = CreateOrderStatus.initialStatus,
  });

  final CreateOrderStatus status;

  CreateOrderState copyWith({
    CreateOrderStatus Function()? status,
  }) {
    return CreateOrderState(
      status: status != null ? status() : this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
