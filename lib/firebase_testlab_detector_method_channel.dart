import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'firebase_testlab_detector_platform_interface.dart';

/// An implementation of [FirebaseTestlabDetectorPlatform] that uses method channels.
class MethodChannelFirebaseTestlabDetector
    extends FirebaseTestlabDetectorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('firebase_testlab_detector');

  @override
  Future<bool?> isAppRunningInTestlab() async {
    final isRunningInTestlab =
        await methodChannel.invokeMethod<bool>('isAppRunningInTestlab');
    return isRunningInTestlab;
  }
}
