abstract class Failure {
  final String stackTrace;
  const Failure({required this.stackTrace});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.stackTrace});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.stackTrace});
}
