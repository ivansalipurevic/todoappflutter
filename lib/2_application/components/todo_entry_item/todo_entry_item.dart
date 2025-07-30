import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/1_domain/entities/collections_id.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';

import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_entry.dart';
import 'package:todo_app/2_application/components/bloc/todo_entry_item_cubit.dart';
import 'package:todo_app/2_application/components/view_states/todo_entry_item_error.dart';
import 'package:todo_app/2_application/components/view_states/todo_entry_item_loaded.dart';
import 'package:todo_app/2_application/components/view_states/todo_entry_item_loading.dart';

class TodoEntryItemProvider extends StatelessWidget {
  const TodoEntryItemProvider({
    super.key,
    required this.collectionId,
    required this.entryId,
  });

  final CollectionId collectionId;
  final EntryId entryId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoEntryItemCubit>(
      create: (context) => TodoEntryItemCubit(
        collectionId: collectionId,
        entryId: entryId,
        loadTodoEntry: LoadTodoEntry(
          todoRepository: RepositoryProvider.of<TodoRepository>(context),
        ),
      )..fetch(),
      child: const TodoEntryItem(),
    );
  }
}

class TodoEntryItem extends StatelessWidget {
  const TodoEntryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoEntryItemCubit, TodoEntryItemState>(
      builder: (context, state) {
        if (state is TodoEntryItemLoadingState) {
          return const TodoEntryItemLoading(); 
        } else if (state is TodoEntryItemLoadedState) {
          return TodoEntryItemLoaded(entryItem: state.toDoEntry);
        } else {
          return const TodoEntryItemError();
        }
      },
    );
  }
}
