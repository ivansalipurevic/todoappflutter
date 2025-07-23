import 'package:either_dart/either.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/entities/todo_color.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/failures/failures.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';

class TodoRepositoryMock implements TodoRepository {
  @override
  Future<Either<Failure, List<TodoCollection>>> readToDoCollections() {
    final list = List<TodoCollection>.generate(
      10,
      (index) => TodoCollection(
        id: EntryId.fromUniqueString(index.toString()),
        title: 'title $index',
        color: TodoColor(colorIndex: index % TodoColor.predefinedColors.length),
      ),
    );
    return Future.delayed(Duration(milliseconds: 200), () => Right(list));
  }

  @override
  Future<Either<Failure, TodoEntry>> readToDoEntry(EntryId collectionId, EntryId entryId) async {
    final entry = TodoEntry(
      id: entryId,
      description: 'Mock todo entry',
      isDone: false,
    );
    return Right(entry);
  }
}
