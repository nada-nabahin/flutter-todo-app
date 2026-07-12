# 📝 Flutter Todo App

A simple, clean todo app built with Flutter, featuring local data persistence so your tasks are saved even after refreshing or closing the app.

Built as my first Flutter project while learning the fundamentals of state management and local storage.

## Features

- ✅ Add, edit, and delete tasks
- ✅ Mark tasks as complete/incomplete
- ✅ Clear all completed tasks at once
- ✅ Personalized greeting based on time of day
- ✅ Local data persistence using `shared_preferences` — tasks and username are saved across sessions
- ✅ Clean architecture with separated models, services, and screens



## Tech Stack

- **Flutter** — UI framework
- **shared_preferences** — local key-value storage for persisting tasks and user data

## Project Structure
lib/
models/
todo.dart              # Todo data model
services/
todo_storage_service.dart   # Handles saving/loading tasks
screens/
welcome_screen.dart    # Name entry screen
home_screen.dart       # Main todo list screen
widgets/
todo_item.dart         # Individual task UI component
theme/
app_colors.dart        # App color palette
main.dart                # App entry point

## Getting Started

1. Clone the repo:
```bash
   git clone https://github.com/nada-nabahin/flutter-todo-app.git
```
2. Install dependencies:
```bash
   flutter pub get
```
3. Run the app (web):
```bash
   flutter run -d chrome
```

## What I Learned

- Managing state in a StatefulWidget with `setState`
- Persisting data locally on Flutter Web using `shared_preferences`
- Serializing/deserializing custom objects with `toJson`/`fromJson`
- Structuring a Flutter project into models, services, and screens for cleaner, more maintainable code

## Future Improvements

- [ ] Task categories or tags
- [ ] Due dates and reminders
- [ ] Dark/light theme toggle
- [ ] "Change name" option instead of permanent storage