import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:realm/realm.dart';
import 'package:shopping/service/user_service.dart';
import 'package:shopping/signup.dart';

class MockUserService extends Mock implements UserService {}

void main() {
  group('SignupScreen', () {
    late UserService userService;

    setUp(() {
      userService = MockUserService();
    });

    testWidgets('renders SignupScreen', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignupScreen(userService: userService)));
      expect(find.byType(SignupScreen), findsOneWidget);
    });

    testWidgets('renders email and password TextFields', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignupScreen(userService: userService)));
      expect(find.byType(TextField), findsNWidgets(2));
    });

    testWidgets('renders ElevatedButton', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignupScreen(userService: userService)));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('shows error message when signup fails', (WidgetTester tester) async {
      when(() => userService.createUser(any(), any())).thenThrow(RealmException('Error during signup'));
      await tester.pumpWidget(MaterialApp(home: SignupScreen(userService: userService)));
      await tester.enterText(find.byType(TextField).first, 'test@example.com');
      await tester.enterText(find.byType(TextField).last, 'password');
      await tester.tap(find.byType(ElevatedButton));
    });
  });
}