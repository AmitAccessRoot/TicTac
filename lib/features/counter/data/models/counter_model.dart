// lib/features/counter/data/models/counter_model.dart
import 'package:isar/isar.dart';
import '../../domain/entities/counter_entity.dart';

part 'counter_model.g.dart';

@collection
class CounterModel {
  Id id = Isar.autoIncrement;

  late String encryptedPayload;

  CounterModel();

  factory CounterModel.fromEntity(CounterEntity entity, String encrypted) {
    return CounterModel()
      ..id = entity.id
      ..encryptedPayload = encrypted;
  }
}
