# Kanban Task Management App

A feature-rich Flutter application implementing a Kanban board system for task and project management, built with clean architecture principles and MVVM pattern.

## ✨ Features

### 🎯 Project Management
- Multi-project support
- Project switching
- Organized task boards

### 📋 Task Management  
- CRUD operations for tasks
- Status tracking (Open/In Progress/Done)
- Task details & due dates
- Task commenting system

### ⏱️ Time Tracking
- Built-in task timer
- Individual task time logging
- Time tracking history

### 🎨 Customization
- Light/Dark themes

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (Latest stable)
- Dart SDK
- Android Studio/VS Code with Flutter plugins

### Installation
```bash
# Clone repo
git clone https://github.com/yourusername/kanban_app.git

# Install dependencies
cd kanban_app
flutter pub get

# Run app
flutter run
```

## 💻 Technical Stack

- **UI Framework**: Flutter
- **State Management**: Stacked
- **API Client**: Dio
- **Local Storage**: Hive

## 🏗️ Architecture

### Clean Architecture
The app implements clean architecture with distinct layers:
- **Domain Layer**: Business logic and entities
- **Data Layer**: Repositories and data sources 
- **Presentation Layer**: UI and ViewModels

### MVVM Pattern
- **Model**: Business logic and data
- **View**: UI components
- **ViewModel**: State management and business logic bridge

### Key Principles
- Separation of concerns
- Dependency injection
- Repository pattern
- Reactive state management

## 📱 Usage

### Home Page
The Home Page provides a comprehensive overview of your task management:

<img src="https://github.com/user-attachments/assets/fa79c486-3093-4134-8015-9038520acba6" width="150" />
<img src="https://github.com/user-attachments/assets/832ea89a-fdcf-49fa-9b70-3fe43c705c05" width="150" />
<img src="https://github.com/user-attachments/assets/a38c25de-a66d-4ed3-97bc-3de3dd0755e5" width="150" />

- **Project Header**: Create new projects or access existing ones via "My Projects"
- **Task Overview**: 
  - Quick view of total tasks count
  - Visual task distribution in a donut chart showing:
    - Open tasks (Blue)
    - In Progress tasks (Yellow) 
    - Completed tasks (Green)
- **Task Statistics**: Real-time percentage breakdown of task statuses
- **Completed Tasks Section**: Lists recently completed tasks with:
  - Due dates
  - Time spent on each task

### Task Board

The Task Board offers a classic Kanban view with three columns:
- **OPEN**: New and unstarted tasks (Blue)
- **IN PROGRESS**: Tasks currently being worked on (Yellow)
- **DONE**: Completed tasks (Green)

<img src="https://github.com/user-attachments/assets/bb84b7de-4caa-4ea4-bcf1-f29f82f6f2eb" width="150" />
<img src="https://github.com/user-attachments/assets/85b0a5bc-cd63-416d-85a4-e3619ba71701" width="150" />
<img src="https://github.com/user-attachments/assets/b47bdcab-be80-4d7c-b9c3-e094fe729011" width="150" />
<img src="https://github.com/user-attachments/assets/9c59b80a-ac01-4996-9364-741c07f129d1" width="150" />
<img src="https://github.com/user-attachments/assets/cc93d8f8-b816-4cb0-b191-0dae7c889cdb" width="150" />

#### Features:
- **Task Cards** show:
  - Task title
  - Due date (if set)
  - Time spent tracking
  - Status indicator dot
- **Quick Add**: Floating "Add Task" button for creating new tasks
- **Status Management**: 
  - Tasks move between columns as their status changes
  - Color-coded indicators for easy status recognition
- **Details View**: Tap any task to view/edit full details and comments

### Time Tracker

The Time Tracker allows precise time tracking for tasks:

<img src="https://github.com/user-attachments/assets/4f1a6cf8-899f-42ac-b92a-b53dc28ed92a" width="150" />
<img src="https://github.com/user-attachments/assets/7ff2a782-d7db-405e-97d7-c0f67ad2900d" width="150" />
<img src="https://github.com/user-attachments/assets/c27838e2-47be-4a67-89ac-05d8dc0d5de7" width="150" />
<img src="https://github.com/user-attachments/assets/344234d5-8b04-4e0a-bf83-ffd6fa710f8e" width="150" />

#### Key Features
- **Task Selection**: Choose any task from your board to track time
- **Timer Controls**: 
  - Play button to start timing
  - Pause button to temporarily stop
  - Timer display showing HH:MM:SS
- **Recent Trackings**:
  - List of recently timed tasks
  - Color-coded status indicators
  - Total time spent per task
  - Chronological tracking history

### Settings

The Settings page offers customization options:

<img src="https://github.com/user-attachments/assets/c191758d-027b-41a7-8cf9-707861c39a23" width="150" />

#### Theme Selection
- **Light Theme**: Default bright interface
- **Dark Theme**: Reduced eye strain in low light
- Theme changes apply instantly throughout the app

<img src="https://github.com/user-attachments/assets/35aceaf0-921a-46c1-92bf-141252cb10ea" width="150" />
<img src="https://github.com/user-attachments/assets/b9f2add0-a4ee-452f-885b-9f5706bee6b4" width="150" />
<img src="https://github.com/user-attachments/assets/bf8bcebd-561b-411c-9d4d-8a61d37dfe63" width="150" />
<img src="https://github.com/user-attachments/assets/d814ee54-2f19-493e-ab24-7f5c70df4889" width="150" />

#### Theme Features
- System-wide theme application
- Persistent theme selection
- Optimized color palettes for both modes
- Status colors remain consistent across themes
