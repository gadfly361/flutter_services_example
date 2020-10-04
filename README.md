# Flutter Services Example

This is an example application meant to illustrate a few ways to program in Flutter.
I am using a personal state-management approach, 'Services', but don't worry, I don't plan to release it and add to the every growing list of state-management solutions.

This example was made with the following flutter and dart versions:
```sh
Flutter 1.20.4 • channel stable • https://github.com/flutter/flutter.git
Framework • revision fba99f6cf9 (3 weeks ago) • 2020-09-14 15:32:52 -0700
Engine • revision d1bc06f032
Tools • Dart 2.9.2
```

## How do I run the app?

### 'Normal' development mode

```sh
# Get dependencies
flutter pub get

# create the environment configuration file
flutter pub run environment_config:generate

# run the application (development)
flutter run -t lib/builds/dev.dart
```

### 'Remote devtools' development mode

```sh
# Get dependencies
flutter pub get

# create the environment configuration file with remoteDevTools enabled
flutter pub run environment_config:generate --remoteDevTools=true

# install remotedev-server
npm install -g remotedev-server

# run the remotedev-server
remotedev --port 8000

# open a browser and go to `http://localhost:8000`

# run the application (development)
flutter run -t lib/builds/dev.dart
```

## What does this example cover?

