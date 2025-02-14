import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import '../viewmodels/task_viewmodel.dart';
import '../viewmodels/search_filter_viewmodel.dart';
import 'task_detail_screen.dart';
import 'preferences_screen.dart';
import '../widgets/task_item.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(taskViewModelProvider.notifier).loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(taskViewModelProvider);
    final searchFilterState = ref.watch(searchFilterViewModelProvider);

    // Filter and search logic
    final filteredTasks = tasks.where((task) {
      final matchesSearch = task.title
          .toLowerCase()
          .contains(searchFilterState.searchQuery.toLowerCase());
      final matchesFilter = searchFilterState.filter == 'All' ||
          (searchFilterState.filter == 'Completed' && task.isCompleted) ||
          (searchFilterState.filter == 'Pending' && !task.isCompleted);
      return matchesSearch && matchesFilter;
    }).toList();

    // Check if the screen width is for a tablet
    final isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: TaskSearchDelegate(ref),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PreferencesScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: isTablet
          ? _buildTabletLayout(filteredTasks)
          : _buildPhoneLayout(filteredTasks),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TaskDetailScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildPhoneLayout(List<Task> tasks) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        // Filter Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: ['All', 'Completed', 'Pending'].map((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: FilterChip(
                  label: Text(option),
                  selected:
                      ref.watch(searchFilterViewModelProvider).filter == option,
                  onSelected: (selected) {
                    ref
                        .read(searchFilterViewModelProvider.notifier)
                        .setFilter(option);
                  },
                ),
              );
            }).toList(),
          ),
        ),
        // Task List
        Expanded(
          child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return TaskItem(task: task);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTabletLayout(List<Task> tasks) {
    return Row(
      children: [
        // Task List (Left Side)
        Expanded(
          flex: 2,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              // Filter Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ['All', 'Completed', 'Pending'].map((option) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: FilterChip(
                        label: Text(option),
                        selected:
                            ref.watch(searchFilterViewModelProvider).filter ==
                                option,
                        onSelected: (selected) {
                          ref
                              .read(searchFilterViewModelProvider.notifier)
                              .setFilter(option);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              // Task List
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return TaskItem(task: task);
                  },
                ),
              ),
            ],
          ),
        ),
        // Task Details (Right Side)
        Expanded(
          flex: 3,
          child: Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Center(
              child: Text('Select a task to view details'),
            ),
          ),
        ),
      ],
    );
  }
}

class TaskSearchDelegate extends SearchDelegate<String> {
  final WidgetRef ref;

  TaskSearchDelegate(this.ref);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final tasks = ref.watch(taskViewModelProvider);
    final filteredTasks = tasks.where((task) {
      return task.title.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: filteredTasks.length,
      itemBuilder: (context, index) {
        final task = filteredTasks[index];
        return TaskItem(task: task);
      },
    );
  }
}
