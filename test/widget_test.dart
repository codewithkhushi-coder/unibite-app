import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unibite/app.dart';

void main() {
  testWidgets('Splash screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: UniBiteApp()));

    // UniBite starts on SplashScreen with 'UniBite'
    expect(find.text('UniBite'), findsOneWidget);
  });
}
