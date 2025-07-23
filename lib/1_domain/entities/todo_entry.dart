import 'package:todo_app/1_domain/entities/unique_id.dart';

class TodoEntry {
  final String description;
  final bool isDone;
  final EntryId id;

  const TodoEntry({
    required this.id,
    required this.description,
    required this.isDone,
  });

  factory TodoEntry.empty() {
    return TodoEntry(
      id: EntryId(), 
      description: '', 
      isDone: false);
  }
}
