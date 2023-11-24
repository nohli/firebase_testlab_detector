import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'firebase_testlab_detector_method_channel.dart';

abstract class FirebaseTestlabDetectorPlatform extends PlatformInterface {
  /// Constructs a FirebaseTestlabDetectorPlatform.
  FirebaseTestlabDetectorPlatform() : super(token: _token);

  static final Object _token = Object();

  static FirebaseTestlabDetectorPlatform _instance =
      MethodChannelFirebaseTestlabDetector();

  /// The default instance of [FirebaseTestlabDetectorPlatform] to use.
  ///
  /// Defaults to [MethodChannelFirebaseTestlabDetector].
  static FirebaseTestlabDetectorPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FirebaseTestlabDetectorPlatform] when
  /// they register themselves.
  static set instance(FirebaseTestlabDetectorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool?> isAppRunningInTestlab() {
    throw UnsupportedError(
      'Use the implementation method of FirebaseTestlabDetectorPlatform.',
    );
  }
}
