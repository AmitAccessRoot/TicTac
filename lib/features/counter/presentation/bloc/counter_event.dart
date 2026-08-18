// lib/features/counter/presentation/bloc/counter_event.dart
import 'package:equatable/equatable.dart';

abstract class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}

class LoadCounterEvent extends CounterEvent {}

class StartLiveSimulationEvent extends CounterEvent {}

class IncrementCounterEvent extends CounterEvent {}
