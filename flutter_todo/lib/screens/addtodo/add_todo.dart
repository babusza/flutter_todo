import 'package:flutter/material.dart';
import 'package:flutter_todo/models/TodoItems.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AddTodoItemScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _AddTodoItemScreenState();
}

class _AddTodoItemScreenState extends State<AddTodoItemScreen> {
  TextEditingController textCtl = TextEditingController();
  Firestore db = Firestore.instance;
  _addTodoItem() async{
    if(textCtl.text.length>0){
      var data = new Map<String, dynamic>();
      data['id']=1;
      data['name']=textCtl.text;
      data['isComplete']=false;
      db.collection('Todo').add(data);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Add Todo Item")),
        body: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(decoration: InputDecoration(labelText: "Todo Name"),controller: textCtl,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      child: Text("Cancel"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    RaisedButton(
                      child: Text("Save"),
                      onPressed: () {
                        _addTodoItem();
                        Navigator.pop(context);
                      },
                    )
                  ],
                )
              ],
            )
        )
    );
  }
}