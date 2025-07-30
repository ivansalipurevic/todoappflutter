import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/1_domain/entities/collections_id.dart';

import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_entry.dart';

part 'todo_entry_item_cubit_state.dart';

class TodoEntryItemCubit extends Cubit<TodoEntryItemState> {
  TodoEntryItemCubit({
    required this.loadTodoEntry,
    required this.entryId,
    required this.collectionId,
  }) : super(TodoEntryItemLoadingState());

  final EntryId entryId;
  final CollectionId collectionId;
  final LoadTodoEntry loadTodoEntry;

  Future<void> fetch() async {
    try {
      final entry = await loadTodoEntry.call(
        TodoEntryIdsParam(collectionId: collectionId, entryId: entryId),
      );

      return entry.fold(
        (left) => emit(TodoEntryItemErrorState()),
        (right) => TodoEntryItemLoadedState(toDoEntry: right),
      );
    } on Exception {
      emit(TodoEntryItemErrorState());
    }
  }
  Future<void> update(){
    throw UnimplementedError();
  }
}
