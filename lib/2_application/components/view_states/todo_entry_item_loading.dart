import 'package:flutter/material.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';

class TodoEntryItemLoading extends StatelessWidget {
  const TodoEntryItemLoading({super.key, required this.entryItem});
  final TodoEntry entryItem;

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}