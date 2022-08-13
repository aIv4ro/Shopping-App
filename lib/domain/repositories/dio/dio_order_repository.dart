import 'dart:async';
import 'package:dio/dio.dart';
import 'package:shopping/domain/clients/dio_client.dart';
import 'package:shopping/domain/entities/order_entity.dart';
import 'package:shopping/domain/repositories/dio/dio_repository.dart';
import 'package:shopping/domain/repositories/i_order_repository.dart';

class DioProductRepository extends IOrderRepository implements DioRepository {
  DioProductRepository({required this.dioClient});

  @override
  String get basePath => 'api/order';

  @override
  final DioClient dioClient;
  Dio get dio => dioClient.dio;

  @override
  Future<Order> create({required Order model}) async {
    final res = await dio.post(basePath, data: {'order': model.toJson()});
    final body = res.data as Map<String, dynamic>;
    return Order.fromJson(json: body);
  }

  @override
  FutureOr<bool> delete({required String id}) {
    return dio
        .delete('$basePath/$id')
        .then((value) => true)
        .catchError((err) => false);
  }

  @override
  Future<List<Order>> findAll() async {
    final res = await dio.get(basePath);
    final body = res.data as List;
    final ordersJson = List<Map<String, dynamic>>.from(body);
    return ordersJson.map((orderJson) {
      return Order.fromJson(json: orderJson);
    }).toList();
  }

  @override
  Future<Order> findById({required String id}) async {
    final res = await dio.get('$basePath/$id');
    final body = res.data as Map<String, dynamic>;
    return Order.fromJson(json: body);
  }

  @override
  Future<Order> update({required Order model}) async {
    final res = await dio.patch('$basePath/${model.id}');
    final body = res.data as Map<String, dynamic>;
    return Order.fromJson(json: body);
  }
}
