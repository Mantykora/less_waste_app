import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';

class FirebaseAuthMock extends Mock implements FirebaseAuth {
  @override
  final String email = 'kalina@kalina.pl';
  @override
  final String password = 'kalina';
}
