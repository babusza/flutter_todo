import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_todo/models/TodoItems.dart';
import 'package:flutter_todo/screens/addtodo/add_todo.dart';

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
    super.initState();
    lists.add(TodoItem(id: 1, name: "Buy Milk", isComplete: false));
    lists.add(TodoItem(id: 2, name: "Go To Gym", isComplete: false));
    lists.add(TodoItem(id: 3, name: "Haircut", isComplete: false));
    lists.add(TodoItem(id: 4, name: "Write Flutter Puggin", isComplete: false));
    lists.add(TodoItem(id: 5, name: "Read Book", isComplete: true));
    lists.add(
        TodoItem(id: 6, name: "Book flight to Singapoge", isComplete: true));
    lists.add(
        TodoItem(id: 7, name: "Prepare Flutter slides", isComplete: false));
  }

  void _updateTodoCompleteStatus(TodoItem item, bool newStatus) {
    final tempTodoItems = lists;
    tempTodoItems.firstWhere((i) => i.id == item.id).isComplete = newStatus;
    setState(() {
      lists = tempTodoItems;
    });
  }

  Widget _createTodoItemWidget(TodoItem item) {
    return ListTile(
      title: Text(item.name),
      trailing: Checkbox(
        value: item.isComplete,
        onChanged: (value) => _updateTodoCompleteStatus(item, value),
      ),
    );
  }

  void _addTodoItem() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddTodoItemScreen()));
  }

  @override
  Widget build(BuildContext context) {
    lists.sort();
    final todoItemWidgets = lists.map(_createTodoItemWidget).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: todoItemWidgets,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodoItem,
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }
}
