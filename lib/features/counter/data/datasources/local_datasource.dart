// lib/features/counter/data/datasources/local_datasource.dart
import 'package:isar/isar.dart';
import '../../../../core/database/database_service.dart';
import '../../../../core/isolate/isolate_helper.dart';
import '../../domain/entities/counter_entity.dart';
import '../models/counter_model.dart';

abstract class CounterLocalDataSource {
  Future<CounterEntity> getCounter();
  Future<void> saveCounter(CounterEntity counter);
}

class CounterLocalDataSourceImpl implements CounterLocalDataSource {
  final DatabaseService databaseService;
  final IsolateHelper isolateHelper;

  CounterLocalDataSourceImpl({
    required this.databaseService,
    required this.isolateHelper,
  });

  @override
  Future<CounterEntity> getCounter() async {
    final isar = databaseService.isar;
    final model = await isar.counterModels.where().findFirst();

    if (model != null) {
      final decryptedString = databaseService.decryptData(model.encryptedPayload);
      final count = int.tryParse(decryptedString) ?? 0;
      return CounterEntity(id: model.id, onlineUsersCount: count);
    } else {
      return const CounterEntity(id: 1, onlineUsersCount: 0);
    }
  }

  @override
  Future<void> saveCounter(CounterEntity counter) async {
    final isar = databaseService.isar;
    final encryptedString = databaseService.encryptData(counter.onlineUsersCount.toString());
    
    final model = CounterModel()
      ..id = counter.id
      ..encryptedPayload = encryptedString;

    await isar.writeTxn(() async {
      await isar.counterModels.put(model);
    });
  }
}
