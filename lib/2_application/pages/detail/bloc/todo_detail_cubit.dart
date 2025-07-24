import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/1_domain/entities/collections_id.dart';
import 'package:todo_app/1_domain/entities/entry_id.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_entry_ids_for_collection.dart';

part 'todo_detail_cubit_state.dart';

class TodoDetailCubit extends Cubit<TodoDetailCubitState> {
  TodoDetailCubit({
    required this.collectionId,
    required this.loadTodoEntryIdsForCollection,
  }) : super(ToDoDetailCubitLoadingState());

  final CollectionId collectionId;
  final LoadTodoEntryIdsForCollection loadTodoEntryIdsForCollection;

  Future<void> fetch() async {
    emit(ToDoDetailCubitLoadingState());
    try {
      final result = await loadTodoEntryIdsForCollection(
        LoadTodoEntryIdsForCollectionParams(collectionId: collectionId),
      );
      result.fold(
        (failure) => emit(ToDoDetailCubitErrorState()),
        (entryIds) => emit(ToDoDetailCubitLoadedState(entryIds: entryIds)),
      );
    } catch (_) {
      emit(ToDoDetailCubitErrorState());
    }
  }
}
