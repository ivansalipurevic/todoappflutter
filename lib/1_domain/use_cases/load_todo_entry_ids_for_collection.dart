import 'package:either_dart/either.dart';
import 'package:todo_app/1_domain/entities/collections_id.dart';
import 'package:todo_app/1_domain/entities/entry_id.dart';
import 'package:todo_app/1_domain/failures/failures.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/core/use_case.dart';

class LoadTodoEntryIdsForCollectionParams {
  final CollectionId collectionId;

  LoadTodoEntryIdsForCollectionParams({required this.collectionId});
}

class LoadTodoEntryIdsForCollection implements UseCase<List<EntryId>, LoadTodoEntryIdsForCollectionParams> {
  final TodoRepository todoRepository;

  LoadTodoEntryIdsForCollection({required this.todoRepository});

  @override
  Future<Either<Failure, List<EntryId>>> call(LoadTodoEntryIdsForCollectionParams params) async {
    try {
      final result = await todoRepository.readTodoEntryIdsForCollection(params.collectionId);
      return result.fold(
        (failure) => Left(failure),
        (entryIds) => Right(entryIds),
      );
    } catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
