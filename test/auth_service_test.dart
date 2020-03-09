import 'package:flutter_test/flutter_test.dart';
import 'package:less_waste_app/core/services/auth.dart';
import 'package:mockito/mockito.dart';

import 'mocks/auth_result_mock.dart';
import 'mocks/firebase_auth_mock.dart';
import 'mocks/firebase_user_mock.dart';

void main() {
   group('FirebaseAuth', () {
  final FirebaseAuthMock firebaseAuthMock = FirebaseAuthMock();
  final FirebaseUserMock firebaseUserMock = FirebaseUserMock();
  final AuthResultMock firebaseAuthResult = AuthResultMock();
  final AuthService auth = AuthService(
    firebaseAuth: firebaseAuthMock,
  );

  test('signIn should return a user', () async {

    when(firebaseAuthMock.signInWithEmailAndPassword(email: "kalina@kalina.pl", password: "kalina")).thenAnswer((_) => Future<AuthResultMock>.value(firebaseAuthResult));

    when(firebaseAuthResult.user).thenAnswer((_) => firebaseUserMock);

    expect(await auth.signIn("kalina@kalina.pl", "kalina"), firebaseUserMock);

    verify(firebaseAuthMock.signInWithEmailAndPassword(
      email: firebaseAuthMock.email,
      password: firebaseAuthMock.password
    )).called(1);
  });
  });
}
