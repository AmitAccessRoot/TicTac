// lib/features/counter/presentation/bloc/counter_state.dart
import 'package:equatable/equatable.dart';

abstract class CounterState extends Equatable {
  const CounterState();

  @override
  List<Object> get props => [];
}

class CounterInitial extends CounterState {}

class CounterLoading extends CounterState {}

class CounterLoaded extends CounterState {
  final int onlineUsersCount;

  const CounterLoaded({required this.onlineUsersCount});

  @override
  List<Object> get props => [onlineUsersCount];
}

class CounterError extends CounterState {
  final String message;

  const CounterError({required this.message});

  @override
  List<Object> get props => [message];
}
