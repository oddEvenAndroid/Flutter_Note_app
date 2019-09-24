class Note {
  List<Notes> note;
}

class Notes {
  String id;
  String title;
  String content;

  Notes({
    this.id,
    this.title,
    this.content,
  });

  factory Notes.fromJson(Map<String, dynamic> json) {
    return Notes(
      id: json["_id"],
      title: json["title"],
      content: json["content"],
    );
  }
}
