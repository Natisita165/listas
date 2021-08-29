class Modelo {
  int _id;
  String _title;
  String _description;

  Modelo();

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
  Map toJson() => {
    "title":id,
    "detail":description,
    "id":id,
  };

}
