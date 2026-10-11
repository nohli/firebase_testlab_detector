import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_testlab_detector/firebase_testlab_detector.dart';
import 'package:firebase_testlab_detector/firebase_testlab_detector_platform_interface.dart';
import 'package:firebase_testlab_detector/firebase_testlab_detector_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFirebaseTestlabDetectorPlatform with MockPlatformInterfaceMixin implements FirebaseTestlabDetectorPlatform {
  bool? value;
  int calls = 0;
  @override
  Future<bool?> isAppRunningInTestlab() async {
    calls++;
    return value;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final initialPlatform = FirebaseTestlabDetectorPlatform.instance;
  late MockFirebaseTestlabDetectorPlatform fake;
  setUp(() {
    fake = MockFirebaseTestlabDetectorPlatform();
    FirebaseTestlabDetectorPlatform.instance = fake;
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
  });
  tearDown(() {
    FirebaseTestlabDetectorPlatform.instance = initialPlatform;
    debugDefaultTargetPlatformOverride = null;
  });
  test('method channel is the default instance', () {
    expect(initialPlatform, isA<MethodChannelFirebaseTestlabDetector>());
  });
  for (final value in [true, false, null]) {
    test('Android returns $value from the platform implementation', () async {
      fake.value = value;
      expect(await FirebaseTestlabDetector.isAppRunningInTestlab(), value);
      expect(fake.calls, 1);
    });
  }
  for (final target in TargetPlatform.values.where((value) => value != TargetPlatform.android)) {
    test('$target does not call the Android implementation', () async {
      debugDefaultTargetPlatformOverride = target;
      expect(await FirebaseTestlabDetector.isAppRunningInTestlab(), isNull);
      expect(fake.calls, 0);
    });
  }
}
