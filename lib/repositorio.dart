import 'dart:convert';
import 'package:http/http.dart' as http;
import 'apiUrl.dart' as api;
import 'modelo.dart';


class Repositorio {
  Future<List <Modelo>>getRepositorio()async{
    print("Entre a la función");
   // try{
      List<Modelo>modelos=List();
      //var url=api.url + "tasks";
      var url = Uri.https("www.localhost:3000", '/tasks', {'q': '{http}'});
      //var token=await Token().getToken();
      final response = await http.get("http://localhost:3000/tasks"
          //headers: <String,String>{
           // 'Content-Type':'application/json; charset=UTF-8',
            //'Authorization':token
         // }
      );
      print("response");
      print(response);
      List modelo= json.decode(utf8.decode(response.bodyBytes));
      modelo.forEach((element) {
        Modelo newModelo=Modelo();
        newModelo.id=element["id"];
        newModelo.title=element["title"];
        newModelo.description=element["detail"];
        modelos.add(newModelo);
      });
      print(modelo);
      if(response.statusCode==200){
        return modelos;
      }
      else{
        return null;
      }
    //}
   // catch(e){
    //  print(e);
    //}
  }
}