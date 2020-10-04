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

- Custom state-management using [Services](https://github.com/gadfly361/flutter_services_example/blob/master/lib/framework/services.dart) and a [services dispatcher](https://github.com/gadfly361/flutter_services_example/blob/master/lib/services/services_event_dispatcher.dart)
  - depends on [Provider](https://pub.dev/packages/provider) and [get_it](https://pub.dev/packages/get_it)
- [Navigation](https://github.com/gadfly361/flutter_services_example/blob/master/lib/services/navigator/service.dart)
- Page transitions with the animation package's [OpenContainer](https://github.com/gadfly361/flutter_services_example/blob/64d0e2ae7c28ee6f43d2c341d383cbb4b274437b/lib/pages/posts/overview/widgets_connector/posts_list.dart#L48)
  - depends on [animations](https://pub.dev/packages/animations)
- [Environment variables](https://github.com/gadfly361/flutter_services_example/blob/master/environment_config.yaml)
  - depends on [environment_config](https://pub.dev/packages/environment_config)
- [Dev](https://github.com/gadfly361/flutter_services_example/blob/master/lib/builds/dev.dart) and [Prod](https://github.com/gadfly361/flutter_services_example/blob/master/lib/builds/prod.dart) builds
- Using [RouteAware](https://github.com/gadfly361/flutter_services_example/blob/master/lib/pages/posts/overview/body_wrapper.dart#L18-L19)
- [Custom fonts](https://github.com/gadfly361/flutter_services_example/blob/master/lib/shared/styles/text_theme.dart)
  - depends on [google_fonts](https://pub.dev/packages/google_fonts)
- Saving to [shared preferences](https://github.com/gadfly361/flutter_services_example/blob/master/lib/services/shared_preferences/service_event_dispatcher.dart)
  - depends on [shared_preferences](https://pub.dev/packages/shared_preferences)
- Use of custom [analysis options](https://github.com/gadfly361/flutter_services_example/blob/master/analysis_options.yaml)
- [Pull to refresh](https://github.com/gadfly361/flutter_services_example/blob/bc4029944b1052bc9beb8633d9e46f6cc281b866/lib/pages/posts/overview/widgets_connector/posts_list.dart#L27)
  - depends on [liquid_pull_to_refresh](https://pub.dev/packages/liquid_pull_to_refresh)
