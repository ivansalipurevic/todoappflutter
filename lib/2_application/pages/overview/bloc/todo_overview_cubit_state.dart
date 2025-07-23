part of 'todo_overview_cubit.dart';

abstract class TodoOverviewCubitState extends Equatable {
  const TodoOverviewCubitState();

  @override
  List<Object> get props => [];
}

class TodoOverviewCubitLoadingState extends TodoOverviewCubitState {}

class TodoOverviewCubitErrorState extends TodoOverviewCubitState {}

class TodoOverviewCubitLoadedState extends TodoOverviewCubitState {
  const TodoOverviewCubitLoadedState({required this.collections});
  final List<TodoCollection> collections;

  @override
  List<Object> get props => [collections];
}
