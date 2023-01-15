import 'package:flutter/foundation.dart';

import 'note_model.dart';

import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesProvider extends ChangeNotifier {
  List<NoteModel> _notes = [];
  List<NoteModel> _importantNotes = [];

  List<NoteModel> get notes {
    return [..._notes];
  }

  List<NoteModel> get importantNotes {
    return [..._importantNotes];
  }

  Future<void> fetchAndSetNotes() async {
    final notesList = await getData('notes');
    // _notes = notesList
    //     .map((note) => NoteModel(note['id'], note['title'], note['note'],
    //         DateTime.parse(note['date_time']) , false))
    //     .toList();

    _notes = notesList.map((note) {
      bool important = false;
      if (note['important'] == 'true') {
        important = true;
      }
      return NoteModel(note['id'], note['title'], note['note'],
          DateTime.parse(note['date_time']), important);
    }).toList();
  }

  Future<void> fetchAndSetImportantNotes() async {
    final notesList = await getData('notes');

    // final db = await dataBase();
    // final notesList =  db.rawQuery('SELECT * FROM notes WHERE important = ? ' , ['true']) ;

    _importantNotes = notesList.map((note) {
      bool important = false;
      if (note['important'] == 'true') {
        important = true;
      }
      return NoteModel(note['id'], note['title'], note['note'],
          DateTime.parse(note['date_time']), important);
    }).toList();
  }

  NoteModel fetchAndShowNote(String id) {
    final note = notes.firstWhere((element) {
      return element.id == id;
    });
    return note;
  }

  void addNote(String title, String note) {
    final timeSnapshot = DateTime.now();
    _notes.add(
        NoteModel(timeSnapshot.toString(), title, note, timeSnapshot, false));
    insert('notes', {
      'id': timeSnapshot.toString(),
      'title': title,
      'note': note,
      'date_time': timeSnapshot.toIso8601String(),
      'important': 'false'
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
          'CREATE TABLE notes (id TEXT PRIMARY KEY , title TEXT , note TEXT , date_time TEXT , important TEXT )');
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
      'important': thisNote.important.toString(),
    };

    updateInDatabase(id, submitAbleNote);
    notifyListeners();
  }

  Future<void> updateInDatabase(
      String id, Map<String, dynamic> updatedNote) async {
    final db = await dataBase();
    // db.update('notes', updatedNote, where: 'id = $id');

    db.rawUpdate(
        'UPDATE notes SET title = ? , note = ? , important = ? WHERE id = ?', [
      updatedNote['title'],
      updatedNote['note'],
      updatedNote['important'],
      updatedNote['id']
    ]);

    if (kDebugMode) {
      print('updated notes ****');
    }

    notifyListeners();
  }

  void deleteNote(String id) {
    notes.removeWhere((element) => element.id == id);
    deleteFormDatabase(id);
    notifyListeners();
  }

  Future<void> deleteFormDatabase(String id) async {
    final db = await dataBase();
    db.delete('notes', where: 'id = ?', whereArgs: [id]);
    if (kDebugMode) {
      print('Note deleted form database');
    }
  }

  Future<void> shuffleImportant(String id, bool important) async {
    String imp = important.toString();

    final db = await dataBase();

    db.rawUpdate('UPDATE notes SET important = ? WHERE id = ?', [imp, id]);

    if (kDebugMode) {
      print('favorite shuffled');
    }
  }
}
