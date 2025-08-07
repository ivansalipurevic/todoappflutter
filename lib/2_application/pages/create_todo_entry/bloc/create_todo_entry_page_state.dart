part of 'create_todo_entry_page_cubit.dart';

enum FormSubmissionStatus { initial, loading, success, failure }

class CreateTodoEntryPageState extends Equatable {
  final FormValue<String?>? description;
  final bool isValid;
  final FormSubmissionStatus status;

  const CreateTodoEntryPageState({
    this.description,
    this.isValid = false,
    this.status = FormSubmissionStatus.initial,
  });

  CreateTodoEntryPageState copyWith({
    FormValue<String?>? description,
    bool? isValid,
    FormSubmissionStatus? status,
  }) {
    return CreateTodoEntryPageState(
      description: description ?? this.description,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [description, isValid, status];
}
