import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_testlab_detector/firebase_testlab_detector_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelFirebaseTestlabDetector platform =
      MethodChannelFirebaseTestlabDetector();
  const MethodChannel channel = MethodChannel('firebase_testlab_detector');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (methodCall) async => true);
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('isAppRunningInTestlab', () async {
    expect(await platform.isAppRunningInTestlab(), true);
  });
}
