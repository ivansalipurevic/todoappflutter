import 'package:todo_app/1_domain/entities/collections_id.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';

class TodoEntryParams {
  final CollectionId collectionId;
  final TodoEntry entry;

  TodoEntryParams({
    required this.collectionId,
    required this.entry,
  });
}

class CreateTodoEntry {
  Future<void> call(TodoEntryParams params) async {
    
}
}