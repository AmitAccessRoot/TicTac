// lib/injection_container.dart
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'core/database/database_service.dart';
import 'core/security/security_service.dart';
import 'core/isolate/isolate_helper.dart';
import 'features/counter/data/datasources/local_datasource.dart';
import 'features/counter/data/models/counter_model.dart';
import 'features/counter/data/repositories/counter_repository_impl.dart';
import 'features/counter/domain/repositories/counter_repository.dart';
import 'features/counter/domain/usecases/get_counter.dart';
import 'features/counter/domain/usecases/increment_counter.dart';
import 'features/counter/presentation/bloc/counter_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  const secureStorage = FlutterSecureStorage();
  sl.registerLazySingleton(() => secureStorage);

  sl.registerLazySingleton(() => SecurityService(secureStorage: sl()));
  
  final databaseService = DatabaseService(securityService: sl());
  await databaseService.init([CounterModelSchema]);
  sl.registerLazySingleton(() => databaseService);

  sl.registerLazySingleton(() => IsolateHelper());

  sl.registerLazySingleton<CounterLocalDataSource>(
    () => CounterLocalDataSourceImpl(
      databaseService: sl(),
      isolateHelper: sl(),
    ),
  );

  sl.registerLazySingleton<CounterRepository>(
    () => CounterRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton(() => GetCounterUseCase(sl()));
  sl.registerLazySingleton(() => IncrementCounterUseCase(sl()));

  sl.registerFactory(
    () => CounterBloc(
      getCounterUseCase: sl(),
      incrementCounterUseCase: sl(),
    ),
  );
}
