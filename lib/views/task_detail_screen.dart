import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import '../viewmodels/task_viewmodel.dart';

class TaskDetailScreen extends ConsumerStatefulWidget {
  final Task? task;

  const TaskDetailScreen({super.key, this.task});

  @override
  ConsumerState<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends ConsumerState<TaskDetailScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final task = Task(
                    id: widget.task?.id,
                    title: _titleController.text,
                    description: _descriptionController.text,
                    date: DateTime.now(),
                  );
                  if (widget.task == null) {
                    ref.read(taskViewModelProvider.notifier).addTask(task);
                  } else {
                    ref.read(taskViewModelProvider.notifier).updateTask(task);
                  }
                  Navigator.pop(context);
                },
                child: Text(widget.task == null ? 'Add Task' : 'Update Task'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}