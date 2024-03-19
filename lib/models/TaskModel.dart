import 'package:shared_preferences/shared_preferences.dart';

class Task {
  String title;

  Task({required this.title});

  static List<Task> fromSharedPreferences(SharedPreferences prefs) {
    List<String>? titles = prefs.getStringList('taskTitles');
    if (titles == null) {
      return [];
    }
    return List.generate(titles.length, (index) {
      return Task(title: titles[index]);
    });
  }

  static Future<void> saveListToSharedPreferences(
      SharedPreferences prefs, List<Task> tasks) async {
    List<String> titles = tasks.map((task) => task.title).toList();
    await prefs.setStringList('taskTitles', titles);
  }

  Future<void> saveToSharedPreferences(SharedPreferences prefs) async {
    List<Task> existingTasks = fromSharedPreferences(prefs);
    existingTasks.add(this);
    await saveListToSharedPreferences(prefs, existingTasks);
  }
}

