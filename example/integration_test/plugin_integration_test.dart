import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:firebase_testlab_detector/firebase_testlab_detector.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('isAppRunningInTestlab test', (WidgetTester tester) async {
    final isRunningInTestlab =
        await FirebaseTestlabDetector.isAppRunningInTestlab();
    expect(isRunningInTestlab, false);
  });
}
