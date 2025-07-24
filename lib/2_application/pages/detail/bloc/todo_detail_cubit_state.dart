part of 'todo_detail_cubit.dart';

abstract class TodoDetailCubitState extends Equatable {
  const TodoDetailCubitState();

  @override
  List<Object> get props => [];
}

class ToDoDetailCubitLoadingState extends TodoDetailCubitState {}

class ToDoDetailCubitErrorState extends TodoDetailCubitState {}

class ToDoDetailCubitLoadedState extends TodoDetailCubitState {
  const ToDoDetailCubitLoadedState({required this.entryIds});
  final List<EntryId> entryIds;

    @override
  List<Object> get props => [entryIds];
}
