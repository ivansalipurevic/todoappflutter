import 'package:either_dart/either.dart';
import 'package:todo_app/1_domain/failures/failures.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/core/use_case.dart';

class CreateTodoCollection implements UseCase<bool, TodoCollectionParams> {
  final TodoRepository todoRepository;

  CreateTodoCollection({required this.todoRepository});

  @override
  Future<Either<Failure, bool>> call(TodoCollectionParams params) async {
    try {
      final result = await todoRepository.createTodoCollection(params.collection);
      return result.fold((left) => Left(left), (right) => Right(right));
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}

