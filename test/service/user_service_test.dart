import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:realm/realm.dart';
import 'package:shopping/service/user_service.dart';

class MockApp extends Mock implements App {}
class MockUser extends Mock implements User {}
class MockEmailPasswordAuthProvider extends Mock implements EmailPasswordAuthProvider {}
class MockCredentials extends Mock implements Credentials {}

void main() {
  group('UserService', () {
    late MockApp mockApp;
    late UserService userService;

    setUp(() {
      mockApp = MockApp();
      userService = UserService(mockApp);
      registerFallbackValue(MockCredentials());
    });

    test('loginUser() should log in a user', () async {
      final mockUser = MockUser();

      when(() => mockApp.logIn(any())).thenAnswer((_) async => mockUser);

      final userService = UserService(mockApp);
      final Future<User> user = userService.loginUser('test@example.com', 'test123');

      expect(await user, equals(mockUser));
      verify(() => mockApp.logIn(any())).called(1);
    });

    test('logoutUser() should log out a user', () async {
      final mockUser = MockUser();

      when(() => mockApp.currentUser).thenReturn(mockUser);
      when(() => mockUser.logOut()).thenAnswer((_) async => null);

      await userService.logoutUser();

      verify(() => mockUser.logOut()).called(1);
    });
  });
}