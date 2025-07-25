import 'package:flutter/material.dart';

class TodoEntryItemError extends StatelessWidget {
  const TodoEntryItemError({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(onTap: null, leading: Icon(Icons.warning_rounded),title: Text('Could not load item'),);
  }
}