// lib/features/counter/domain/entities/counter_entity.dart
import 'package:equatable/equatable.dart';

class CounterEntity extends Equatable {
  final int id;
  final int onlineUsersCount;

  const CounterEntity({
    required this.id,
    required this.onlineUsersCount,
  });

  @override
  List<Object> get props => [id, onlineUsersCount];
}
