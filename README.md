# Task Manager App

## Description

The **Task Manager App** is a simple and intuitive application designed to help users manage their
tasks efficiently. It allows users to add, edit, delete, and mark tasks as completed or pending. The
app supports both light and dark themes and is optimized for all devices, including phones and
tablets.

## Features
- **Task Management**: Add, edit, delete, and view tasks.
- **Task Status**: Mark tasks as "Completed" or "Pending."
- **Search and Filter**: Search tasks by title and filter by status (All, Completed, Pending).
- **Responsive Design**: Works seamlessly on phones and tablets.
- **Dark and Light Themes**: Switch between themes for better readability.
- **Data Persistence**: Tasks are stored locally using SQLite, and user preferences are saved using Hive.


### **Usage**
Explain how to use the app.

## Usage
1. **Add a Task**:
   - Tap the `+` button on the home screen.
   - Enter the task title and description.
   - Tap "Add Task" to save.

2. **Edit a Task**:
   - Tap on a task in the list.
   - Update the task details.
   - Tap "Update Task" to save changes.

3. **Delete a Task**:
   - Long-press on a task in the list.
   - Confirm deletion.

4. **Mark a Task as Completed**:
   - Tap the checkbox next to a task.

5. **Search and Filter Tasks**:
   - Use the search bar to find tasks by title.
   - Use the filter chips to view tasks by status (All, Completed, Pending).

6. **Switch Themes**:
   - Go to the Preferences screen.
   - Toggle the "Dark Mode" switch.

## Configuration
- **Font Family**: The app uses the **Nunito** font. Ensure the font files are placed in the `assets/fonts` directory.
- **Database**: The app uses **SQLite** for local task storage. No additional setup is required.
- **Preferences**: User preferences (theme, sort order) are stored using **Hive**.

## Acknowledgments
- **Flutter**: For the amazing UI framework.
- **Riverpod**: For state management.
- **SQLite**: For local data storage.
- **Hive**: For storing user preferences.
- **Nunito Font**: For the beautiful typography.