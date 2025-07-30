import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/1_domain/entities/collections_id.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';

import 'package:todo_app/2_application/components/todo_entry_item/todo_entry_item.dart';
import 'package:todo_app/2_application/pages/create_todo_entry/bloc/create_todo_entry_page.dart';
import 'package:todo_app/2_application/pages/detail/todo_detail_page.dart';

class CreateTodoEntryPageExtra {
  final CollectionId collectionId;
  final ToDoEntryItemAddedCallback toDoEntryItemAddedCallback;

  CreateTodoEntryPageExtra({
    required this.collectionId,
    required this.toDoEntryItemAddedCallback,
  });
}

class TodoDetailLoaded extends StatelessWidget {
  const TodoDetailLoaded({
    super.key,
    required this.collectionId,
    required this.entryIds,
  });

  final List<EntryId> entryIds;
  final CollectionId collectionId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            ListView.builder(
              itemCount: entryIds.length,
              itemBuilder: (context, index) => TodoEntryItemProvider(
                collectionId: collectionId,
                entryId: entryIds[index],
              ),
            ),
            FloatingActionButton(
              child: const Icon(Icons.add_task_rounded),
              onPressed: () {
                context.pushNamed(
                  CreateTodoEntryPage.pageConfig.name,
                  extra: collectionId,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
