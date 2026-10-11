import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_testlab_detector/firebase_testlab_detector_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final platform = MethodChannelFirebaseTestlabDetector();
  const channel = MethodChannel('firebase_testlab_detector');
  final messenger = TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  tearDown(() => messenger.setMockMethodCallHandler(channel, null));
  for (final value in [true, false, null]) {
    test('native result $value is preserved', () async {
      messenger.setMockMethodCallHandler(channel, (call) async {
        expect(call.method, 'isAppRunningInTestlab');
        expect(call.arguments, isNull);
        return value;
      });
      expect(await platform.isAppRunningInTestlab(), value);
    });
  }
  test('platform errors propagate', () async {
    messenger.setMockMethodCallHandler(channel, (_) async => throw PlatformException(code: 'lookup_failed'));
    await expectLater(platform.isAppRunningInTestlab(), throwsA(isA<PlatformException>()));
  });
  test('missing registration propagates', () async {
    await expectLater(platform.isAppRunningInTestlab(), throwsA(isA<MissingPluginException>()));
  });
}
