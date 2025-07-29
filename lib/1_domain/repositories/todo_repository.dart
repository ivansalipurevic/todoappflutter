import 'package:either_dart/either.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/failures/failures.dart';
import 'package:todo_app/1_domain/entities/collections_id.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<TodoCollection>>> readToDoCollections();

  Future<Either<Failure, TodoEntry>> readToDoEntry(
    CollectionId collectionId,
    EntryId entryId,
  );

  Future<Either<Failure, List<EntryId>>> readToDoEntryIds(
    CollectionId collectionId,
  );

  Future<Either<Failure, TodoEntry>> updateTodoEntry({
    required CollectionId collectionId,
    required EntryId entryId,
  });
  Future<Either<Failure, bool >> createTodoCollection(TodoCollection collection);
}
