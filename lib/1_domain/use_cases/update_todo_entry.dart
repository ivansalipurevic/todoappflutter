import 'package:either_dart/either.dart';

import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/failures/failures.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/core/use_case.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_entry.dart';


class UpdateTodoEntry implements UseCase<TodoEntry, TodoEntryIdsParam> {
  const UpdateTodoEntry({required this.todoRepository});
  final TodoRepository todoRepository;

  @override
  Future<Either<Failure, TodoEntry>> call(TodoEntryIdsParam params) async {
    try {
      final loadedEntry = await todoRepository.updateTodoEntry(
        collectionId: params.collectionId,
        entryId: params.entryId,
      );

      return loadedEntry.fold(
        (failure) => Left(failure),
        (entry) => Right(entry),
      );
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
