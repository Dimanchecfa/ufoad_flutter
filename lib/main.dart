import 'package:flutter/material.dart';
import 'package:ufoad_flutter/views/SplashScreen.dart';
import 'package:ufoad_flutter/models/TaskModel.dart';
import 'package:ufoad_flutter/views/TaskInputPage.dart';
import 'package:ufoad_flutter/views/TaskItem.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
// date

void main() {
  runApp(TaskApp());
}

class TaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       home: SplashScreen(),
      routes: {
        '/listTask': (context) => TaskListPage(),
      },
    );
  }
}

class TaskListPage extends StatefulWidget {
  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  void loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tasks = Task.fromSharedPreferences(prefs);
    });
  }

  void addTask(String newTask) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Task task = Task(title: newTask);
    tasks.add(task);
    await task.saveToSharedPreferences(prefs);
    setState(() {});
  }

  void removeTask(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tasks.removeAt(index);
    await Task.saveListToSharedPreferences(prefs, tasks);
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Tâche supprimée'),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des tâches', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: tasks.isEmpty
    ? const Center(
        child:  Text('Aucune tâche pour le moment'),
      )
    : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return TaskListItem(
            task: tasks[index],
            onDelete: () => removeTask(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskInputPage(addTask)),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
