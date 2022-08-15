import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/pending_orders/pending_orders_event.dart';
import 'package:shopping/blocs/pending_orders/pending_orders_state.dart';

class PendingOrdersBloc extends Bloc<PendingOrdersEvent, PendingOrdersState> {
  PendingOrdersBloc() : super(const PendingOrdersState());
}
