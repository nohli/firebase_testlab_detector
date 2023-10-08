import 'firebase_testlab_detector_platform_interface.dart';

class FirebaseTestlabDetector {
  const FirebaseTestlabDetector._();

  static Future<bool> isAppRunningInTestlab() {
    return FirebaseTestlabDetectorPlatform.instance.isAppRunningInTestlab();
  }
}
