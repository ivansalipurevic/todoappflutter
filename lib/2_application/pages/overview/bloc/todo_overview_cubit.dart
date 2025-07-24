import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_collections.dart';
import 'package:todo_app/core/use_case.dart';

part 'todo_overview_cubit_state.dart';

class TodoOverviewCubit extends Cubit<TodoOverviewCubitState> {
  TodoOverviewCubit({
    TodoOverviewCubitState? initialState,
    required this.loadTodoCollections,
  }) : super(initialState ?? const TodoOverviewCubitLoadingState());

  
  final LoadTodoCollections loadTodoCollections;

  Future<void> readToDoCollections() async {
    emit(TodoOverviewCubitLoadingState());
    try{
      final collectionsFuture = loadTodoCollections.call(NoParams());
      final collections = await collectionsFuture;

      if(collections.isLeft){
        emit(TodoOverviewCubitErrorState());
      }else{
        emit(TodoOverviewCubitLoadedState(collections: collections.right));
      }
    }on Exception{
      emit(TodoOverviewCubitErrorState());
    }
  }
}
