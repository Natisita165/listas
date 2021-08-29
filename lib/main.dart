import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Tarea.dart';
import 'repositorio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: listaTarea(),
      /*Column(
        children: <Widget>[
          MaterialButton(
            onPressed: (){
              print("boton");
              Repositorio repositorio = Repositorio();
              repositorio.getRepositorio();
            },
            child: Text("data"),
            color: Colors.red,
            
          )
        ],
      )*/
    );
  }
}


class listaTarea extends StatefulWidget {
  const listaTarea({Key key,}): super(key: key);

  @override
  _listaTareaState createState() => _listaTareaState();
}

class _listaTareaState extends State<listaTarea> {
  List<Tarea> _tarea;
  int get _countD => _tarea.where((tareas) => tareas.realizado).length;
  Repositorio rep;
  void obtenerTareas() async{
    var te=await rep.getRepositorio();
    setState(() {
      _tarea = te;
    });
}
  @override
  void initState() {
    _tarea = [];
    rep = new Repositorio();
    obtenerTareas();

    super.initState();
  }

  _remove()async{
    List<Tarea> pending =[];
    var nt=true;
    for(var tare in _tarea){
      if(!tare.realizado) {
        pending.add(tare);
      }else{
        nt = await rep.deleteTask(tare);
        if(nt==false){
          break;
        }
      }
    }
    if(nt==true) {
      setState(() => _tarea = pending);
    }
  }
  @override
  Widget build(BuildContext context) {
    _pregRemove(){
      if(_countD==0){
        return;
      }
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Elminar Tarea"),
            content: Text("Seguro de borrar la tarea?"),
            actions: <Widget>[
              FlatButton(
                  onPressed: (){
                    Navigator.of(context).pop(true);
                  },
                  child: Text("Aceptar"),
              ),
              FlatButton(
                  onPressed: (){
                    Navigator.of(context).pop(false);
                  },
                  child: Text("Cancelar"),
              ),
            ],
          ),
      ).then((borrar)async{
        if(borrar){
          await _remove();
        }
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Tareas Pendientes"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.delete_forever),
              onPressed: _pregRemove),
          IconButton(icon: Icon(Icons.cloud_download),
              onPressed: obtenerTareas)
        ],
      ),
      body: ListView.builder(
          itemCount: _tarea.length,
        itemBuilder: (context, index)=>InkWell(
          onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_)=>nuevaTarea(_tarea[index]),
                )
            ).then((que) async{
              que.id=_tarea[index].id;
              var nt=await rep.updateTask(que);
              if(nt==true){
              setState(() {
                _tarea[index]=que;
              });
            }});
          } ,
          child: ListTile(
            leading: GestureDetector(
              onTap: (){
                setState(() {
                  _tarea[index].complete();
                  //_tarea[index].toggleDone();
                });
              } ,
              child: Checkbox(
                value: _tarea[index].realizado,
                onChanged: (checked){
                  setState(() {
                    _tarea[index].realizado = checked;
                  });
                },

              ),
            ),
                title: Text(_tarea[index].title,
    style: TextStyle(
    decoration: (_tarea[index].realizado ? TextDecoration.lineThrough:TextDecoration.none),
    ),
              ),
            subtitle: Text(_tarea[index].detail),
      ),
        ),
    ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_)=>nuevaTarea(null),
              )
          ).then((que) async{
            var nt = await rep.addTask(que);
            if(nt==true){
            setState(() {
              _tarea.add(que);
            });
          }
          }
          );
        },

      ),
    );
  }
}




class nuevaTarea extends StatefulWidget {
  Tarea t;
  nuevaTarea(this.t);
  @override
  _nuevaTareaState createState() => _nuevaTareaState();
}

class _nuevaTareaState extends State<nuevaTarea> {
  TextEditingController _controller;
  TextEditingController _controller2;
  @override
  void initState() {
    _controller=TextEditingController();
    _controller2=TextEditingController();
    if(widget.t != null){
      _controller.text=widget.t.title;
      _controller2.text=widget.t.detail;
    }
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ingresar nueva tarea"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
             /* onSubmitted: (que){
                Navigator.of(context).pop(que);
              },*/
            ),
            TextField(
              controller: _controller2,
              /*onSubmitted: (que){
                Navigator.of(context).pop(que);
              },*/
            ),
            RaisedButton(
              child: Text("Agregar"),
              onPressed: (){
                Tarea t=new Tarea();
                t.title=_controller.text;
                t.detail=_controller2.text;
                t.realizado = false;
               // Navigator.of(context).pop(_controller.text);
               // Navigator.of(context).pop(_controller2.text);
                Navigator.of(context).pop(t);
              },

                ),
          ],
        ),
      ),
    );
  }

}
class tarea{
  String _titulo, _descr;

  String get titulo => _titulo;

  set titulo(String value) {
    _titulo = value;
  }

  get descr => _descr;

  set descr(value) {
    _descr = value;
  }
}


