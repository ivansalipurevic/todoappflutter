abstract class Failure {
  final String stackTrace;
  const Failure({required this.stackTrace});
}

class CacheFailure extends Failure {
  const CacheFailure({required String stackTrace}) : super(stackTrace: stackTrace);
}

class ServerFailure extends Failure {
  const ServerFailure({required String stackTrace}) : super(stackTrace: stackTrace);
}
