class Tarea {
  String title,detail;
  int id;
  bool realizado;
  Tarea.fromJson(json){
    title = json["title"];
    detail = json["detail"];
    id = json["id"];
    realizado=false;
  }

  Tarea();

  Map json() =>{
    "title": title,
    "detail": detail
  };

  @override
  String toString() {
    return 'Tarea{title: $title, detail: $detail, id: $id, realizado: $realizado}';
  }

  void complete(){
    realizado = true;
  }
}