// lib/features/counter/domain/usecases/increment_counter.dart
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/counter_entity.dart';
import '../repositories/counter_repository.dart';

class IncrementCounterUseCase implements UseCase<CounterEntity, NoParams> {
  final CounterRepository repository;

  IncrementCounterUseCase(this.repository);

  @override
  Future<Either<Failure, CounterEntity>> call(NoParams params) async {
    final currentResult = await repository.getCounter();
    
    return currentResult.fold(
      (failure) async => Left(failure),
      (current) async {
        final newEntity = CounterEntity(
          id: current.id,
          onlineUsersCount: current.onlineUsersCount + 1,
        );
        
        final saveResult = await repository.saveCounter(newEntity);
        
        return saveResult.fold(
          (failure) => Left(failure),
          (_) => Right(newEntity),
        );
      },
    );
  }
}
