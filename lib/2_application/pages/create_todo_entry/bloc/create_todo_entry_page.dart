import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/2_application/core/form_value.dart';
import 'package:todo_app/2_application/core/page_config.dart';
import 'package:todo_app/2_application/pages/create_todo_entry/bloc/create_todo_entry_page_cubit.dart';

class CreateTodoCollectionPageProvider extends StatelessWidget {
  const CreateTodoCollectionPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return const CreateTodoEntryPage();
  }
}

class CreateTodoEntryPage extends StatelessWidget {
  const CreateTodoEntryPage({super.key});

  static const pageConfig = PageConfig(
    name: 'create_todo_entry',
    icon: Icons.add_task_rounded,
    child: Placeholder(),
  );

  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        
        child: Column(
          children: [
            BlocBuilder<CreateTodoEntryPageCubit, CreateTodoEntryPageState>(
              builder: (context, state) {
                return TextFormField(
                  decoration: const InputDecoration(labelText: 'description'),
                  onChanged: (value) {
                    context.read<CreateTodoEntryPageCubit>().descriptionChanged(
                      description: value,
                    );
                  },
                  validator: (_) {
                    final description = state.description;
                    if (description == null) return null;

                    switch (description.validationStatus) {
                      case ValidationStatus.error:
                        return 'Description must be at least 2 characters.';
                      case ValidationStatus.pending:
                      case ValidationStatus.success:
                        return null;
                    }
                  },
                );
               
              },
            ),
          ],
        ),
      ),
    );
  }
}
