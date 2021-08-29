import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Tarea.dart';
import 'apiUrl.dart' as api;
import 'modelo.dart';


class Repositorio {
  Future<List <Tarea>>getRepositorio()async{
    print("Entre a la función");
   // try{
      List<Tarea>tareas=List();
      var url=api.url + "tasks";
      //var url = Uri.https("www.localhost:3000", '/tasks', {'q': '{http}'});
      //var token=await Token().getToken();
      final response = await http.get(url,
         // headers: <String,String>{
           // 'Content-Type':'application/json; charset=UTF-8',
            //'Authorization':token
          //}
      );
      print("response");
      print(response);
      List modelo= json.decode(utf8.decode(response.bodyBytes));
      modelo.forEach((element) {
       /* Modelo newModelo=Modelo();
        newModelo.id=element["id"];
        newModelo.title=element["title"];
        newModelo.description=element["detail"];*/
       Tarea task = new Tarea.fromJson(element);
        tareas.add(task);
      });
      print(modelo);
      if(response.statusCode==200){
        return tareas;
      }
      else{
        return null;
      }
    //}
   // catch(e){
    //  print(e);
    //}
  }
  Future addTask (Tarea task) async{
    print(task.toString());
    var url=api.url + "tasks";
    final response = await http.post(url,
      body: jsonEncode(task.json()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if(response.statusCode==200){
      task.id=jsonDecode(response.body)["id"];
      return true;
    }
    else{
      return false;
    }
  }

  Future updateTask (Tarea task) async{
    print(task.toString());
    var url=api.url + "tasks/${task.id}";
    final response = await http.put(url,
      body: jsonEncode(task.json()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if(response.statusCode==200){
      return true;
    }
    else{
      return false;
    }
  }
  Future deleteTask (Tarea task) async{
    print(task.toString());
    var url=api.url + "tasks/${task.id}";
    final response = await http.delete(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if(response.statusCode==200){
      return true;
    }
    else{
      return false;
    }
  }
}