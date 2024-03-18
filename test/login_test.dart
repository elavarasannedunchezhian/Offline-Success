import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:realm/realm.dart';
import 'package:shopping/login.dart';
import 'package:shopping/service/user_service.dart';

class MockUserService extends Mock implements UserService {}
class MockUser extends Mock implements User {}

void main() {
  group('LoginScreen', () {
  testWidgets('Renders login correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LoginScreen(
          userService: MockUserService()),
      )
    );

    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.text('Login'), findsNWidgets(2));
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('Shows error message on login failure', (WidgetTester tester) async {
    final mockUserService = MockUserService();
    when(() => mockUserService.loginUser('', '')).thenThrow(RealmException('Login failed'));
    await tester.pumpWidget(
        MaterialApp(
          home: LoginScreen(
            userService: mockUserService,
          ),
        ),
      );
    await tester.tap(find.byKey(const Key('loginButton')));
    await tester.pumpAndSettle();
    expect(find.text('Login failed'), findsOneWidget);
  });
  });
}