import 'package:flutter/material.dart';
import 'package:todo_app/1_domain/entities/collections_id.dart';

class TodoDetailPageProvider extends StatelessWidget {
  final CollectionId collectionId;

  const TodoDetailPageProvider({
    Key? key,
    required this.collectionId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Details for collection: ${collectionId.value}'),
    );
  }
}
