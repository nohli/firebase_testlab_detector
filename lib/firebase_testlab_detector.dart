import 'package:flutter/foundation.dart';

import 'firebase_testlab_detector_platform_interface.dart';

/// Detects the Android system setting used by Firebase Test Lab.
class FirebaseTestlabDetector {
  const FirebaseTestlabDetector._();

  /// This method returns true if the app is running in Firebase Test Lab.
  ///
  /// Only works on Android. Returns null on other platforms.
  ///
  /// You can use `?? false` to treat it as false on other platforms.
  /// Platform errors and missing plugin registration propagate to the caller.
  static Future<bool?> isAppRunningInTestlab() async {
    final isAndroid = !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
    if (!isAndroid) return null;

    return FirebaseTestlabDetectorPlatform.instance.isAppRunningInTestlab();
  }
}
