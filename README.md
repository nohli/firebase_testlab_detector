# firebase_testlab_detector

A Flutter plugin for Android that helps determine if your app is running within Firebase Test Lab. Use this to differentiate between regular usage and test runs in Firebase Test Lab (i.e., during Google Play pre-launch reports).

## Getting Started

### 1. Add the dependency

```shell
flutter pub add firebase_testlab_detector
```

### 2. Use the plugin

```dart
final isRunningInTestLab = await FirebaseTestlabDetector.isAppRunningInTestlab();
```

This plugin reads the system property `firebase.test.lab`, and returns a boolean value indicating whether the app is running in Firebase Test Lab.

See also the [Firebase documentation](https://firebase.google.com/docs/test-lab/android/android-studio#modify_instrumented_test_behavior_for) for more details.

## Why use this plugin?

You might want to utilize this plugin to disable analytics, preventing skewed data from Firebase Test Lab (i.e., Google Play pre launch report) from appearing in your analytics dashboard.
