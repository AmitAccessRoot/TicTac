// lib/features/counter/presentation/bloc/counter_bloc.dart
import 'dart:async';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/get_counter.dart';
import '../../domain/usecases/increment_counter.dart';
import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  final GetCounterUseCase getCounterUseCase;
  final IncrementCounterUseCase incrementCounterUseCase;
  Timer? _liveSimulationTimer;
  final Random _random = Random();

  CounterBloc({
    required this.getCounterUseCase,
    required this.incrementCounterUseCase,
  }) : super(CounterInitial()) {
    on<LoadCounterEvent>(_onLoadCounter);
    on<IncrementCounterEvent>(_onIncrementCounter);
    on<StartLiveSimulationEvent>(_onStartLiveSimulation);
  }

  Future<void> _onLoadCounter(LoadCounterEvent event, Emitter<CounterState> emit) async {
    emit(CounterLoading());
    final result = await getCounterUseCase(NoParams());
    result.fold(
      (failure) => emit(CounterError(message: failure.message)),
      (entity) => emit(CounterLoaded(onlineUsersCount: entity.onlineUsersCount)),
    );
  }

  Future<void> _onIncrementCounter(IncrementCounterEvent event, Emitter<CounterState> emit) async {
    final result = await incrementCounterUseCase(NoParams());
    result.fold(
      (failure) => emit(CounterError(message: failure.message)),
      (entity) => emit(CounterLoaded(onlineUsersCount: entity.onlineUsersCount)),
    );
  }

  void _onStartLiveSimulation(StartLiveSimulationEvent event, Emitter<CounterState> emit) {
    _liveSimulationTimer?.cancel();
    _triggerNextSimulation();
  }

  void _triggerNextSimulation() {
    final int delaySeconds = _random.nextInt(5) + 3; 
    _liveSimulationTimer = Timer(Duration(seconds: delaySeconds), () {
      if (!isClosed) {
        add(IncrementCounterEvent());
        _triggerNextSimulation();
      }
    });
  }

  @override
  Future<void> close() {
    _liveSimulationTimer?.cancel();
    return super.close();
  }
}
