import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: listaTarea()
    );
  }
}
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
    _tarea = [
      tareas("Primera tarea"),
    ];

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
            setState(() {
              _tarea[index].toggleDone();
            });
          } ,
          child: ListTile(
            leading: Checkbox(
                value: _tarea[index].realizado,
                onChanged: (checked){
                  setState(() {
                    _tarea[index].realizado = checked;
                  });
                }
            ),
                title: Text(_tarea[index].que,
    style: TextStyle(
    decoration: (_tarea[index].realizado ? TextDecoration.lineThrough:TextDecoration.none),
    ),
              ),
      ),
        ),
    ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_)=>nuevaTarea(),
              )
          ).then((que) {
            setState(() {
              _tarea.add(tareas(que));
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
  @override
  _nuevaTareaState createState() => _nuevaTareaState();
}

class _nuevaTareaState extends State<nuevaTarea> {
  TextEditingController _controller;
  @override
  void initState() {
    _controller=TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
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
            RaisedButton(
              child: Text("Agregar"),
              onPressed: (){
                Navigator.of(context).pop(_controller.text);
              },

                ),
          ],
        ),
      ),
    );
  }
}
