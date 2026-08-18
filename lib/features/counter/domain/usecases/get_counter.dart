// lib/features/counter/domain/usecases/get_counter.dart
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/counter_entity.dart';
import '../repositories/counter_repository.dart';

class GetCounterUseCase implements UseCase<CounterEntity, NoParams> {
  final CounterRepository repository;

  GetCounterUseCase(this.repository);

  @override
  Future<Either<Failure, CounterEntity>> call(NoParams params) async {
    return await repository.getCounter();
  }
}
