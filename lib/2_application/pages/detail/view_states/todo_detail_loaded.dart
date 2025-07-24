import 'package:flutter/material.dart';
import 'package:todo_app/1_domain/entities/collections_id.dart';
import 'package:todo_app/1_domain/entities/entry_id.dart';

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
        child: ListView.builder(
          itemCount: entryIds.length,
          itemBuilder: (context, index) =>  Text('$index'),
        ),
      ),
    );
  }
}
