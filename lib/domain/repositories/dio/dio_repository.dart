import 'package:shopping/domain/clients/dio_client.dart';

abstract class DioRepository {
  abstract final String? basePath;
  abstract final DioClient dioClient;
}
