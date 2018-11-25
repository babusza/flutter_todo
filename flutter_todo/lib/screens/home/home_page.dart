import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_todo/models/TodoItems.dart';
import 'package:flutter_todo/screens/addtodo/add_todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TodoItem> lists = List<TodoItem>();

  @override
  void initState() {
    super.initState();/*
    lists.add(TodoItem(id: 1, name: "Buy Milk", isComplete: false));
    lists.add(TodoItem(id: 2, name: "Go To Gym", isComplete: false));
    lists.add(TodoItem(id: 3, name: "Haircut", isComplete: false));
    lists.add(TodoItem(id: 4, name: "Write Flutter Puggin", isComplete: false));
    lists.add(TodoItem(id: 5, name: "Read Book", isComplete: true));
    lists.add(
        TodoItem(id: 6, name: "Book flight to Singapoge", isComplete: true));
    lists.add(
        TodoItem(id: 7, name: "Prepare Flutter slides", isComplete: false));*/
  }

  void _updateTodoCompleteStatus(TodoItem item) {
    /*final tempTodoItems = lists;
    tempTodoItems.firstWhere((i) => i.id == item.id).isComplete = newStatus;
    setState(() {
      lists = tempTodoItems;
    });*/
    var data = new Map<String, dynamic>();
    data['id']=item.id;
    data['name']=item.name;
    data['isComplete']=!item.isComplete;
    item.reference.setData(data);
  }

  Widget _createTodoItemWidget(TodoItem item) {
    return ListTile(
      title: Text(item.name),
      trailing: Checkbox(
        value: item.isComplete,
    //    onChanged: (value) => _updateTodoCompleteStatus(item, value),
      ),
    );
  }

  void _addTodoItem() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddTodoItemScreen()));
  }

  _buildRow(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('Todo')
          .orderBy('isComplete')
          .snapshots(),
      builder: (context, snapshot) {
        print(!snapshot.hasData);
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<TodoItem> _todos = snapshot.map((documentSnapshot) => TodoItem.fromSnapshot(documentSnapshot)).toList();
    return ListView.builder(
      itemCount: snapshot.length,
      itemBuilder: (BuildContext context, int index){
        return GestureDetector(
       //   onLongPress: () => _tapRow(_todos[index]),
          onLongPress: () => _updateTodoCompleteStatus(_todos[index]),
          child: CheckboxListTile(
            value: _todos[index].isComplete,
            title: Text( _todos[index].name),
          ),
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    lists.sort();
   final todoItemWidgets = _buildRow(context);// lists.map(_createTodoItemWidget).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: todoItemWidgets,
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodoItem,
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }
}
