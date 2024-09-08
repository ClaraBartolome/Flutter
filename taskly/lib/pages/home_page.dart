import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/task.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late double _deviceHeight, _deviceWidth;
  String? _newTaskContent;
  Box? _box;

  _HomePageState();

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    //print("input value: $_newTaskContent");
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _deviceHeight * 0.1,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Taskly!",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: _taskView(),
      floatingActionButton: _addFloatingButton(),
    );
  }

  Widget _taskView(){
    /*await and async don't work because with UI don't work
    FutureBuilder does something in the future and builder is whats going to happen
    when the future is resolved*/
    return FutureBuilder(
        future: Hive.openBox("tasks"),
        builder: (BuildContext _contxt, AsyncSnapshot _snapshot) {
          if(_snapshot.hasData){
            _box = _snapshot.data;
            return _taskList();
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
    );
  }

  Widget _taskList() {
    Task task =
        Task(content: "Study italian", timestamp: DateTime.now(), done: false);

    List tasks = _box!.values.toList();
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext _ctx, int _index) {
          Task task = Task.fromMap(tasks[_index]);
          return ListTile(
            title: Text(
              task.content,
              style: task.done ? TextStyle(decoration: TextDecoration.lineThrough) : null,
            ),
            subtitle: Text(task.timestamp.toString()),
            trailing: Icon(
              task.done? Icons.check_box_outlined : Icons.check_box_outline_blank_outlined,
              color: Theme.of(context).primaryColor,
            ),
            onTap: (){
              setState(() {
                task.done = !task.done;
                _box!.putAt(_index, task.toMap());
              });
            },
            onLongPress: (){
              setState(() {
                _box!.deleteAt(_index);
              });
            },
          );
        });
  }

  Widget _addFloatingButton(){
    return FloatingActionButton(onPressed: _displayTaskPopup,
    shape: const CircleBorder(),
    child: const Icon(Icons.add),
    );
  }

  void _displayTaskPopup() {
    showDialog(
      context: context,
      builder: (BuildContext _context) {
        return AlertDialog(
          title: const Text("Add new task!"),
          content: TextField(
            onSubmitted: (value) {
              if(_newTaskContent!= null){
                Task task = Task(
                    content: _newTaskContent!, timestamp: DateTime.now(), done: false);
                _box!.add(task.toMap());
                setState(() {
                  _newTaskContent = null;
                  Navigator.pop(context);
                });
              }
            },
            onChanged: (value) {
              //setState notifies the framework about a state changed
              setState(() {
                _newTaskContent = value;
              });
            },
          ),
        );
      },
    );
  }
}
