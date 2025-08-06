import 'package:either_dart/either.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/core/use_case.dart';

import 'package:todo_app/1_domain/failures/failures.dart';

class LoadTodoCollections implements UseCase<List<TodoCollection>, NoParams> {
  const LoadTodoCollections({required this.todoRepository});

  final TodoRepository todoRepository;

  @override
  Future<Either<Failure, List<TodoCollection>>> call(NoParams params) async {
    try {
      final loadedCollections = todoRepository.readToDoCollections();

      return loadedCollections.fold(
        (left) => Left(left),
        (right) => Right(right),
      );
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
