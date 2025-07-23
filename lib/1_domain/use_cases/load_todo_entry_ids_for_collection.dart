import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/core/use_case.dart';


class LoadTodoEntryIdsForCollection implements UseCase<List<EntryId>, CollectionIdParam>