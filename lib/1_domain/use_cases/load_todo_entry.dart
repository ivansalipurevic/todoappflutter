import 'package:either_dart/either.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart'; 
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/failures/failures.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/core/use_case.dart';
import 'package:todo_app/1_domain/entities/collections_id.dart';

class TodoEntryIdsParam {
  final CollectionId collectionId;
  final EntryId entryId;

  const TodoEntryIdsParam({required this.collectionId, required this.entryId});
}

class LoadTodoEntry implements UseCase<TodoEntry, TodoEntryIdsParam> {
  const LoadTodoEntry({required this.todoRepository});
  final TodoRepository todoRepository;

  @override
  Future<Either<Failure, TodoEntry>> call(TodoEntryIdsParam params) async {
    try {
      final loadedEntry = await todoRepository.readToDoEntry(
        params.collectionId,
        params.entryId,
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

