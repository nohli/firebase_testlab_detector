import 'package:flutter/foundation.dart';

import 'firebase_testlab_detector_platform_interface.dart';

class FirebaseTestlabDetector {
  const FirebaseTestlabDetector._();

  /// This method returns true if the app is running in Firebase Test Lab.
  ///
  /// Only works on Android. Returns false on other platforms.
  static Future<bool> isAppRunningInTestlab() async {
    final isAndroid =
        !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
    if (!isAndroid) return false;

    return FirebaseTestlabDetectorPlatform.instance.isAppRunningInTestlab();
  }
}
