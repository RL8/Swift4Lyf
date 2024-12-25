# Swift4Lyf

## Overview
Swift4Lyf is a personal Taylor Swift content organization app that enables fans (Swifties) to create and manage their rankings of Taylor Swift's discography. The app emphasizes clean design, intuitive interaction, and seamless synchronization across devices.

## Core Features
- Drag-and-drop album ranking interface
- Offline-first functionality
- Cross-device synchronization
- Minimal grayscale design aesthetic
- Version tracking and display

## Technical Stack
- Flutter (stable channel)
- Flutter DND Package for drag-drop functionality
- Riverpod for state management
- Firebase for backend services
- Hive for local storage

## Project Structure
```plaintext
lib/
├── core/
│   ├── constants/
│   │   ├── album_data.dart        # Album information
│   │   ├── app_constants.dart     # App-wide constants
│   │   └── theme_constants.dart   # Design system constants
│   ├── theme/
│   │   ├── app_theme.dart         # Theme configuration
│   │   └── text_styles.dart       # Typography definitions
│   └── utils/
│       ├── firebase_utils.dart    # Firebase helpers
│       └── version_utils.dart     # Version management
├── features/
│   └── album_ranking/
│       ├── data/
│       │   ├── album_repository.dart
│       │   └── local_storage.dart
│       ├── domain/
│       │   ├── models/
│       │   │   └── album.dart
│       │   └── services/
│       │       └── ranking_service.dart
│       └── presentation/
│           ├── screens/
│           │   └── ranking_screen.dart
│           └── widgets/
│               ├── album_card.dart
│               ├── ranking_list.dart
│               └── version_display.dart
├── shared/
│   ├── widgets/
│   │   ├── error_view.dart
│   │   └── loading_view.dart
│   └── providers/
│       └── app_providers.dart
└── main.dart
```

## Version Control Strategy

Version format: V1.X.Y
- 1: Major version (core app version)
- X: Milestone completion (0-2)
- Y: Minor updates within milestone

## Development Environment Setup

1. Flutter SDK (minimum version 3.0.0)
2. Firebase CLI tools
3. Android Studio or VS Code with Flutter plugins
4. Git for version control

## Getting Started

1. Clone repository:
```bash
git clone https://github.com/RL8/Swift4Lyf.git
cd Swift4Lyf
```

2. Install dependencies:
```bash
flutter pub get
```

3. Configure Firebase:
- Create new Firebase project
- Add Android & iOS apps
- Download and place configuration files
- Enable Firestore Database

4. Run the app:
```bash
flutter run
```

## Code Style Guidelines

- Follow official Dart style guide
- Use meaningful variable names
- Comment complex logic
- Document public APIs
- Maximum line length: 80 characters

## Git Workflow

Branch naming:
- `feature/feature-name`
- `bugfix/bug-description`
- `milestone/milestone-number`

Commit messages:
- Start with verb (Add, Update, Fix, etc.)
- Include ticket/issue reference
- Provide clear description

Pull Request Process:
1. Create PR against development branch
2. Include testing evidence
3. Update version number if applicable
4. Request review from team lead

## Current Status
- Version: V1.0.0
- Status: In Development
- Next Milestone: Basic Album Ranking Implementation
