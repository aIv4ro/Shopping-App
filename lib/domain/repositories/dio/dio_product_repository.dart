import 'dart:async';
import 'package:dio/dio.dart';
import 'package:shopping/domain/clients/dio_client.dart';
import 'package:shopping/domain/entities/product_entity.dart';
import 'package:shopping/domain/repositories/dio/dio_repository.dart';
import 'package:shopping/domain/repositories/i_product_repository.dart';

class DioProductRepository extends IProductRepository implements DioRepository {
  DioProductRepository({required this.dioClient});

  @override
  final basePath = 'api/product';

  @override
  final DioClient dioClient;
  Dio get dio => dioClient.dio;

  @override
  FutureOr<Product> create({required Product model}) async {
    final res = await dio.post(basePath, data: {'product': model.toJson()});
    final body = res.data as Map<String, dynamic>;
    return Product.fromJson(json: body);
  }

  @override
  FutureOr<bool> delete({required String id}) {
    return dio
        .delete('$basePath/$id')
        .then((value) => true)
        .catchError((err) => false);
  }

  @override
  FutureOr<List<Product>> findAll() async {
    final res = await dio.get(basePath);
    final body = res.data as List;
    final productsJson = List<Map<String, dynamic>>.from(body);
    return productsJson
        .map((productJson) => Product.fromJson(json: productJson))
        .toList();
  }

  @override
  FutureOr<Product> findById({required String id}) async {
    final res = await dio.get('$basePath/$id');
    final body = res.data as Map<String, dynamic>;
    return Product.fromJson(json: body);
  }

  @override
  FutureOr<Product> update({required Product model}) async {
    final res = await dio.patch(
      '$basePath/${model.id}',
      data: {'updatedFields': model.toJson()},
    );
    final body = res.data as Map<String, dynamic>;
    return Product.fromJson(json: body);
  }

  @override
  FutureOr<List<Product>> search({int offset = 0, int limit = 0}) async {
    final res = await dio.get(
      '$basePath/search',
      queryParameters: {
        'offset': offset,
        'limit': limit,
      },
    );

    final productsJson = List<Map<String, dynamic>>.from(res.data as List);

    return productsJson.map((productJson) {
      return Product.fromJson(json: productJson);
    }).toList();
  }
}
