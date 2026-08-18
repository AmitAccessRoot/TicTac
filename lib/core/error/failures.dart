// lib/core/error/failures.dart
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object> get props => [message];
}

class DatabaseFailure extends Failure {
  const DatabaseFailure({required super.message});
}

class SecurityFailure extends Failure {
  const SecurityFailure({required super.message});
}

class IsolateFailure extends Failure {
  const IsolateFailure({required super.message});
}
