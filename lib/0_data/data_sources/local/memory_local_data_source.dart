import 'package:todo_app/0_data/data_sources/interfaces/todo_local_data_source_interface.dart';
import 'package:todo_app/0_data/exeptions/exeptions.dart';
import 'package:todo_app/0_data/models/todo_collection_model.dart';
import 'package:todo_app/0_data/models/todo_entry_model.dart';

class MemoryLocalDataSource implements TodoLocalDataSourceInterface {
  final List<TodoCollectionModel> todoCollections = [];
  final Map<String, List<TodoEntryModel>> todoEntries = {};
  @override
  Future<bool> createTodoCollection({required TodoCollectionModel collection}) {
    try {
      todoCollections.add(collection);
      todoEntries.putIfAbsent(collection.id, () => []);

      return Future.value(true);
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<bool> createTodoEntry({
    required collectionId,
    required TodoEntryModel entry,
  }) {
    try {
      final doesCollectionsExists = todoEntries.containsKey(collectionId);
      if (doesCollectionsExists) {
        todoEntries[collectionId]?.add(entry);
        return Future.value(true);
      } else {
        throw CollectionNotFoundException();
      }
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<TodoCollectionModel> getTodoCollection({
    required String collectionId,
  }) {
    try {
      final collectionModel = todoCollections.firstWhere(
        (element) => element.id == collectionId,
        orElse: () => throw CollectionNotFoundException(),
      );

      return Future.value(collectionModel);
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<List<String>> getTodoCollectionsIds() {
    try {
      return Future.value(
        todoCollections.map((collection) => collection.id).toList(),
      );
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<TodoEntryModel> getTodoEntry({
    required String collectionId,
    required String entryId,
  }) {
    try {
      if (todoEntries.containsKey(collectionId)) {
        final entry = todoEntries[collectionId]?.firstWhere(
          (entry) => entry.id == entryId,
          orElse: () => throw EntryNotFoundException(),
        );
        return Future.value(entry);
      } else {
        throw CollectionNotFoundException();
      }
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<List<String>> getTodoEntryIds({required String collectionId}) {
    try {
      if (todoEntries.containsKey(collectionId)) {
        return Future.value(
          todoEntries[collectionId]?.map((entry) => entry.id).toList(),
        );
      } else {
        throw CollectionNotFoundException();
      }
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<TodoEntryModel> updateTodoEntry({
    required String collectionId,
    required String entryId,
  }) {
    try {
      if (todoEntries.containsKey(collectionId)) {
        final indexOfElement = todoEntries[collectionId]?.indexWhere(
          (element) => element.id == entryId,
        );
        if (indexOfElement == null || indexOfElement == -1) {
          throw EntryNotFoundException();
        }
        final entry = todoEntries[collectionId]![indexOfElement];
        if (entry == null) {
          throw EntryNotFoundException();
        }
        final updatedEntry = TodoEntryModel(
          id: entry.id,
          description: entry.description,
          isDone: !entry.isDone,
        );
        todoEntries[collectionId]?[indexOfElement] = updatedEntry;
        return Future.value(updatedEntry);
      } else {
        throw CollectionNotFoundException();
      }
    } on Exception catch (_) {
      throw CacheException();
    }
  }
}
