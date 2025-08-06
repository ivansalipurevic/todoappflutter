import 'package:flutter/material.dart';
import 'package:todo_app/1_domain/entities/collections_id.dart';

class TodoDetailPageProvider extends StatelessWidget {
  final CollectionId collectionId;

  const TodoDetailPageProvider({
    super.key,
    required this.collectionId,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Details for collection: ${collectionId.value}'),
    );
  }
}
