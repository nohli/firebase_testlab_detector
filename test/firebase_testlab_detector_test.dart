import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_testlab_detector/firebase_testlab_detector.dart';
import 'package:firebase_testlab_detector/firebase_testlab_detector_platform_interface.dart';
import 'package:firebase_testlab_detector/firebase_testlab_detector_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFirebaseTestlabDetectorPlatform
    with MockPlatformInterfaceMixin
    implements FirebaseTestlabDetectorPlatform {
  @override
  Future<bool> isAppRunningInTestlab() => Future.value(true);
}

void main() {
  final FirebaseTestlabDetectorPlatform initialPlatform =
      FirebaseTestlabDetectorPlatform.instance;

  test('$MethodChannelFirebaseTestlabDetector is the default instance', () {
    expect(
      initialPlatform,
      isInstanceOf<MethodChannelFirebaseTestlabDetector>(),
    );
  });

  test('isAppRunningInTestlab', () async {
    MockFirebaseTestlabDetectorPlatform fakePlatform =
        MockFirebaseTestlabDetectorPlatform();
    FirebaseTestlabDetectorPlatform.instance = fakePlatform;

    expect(await FirebaseTestlabDetector.isAppRunningInTestlab(), true);
  });
}
