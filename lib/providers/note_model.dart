class NoteModel {
  final String id ;
  final String title;

  final String note;

  final DateTime time;

  bool important = false ;

  NoteModel(this.id ,this.title, this.note, this.time , this.important);
}
