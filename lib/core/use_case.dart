import 'package:either_dart/either.dart';
import 'package:todo_app/1_domain/failures/failures.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase <Type, Params>{
  Future<Either<Failure, Type>> call(Params params);
}

abstract class Params extends Equatable {}