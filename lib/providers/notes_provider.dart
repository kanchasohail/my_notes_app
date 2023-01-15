import 'package:flutter/foundation.dart';

import 'note_model.dart';

import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesProvider extends ChangeNotifier {
  List<NoteModel> _notes = [];

  List<NoteModel> get notes {
    return [..._notes];
  }

  Future<void> fetchAndSetNotes() async {
    final notesList = await getData('notes');
    _notes = notesList
        .map((note) => NoteModel(note['id'], note['title'], note['note'],
            DateTime.parse(note['date_time'])))
        .toList();
  }

  NoteModel fetchAndShowNote(String id) {
    final note = notes.firstWhere((element) {
      return element.id == id;
    });
    return note;
  }

  void addNote(String title, String note ) {
    final timeSnapshot = DateTime.now();
    _notes.add(NoteModel(timeSnapshot.toString(), title, note, timeSnapshot));
    insert('notes', {
      'id': timeSnapshot.toString(),
      'title': title,
      'note': note,
      'date_time': timeSnapshot.toIso8601String(),
    });
    if (kDebugMode) {
      print('Note saved in database *****');
    }
    notifyListeners();
  }

  static Future<Database> dataBase() async {
    final databasePath = await getDatabasesPath();
    return await openDatabase(join(databasePath, 'notes_database.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE notes (id TEXT PRIMARY KEY , title TEXT , note TEXT , date_time TEXT)');
    }, version: 1);
  }

  Future<void> insert(String table, Map<String, dynamic> notes) async {
    final db = await dataBase();
    db.insert(table, notes, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await dataBase();
    return db.query(table);
  }

  void updateNote(String id, String title, String note) {
    final thisNote = notes.firstWhere((element) => element.id == id);

    // var submitAbleNote = NoteModel(id, title, note, thisNote.time);
    Map<String, dynamic> submitAbleNote = {
      'id': id,
      'title': title,
      'note': note,
      'date_time': thisNote.time.toIso8601String(),
    };

    updateInDatabase(id, submitAbleNote);
    notifyListeners();
  }

  Future<void> updateInDatabase(
      String id, Map<String, dynamic> updatedNote) async {

    final db = await dataBase();
    // db.update('notes', updatedNote, where: 'id = $id');

    db.rawUpdate('UPDATE notes SET title = ? , note = ? WHERE id = ?',
        [updatedNote['title'], updatedNote['note'] , updatedNote['id']]);

    if (kDebugMode) {
      print('updated notes ****');
    }

    notifyListeners();
  }

  void deleteNote(String id){
    notes.removeWhere((element) => element.id == id );
    deleteFormDatabase(id);
    notifyListeners();
  }
  
  Future<void> deleteFormDatabase(String id) async {
    final db = await dataBase();
    db.delete('notes' , where: 'id = ?' , whereArgs: [id]);
    if (kDebugMode) {
      print('Note deleted form database');
    }
  }

}
