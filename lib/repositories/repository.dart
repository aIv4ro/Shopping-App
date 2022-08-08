import 'dart:async';
import 'package:shopping/models/entity.dart';

abstract class Respository<T extends Entity> {
  FutureOr<T> findById({required String id});
  FutureOr<List<T>> findAll();
  FutureOr<T> create({required T model});
  FutureOr<T> update({required T model});
  FutureOr<bool> delete({required String id});
}
