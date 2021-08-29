import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'repositorio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Column(
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
      )
    );
  }
}
class listaTarea extends StatefulWidget {
  const listaTarea({Key key,}): super(key: key);

  @override
  _listaTareaState createState() => _listaTareaState();
}
class _listaTareaState extends State<listaTarea> {

  @override
  Widget build(BuildContext context) {

  }
}

/*
class listaTarea extends StatefulWidget {
  const listaTarea({Key key,}): super(key: key);

  @override
  _listaTareaState createState() => _listaTareaState();
}

class _listaTareaState extends State<listaTarea> {
  List<tareas> _tarea;
  int get _countD => _tarea.where((tareas) => tareas.realizado).length;

  @override
  void initState() {
    _tarea = [];

    super.initState();
  }

  _remove(){
    List<tareas> pending =[];
    for(var tare in _tarea){
      if(!tare.realizado) pending.add(tare);
    }
    setState(() => _tarea = pending);
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
      ).then((borrar){
        if(borrar){
          _remove();
        }
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Tareas Pendientes"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.delete_forever),
              onPressed: _pregRemove)
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
            ).then((que) {
              setState(() {
                _tarea[index]=que;
              });
            });
          } ,
          child: ListTile(
            leading: GestureDetector(
              onTap: (){
                setState(() {
                  _tarea[index].toggleDone();
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
                title: Text(_tarea[index].que,
    style: TextStyle(
    decoration: (_tarea[index].realizado ? TextDecoration.lineThrough:TextDecoration.none),
    ),
              ),
            subtitle: Text(_tarea[index].desc),
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
          ).then((que) {
            setState(() {
              _tarea.add(que);
            });
          });
        },

      ),
    );
  }
}


class tareas {
  String que,desc;
  bool realizado;
  tareas(this.que):realizado=false;

  void toggleDone()=>realizado = !realizado;
}

class nuevaTarea extends StatefulWidget {
  tareas t;
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
      _controller.text=widget.t.que;
      _controller2.text=widget.t.desc;
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
              onSubmitted: (que){
                Navigator.of(context).pop(que);
              },
            ),
            TextField(
              controller: _controller2,
              onSubmitted: (que){
                Navigator.of(context).pop(que);
              },
            ),
            RaisedButton(
              child: Text("Agregar"),
              onPressed: (){
                tareas t=new tareas(_controller.text);
                t.que=_controller.text;
                t.desc=_controller2.text;
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

 */
