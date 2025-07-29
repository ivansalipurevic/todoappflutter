import 'package:either_dart/either.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/failures/failures.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class Params extends Equatable {}

class NoParams extends Params {
  @override
  List<Object?> get props => [];
}

class CollectionIdParam extends Params {
  CollectionIdParam({required this.collectionId, required this.entryId}) : super();

  final EntryId entryId;
  final EntryId collectionId;  

  @override
  List<Object> get props => [collectionId];
}
class TodoCollectionParams extends Params {
  TodoCollectionParams({required this.collection}) : super();

  final EntryId collection;  

  @override
  List<Object> get props => [collection];
}
