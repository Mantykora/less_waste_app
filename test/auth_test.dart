import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mocks/auth_result_mock.dart';
import 'mocks/firebase_auth_mock.dart';
import 'mocks/firebase_user_mock.dart';

void main() {
 // group('FirebaseAuth', () {
    final FirebaseAuthMock firebaseAuthMock = FirebaseAuthMock();
    final FirebaseUserMock firebaseUserMock = FirebaseUserMock();
    final AuthResultMock firebaseAuthResult = AuthResultMock();

//    final AuthService auth = AuthService(
//      firebaseAuth: firebaseAuthMock,
//    );

    test('signIn should return a user', () async {
      //var app = FirebaseApp(name: "test");
      //var user = PlatformUser(providerId: "test",  uid: "test", isAnonymous: true, isEmailVerified: true, providerData: List());
      //var additionalInfo = PlatformAdditionalUserInfo(isNewUser: true, providerId: "dupa", username: "test", profile: Map());



      //var platformAuthResult = PlatformAuthResult(user: user, additionalUserInfo: additionalInfo);
      //final AuthResult authResult = AuthResult(platformAuthResult, app);



      when(firebaseAuthMock.signInWithEmailAndPassword(email: "kalina@kalina.pl", password: "kalina"))
          .thenAnswer((_) =>
          Future<AuthResultMock>.value(firebaseAuthResult));


    });
  //});
}
