import 'package:equatable/equatable.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';

class TodoEntry extends Equatable {
  final String description;
  final bool isDone;
  final EntryId id;

  const TodoEntry({
    required this.id,
    required this.description,
    required this.isDone,
  });

  factory TodoEntry.empty() {
    return TodoEntry(id: EntryId(), description: '', isDone: false);
  }

  TodoEntry copyWith({String? description, bool? isDone}) {
    return TodoEntry(
      id: id,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  List<Object?> get props => [id, isDone, description];
}
