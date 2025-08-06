import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/2_application/pages/detail/bloc/todo_detail_cubit.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_entry_ids_for_collection.dart';
import 'package:todo_app/1_domain/entities/collections_id.dart';

typedef ToDoEntryItemAddedCallback = Function();

class TodoDetailPage extends StatelessWidget {
  static const pageConfig = _PageConfig(name: 'todo-detail');

  final CollectionId collectionId;
  final LoadTodoEntryIdsForCollection loadTodoEntryIdsForCollection;

  const TodoDetailPage({
    super.key,
    required this.collectionId,
    required this.loadTodoEntryIdsForCollection,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoDetailCubit>(
      create: (context) => TodoDetailCubit(
        collectionId: collectionId,
        loadTodoEntryIdsForCollection: loadTodoEntryIdsForCollection,
      )..fetch(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todo Detail'),
        ),
        body: BlocBuilder<TodoDetailCubit, TodoDetailCubitState>(
          builder: (context, state) {
            if (state is ToDoDetailCubitLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ToDoDetailCubitLoadedState) {
              return ListView.builder(
                itemCount: state.entryIds.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Entry ID: ${state.entryIds[index].value}'),
                  );
                },
              );
            } else {
              return const Center(child: Text('Error loading entries'));
            }
          },
        ),
      ),
    );
  }
}

/// Simple config class for GoRouter compatibility.
class _PageConfig {
  final String name;
  const _PageConfig({required this.name});
}
