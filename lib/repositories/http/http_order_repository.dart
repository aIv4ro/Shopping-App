import 'dart:async';

import 'package:shopping/models/order_model.dart';
import 'package:shopping/repositories/repository.dart';

class HttpOrderRespository extends ModelRepository<Order> {
  @override
  FutureOr<Order> create({required Order model}) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  FutureOr<bool> delete({required String id}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  FutureOr<List<Order>> findAll() {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  FutureOr<Order> findById({required String id}) {
    // TODO: implement findById
    throw UnimplementedError();
  }

  @override
  FutureOr<Order> update({required Order model}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
