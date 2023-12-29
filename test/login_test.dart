import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart' show Mock, verify, when;
import 'package:pasar_petani/app/models/koperasi.dart';
import 'package:pasar_petani/app/services/authentication.dart';
import 'package:pasar_petani/app/modules/login/controllers/login_controller.dart';

class MockAuthentication extends Mock implements Authentication {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LoginController', () {
    test('login method should call Authentication.login', () async {
      // Arrange
      final mockAuthentication = MockAuthentication();
      final loginController = LoginController();
      loginController.email.text = 'koperasi4@gmail.com';
      loginController.password.text = '123456789';
      loginController.auth = mockAuthentication;

      when(mockAuthentication.login('koperasi4@gmail.com', '123456789'))
          .thenAnswer((_) async => Future.value(Koperasi(
                id: 1,
                name: 'Koperasi 4',
                email: 'koperasi4@gmail.com',
                address: 'test address',
                phoneNumber: '1234567890',
                photo: 'test photo',
                createdAt: '2022-01-01',
                updatedAt: '2022-01-01',
                tokenType: 'Bearer',
                accessToken: 'test_token',
              )));

      // Act
      await loginController.login();

      // Assert
      verify(mockAuthentication.login('koperasi4@gmail.com', '123456789'))
          .called(1);
    });
  });
}
