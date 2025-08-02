import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/0_data/data_sources/interfaces/todo_local_data_source_interface.dart';
import 'package:todo_app/0_data/exeptions/exeptions.dart';
import 'package:todo_app/0_data/models/todo_collection_model.dart';
import 'package:todo_app/0_data/models/todo_entry_model.dart';

class HiveLocalDataSoruce extends TodoLocalDataSourceInterface {
  late BoxCollection todoCollections;

  bool isInitialized = false;

  Future<void> init() async {
    if (!isInitialized) {
      todoCollections = await BoxCollection.open('todo', {
        'collection',
        'entry',
      }, path: './');
      isInitialized = true;
    } else {
      debugPrint('Hive was already initialized');
    }
  }

  Future<CollectionBox<Map>> _openCollectionBox() async {
    return todoCollections.openBox<Map>('collection');
  }

  Future<CollectionBox<Map>> _openEntryBox() async {
    return todoCollections.openBox<Map>('entry');
  }

  @override
  Future<bool> createTodoCollection({
    required TodoCollectionModel collection,
  }) async {
    final collectionBox = await _openCollectionBox();
    final entryBox = await _openEntryBox();

    await collectionBox.put(collection.id, collection.toJson());
    await entryBox.put(collection.id, {});

    return true;
  }

  @override
  Future<bool> createTodoEntry({
    required collectionId,
    required TodoEntryModel entry,
  }) async {
    final entryBox = await _openEntryBox();
    final entryList = await entryBox.get(collectionId);
    if (entryList == null) throw CollectionNotFoundException();

    entryList.cast<String, dynamic>().putIfAbsent(
      entry.id,
      () => entry.toJson(),
    );

    await entryBox.put(collectionId, entryList);

    return true;
  }

  @override
  Future<TodoCollectionModel> getTodoCollection({
    required String collectionId,
  }) async {
    final collectionBox = await _openCollectionBox();
    final rawCollection = await collectionBox.get(collectionId);
    final collection = rawCollection?.cast<String, dynamic>();

    if (collection == null) {
      throw EveryNotFoundException();
    }

    return TodoCollectionModel.fromJson(collection);
  }

  @override
  Future<List<String>> getTodoCollectionsIds() async {
    final collectionBox = await _openCollectionBox();
    final collectionIds = await collectionBox.getAllKeys();
    return collectionIds;
  }

  @override
  Future<TodoEntryModel> getTodoEntry({
    required String collectionId,
    required String entryId,
  }) async {
    final entryBox = await _openEntryBox();
    final entryList = await entryBox.get(collectionId);

    if (entryList == null) throw CollectionNotFoundException();
    if (!entryList.containsKey(entryId)) throw EntryNotFoundException();

    final entry = entryList[entryId]?.cast<String, dynamic>();

    return TodoEntryModel.fromJson(entry);
  }

  @override
  Future<List<String>> getTodoEntryIds({required String collectionId}) async {
    final entryBox = await _openEntryBox();
    final entryList = await entryBox.get(collectionId);

    if (entryList == null) throw CollectionNotFoundException();

    final entryIdList = entryList.cast<String, dynamic>().keys.toList();

    return entryIdList;
  }

  @override
  Future<TodoEntryModel> updateTodoEntry({
    required String collectionId,
    required String entryId,
  }) async {
    final entry = await getTodoEntry(
      collectionId: collectionId,
      entryId: entryId,
    );
    final entryBox = await _openEntryBox();
    final entryList = await entryBox.get(collectionId);

    final updatedEntry = TodoEntryModel(
      id: entry.id,
      description: entry.description,
      isDone: !entry.isDone,
    );

    entryList?[entryId] = updatedEntry.toJson();

    await entryBox.put(collectionId, entryList!);

    return updatedEntry;
  }
}

class EveryNotFoundException {}
