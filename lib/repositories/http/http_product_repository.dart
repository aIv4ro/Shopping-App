import 'dart:async';
import 'package:shopping/models/product_model.dart';
import 'package:shopping/repositories/repository.dart';

class HttpProductRepository extends ModelRepository<Product> {
  @override
  FutureOr<Product> create({required Product model}) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  FutureOr<bool> delete({required String id}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  FutureOr<List<Product>> findAll() {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  FutureOr<Product> findById({required String id}) {
    // TODO: implement findById
    throw UnimplementedError();
  }

  @override
  FutureOr<Product> update({required Product model}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
