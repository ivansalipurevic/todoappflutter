import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/1_domain/entities/collections_id.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/use_cases/create_todo_entry.dart';

import 'package:todo_app/2_application/core/form_value.dart';

part 'create_todo_entry_page_state.dart';

class CreateTodoEntryPageCubit extends Cubit<CreateTodoEntryPageState> {
  CreateTodoEntryPageCubit({
    required this.collectionId,
    required this.addTodoEntry,
  }) : super(const CreateTodoEntryPageState());

  final CollectionId collectionId;
  final CreateTodoEntry addTodoEntry;

  void descriptionChanged({String? description}) {
    ValidationStatus currentStatus = ValidationStatus.pending;
    if (description == null || description.isEmpty || description.length < 2) {
      currentStatus = ValidationStatus.error;
    } else {
      currentStatus = ValidationStatus.success;
    }

    emit(
      state.copyWith(
        description: FormValue(
          value: description ?? '',
          validationStatus: currentStatus,
        ),
      ),
    );
  }

  void submit() async {
    final descriptionValue = state.description?.value ?? '';

   await addTodoEntry.call(
      TodoEntryParams(
        collectionId: collectionId,
        entry: TodoEntry.empty().copyWith(description: descriptionValue),
      ),
    );
  }
}
