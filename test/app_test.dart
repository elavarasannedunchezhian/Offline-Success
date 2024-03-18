import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shopping/main.dart';
import 'package:shopping/service/user_service.dart';

class MockUserService extends Mock implements UserService {}
void main() {
  group('MyApp', () {
    testWidgets('Instantiates MyApp with UserService', (WidgetTester tester) async {
      final MockUserService mockUserService = MockUserService();
      await tester.pumpWidget(
        MaterialApp(
          home: MyApp(userService: mockUserService),
        ),
      );

      final myAppFinder = find.byType(MyApp);
      expect(myAppFinder, findsOneWidget);
      final MyApp myAppWidget = tester.widget(myAppFinder);
      expect(myAppWidget.userService, equals(mockUserService));
    });
  });
}