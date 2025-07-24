import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/2_application/pages/detail/bloc/todo_detail_cubit.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_entry_ids_for_collection.dart';
import 'package:todo_app/1_domain/entities/collections_id.dart';


class TodoDetailPage extends StatelessWidget {
  final CollectionId collectionId;
  final LoadTodoEntryIdsForCollection loadTodoEntryIdsForCollection;

  const TodoDetailPage({
    Key? key,
    required this.collectionId,
    required this.loadTodoEntryIdsForCollection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoDetailCubit>(
      create: (context) => TodoDetailCubit(
        collectionId: collectionId,
        loadTodoEntryIdsForCollection: loadTodoEntryIdsForCollection,
      )..fetch(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Todo Detail'),
        ),
        body: BlocBuilder<TodoDetailCubit, TodoDetailCubitState>(
          builder: (context, state) {
            if (state is ToDoDetailCubitLoadingState) {
              return Center(child: CircularProgressIndicator());
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
              return Center(child: Text('Error loading entries'));
            }
          },
        ),
      ),
    );
  }
}
