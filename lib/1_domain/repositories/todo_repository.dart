import 'package:either_dart/either.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/failures/failures.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<TodoCollection>>> readToDoCollections();

  Future<Either<Failure, TodoEntry>> readToDoEntry(EntryId collectionId, EntryId entryId);
}
