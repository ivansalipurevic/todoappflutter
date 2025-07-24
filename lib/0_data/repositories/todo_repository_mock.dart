import 'package:either_dart/either.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/entities/todo_color.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';  
import 'package:todo_app/1_domain/failures/failures.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/1_domain/entities/collections_id.dart';

class TodoRepositoryMock implements TodoRepository {
  final List<TodoEntry> toDoEntries = List.generate(
    100,
    (index) => TodoEntry(
      id: EntryId.fromUniqueString(index.toString()),
      description: 'description $index',
      isDone: false,
    ),
  );

  @override
  Future<Either<Failure, List<TodoCollection>>> readToDoCollections() async {
    final list = List<TodoCollection>.generate(
      10,
      (index) => TodoCollection(
        id: CollectionId.fromUniqueString(index.toString()),  
        title: 'title $index',
        color: TodoColor(colorIndex: index % TodoColor.predefinedColors.length),
      ),
    );
    return Future.delayed(Duration(milliseconds: 200), () => Right(list));
  }

  @override
  Future<Either<Failure, TodoEntry>> readToDoEntry(
    CollectionId collectionId,
    EntryId entryId,
  ) async {
    final entry = TodoEntry(
      id: entryId,
      description: 'Mock todo entry',
      isDone: false,
    );
    return Right(entry);
  }

  @override
  Future<Either<Failure, List<EntryId>>> readToDoEntryIds(
    CollectionId collectionId,
  ) async {
    try {
      final startIndex = int.parse(collectionId.value) * 10;
      final endIndex = startIndex + 10;
      final entryIds = toDoEntries
          .sublist(startIndex, endIndex)
          .map((entry) => entry.id)
          .toList();
      return await Future.delayed(
        const Duration(milliseconds: 300),
        () => Right(entryIds),
      );
    } catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }
}
