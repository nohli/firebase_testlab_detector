import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_testlab_detector_example/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('firebase_testlab_detector');
  final messenger = TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  tearDown(() => messenger.setMockMethodCallHandler(channel, null));
  for (final value in [true, false, null]) {
    testWidgets('displays native Test Lab result $value', (tester) async {
      messenger.setMockMethodCallHandler(channel, (_) async => value);
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      expect(
        find.text(
          value == true ? 'This app runs in Firebase Test Lab.' : 'This app does not run in Firebase Test Lab.',
        ),
        findsOneWidget,
      );
    });
  }
  for (final error in [PlatformException(code: 'lookup_failed'), MissingPluginException()]) {
    testWidgets('handles ${error.runtimeType}', (tester) async {
      messenger.setMockMethodCallHandler(channel, (_) async => throw error);
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.text('This app does not run in Firebase Test Lab.'), findsOneWidget);
    });
  }
}
