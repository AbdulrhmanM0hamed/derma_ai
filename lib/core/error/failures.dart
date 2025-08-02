import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final String messageAr;

  const Failure({
    required this.message,
    required this.messageAr,
  });

  @override
  List<Object> get props => [message, messageAr];
}

class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    required super.messageAr,
  });
}

class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
    required super.messageAr,
  });
}

class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    required super.messageAr,
  });
}
