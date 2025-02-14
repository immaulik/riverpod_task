import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import '../database/database_helper.dart';

final taskViewModelProvider = StateNotifierProvider<TaskViewModel, List<Task>>((ref) {
  return TaskViewModel();
});

class TaskViewModel extends StateNotifier<List<Task>> {
  TaskViewModel() : super([]);

  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> loadTasks() async {
    state = await _dbHelper.getTasks();
  }

  Future<void> addTask(Task task) async {
    await _dbHelper.insertTask(task);
    loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await _dbHelper.updateTask(task);
    loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await _dbHelper.deleteTask(id);
    loadTasks();
  }
}