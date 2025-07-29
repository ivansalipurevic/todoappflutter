import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/entities/todo_color.dart';
import 'package:todo_app/1_domain/use_cases/create_todo_collection.dart';
import 'package:todo_app/core/use_case.dart';

part 'create_todo_collection_page_state.dart';

class CreateTodoCollectionPageCubit extends Cubit<CreateTodoCollectionPageState> {
  CreateTodoCollectionPageCubit({required this.createTodoCollection})
      : super(const CreateTodoCollectionPageState());

  final CreateTodoCollection createTodoCollection;

  void titleChanged(String title) {
    emit(state.copyWith(title: title));
  }

  void colorChanged(String color) {
    emit(state.copyWith(color: color));
  }

  Future<void> sumbit() async {
    final parsedColorIndex = int.tryParse(state.color ?? '0') ?? 0;

    final collection = TodoCollection.empty().copyWith(
      title: state.title,
      color: TodoColor(colorIndex: parsedColorIndex),
    );

    await createTodoCollection(TodoCollectionParams(collection: collection));
  }
}
