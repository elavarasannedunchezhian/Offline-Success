import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shopping/service/user_service.dart';
import 'package:shopping/splash.dart';

class MockUserService extends Mock implements UserService {}

void main() {
  group('SplashScreen', () {
    testWidgets('Renders SplashScreen correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SplashScreen(
          userService: MockUserService(),
        ),
      ),
    );

    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(Center), findsNWidgets(2));
    expect(find.byType(Column), findsOneWidget);
    expect(find.descendant(
      of: find.byType(Center),
      matching: find.byType(ElevatedButton),
    ), findsNWidgets(2));
  });
  });
}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}
