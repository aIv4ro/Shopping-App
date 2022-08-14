import 'dart:async';

import 'package:shopping/domain/entities/product_entity.dart';
import 'package:shopping/domain/repositories/i_entity_repository.dart';

abstract class IProductRepository extends IEntityRepository<Product> {
  FutureOr<List<Product>> search({int offset = 0, int limit = 0});
}
