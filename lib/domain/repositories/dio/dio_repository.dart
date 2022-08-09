import 'package:dio/dio.dart';
import 'package:shopping/domain/clients/dio_client.dart';

class DioRepository {
  const DioRepository({required DioClient dioClient}) : _dioClient = dioClient;
  final DioClient _dioClient;
  Dio get dio => _dioClient.dio;
  DioClient get client => _dioClient;
}
