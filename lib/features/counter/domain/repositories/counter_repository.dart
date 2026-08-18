// lib/features/counter/domain/repositories/counter_repository.dart
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/counter_entity.dart';

abstract class CounterRepository {
  Future<Either<Failure, CounterEntity>> getCounter();
  Future<Either<Failure, void>> saveCounter(CounterEntity counter);
}
