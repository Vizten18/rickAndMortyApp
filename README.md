# Rick And Morty App
---

## Overview

Rick And Morty App is an application that uses the Rick and Morty API to display information about the characters. The application is developed in Flutter and supports multiple platforms such as iOS and Android.

## Requirements

- Flutter 3.27.4

## Getting Started 🚀

This project contains 3 flavors

- development
- staging
- production

To run the desired flavor, use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

---

## Running Tests 🧪

To run all unit and widget tests use the following command:

```sh
$ flutter test --coverage --test-randomize-ordering-seed random
```

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

---

## Technical Decisions

Shared preferences have been chosen for caching data when paginating characters and also for saving favorite characters. Additionally, a functional programming structure and clean architecture have been implemented.

## Data Layer
The data layer is responsible for:

Fetching data from remote sources (e.g., Rick and Morty API).
- Caching data using shared preferences.
- Converting raw data into domain entities.

Domain Layer
The domain layer is responsible for:
- Implementing use cases that coordinate between the data layer and the presentation layer.
- Defining entities and repositories interfaces.

## Presentation Layer
The presentation layer is responsible for:

- Displaying data to the user.
- Handling user interactions.
- Managing state using state management solutions (e.g., Provider, Bloc).
