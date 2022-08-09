import 'dart:async';
import 'package:shopping/domain/entities/entity.dart';

abstract class IEntityRepository<T extends Entity> {
  FutureOr<T> findById({required String id});
  FutureOr<List<T>> findAll();
  FutureOr<T> create({required T model});
  FutureOr<T> update({required T model});
  FutureOr<bool> delete({required String id});
}
