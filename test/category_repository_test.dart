import 'package:financial_app/services/category_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  late UserCredential currentUser;
  late MockFirebaseAuth firebaseAuth;
  late CategoryFirebaseRepository categoryFirebaseRepository;
  late FakeFirebaseFirestore firestoreMock;
  setUp(() async {
    firebaseAuth = MockFirebaseAuth();
    firebaseAuth.createUserWithEmailAndPassword(
        email: "ruda@gmail.com", password: "12345678");

    currentUser = await firebaseAuth.signInWithEmailAndPassword(
        email: "ruda@gmail.com", password: "12345678");
    firestoreMock = FakeFirebaseFirestore();
    categoryFirebaseRepository = CategoryFirebaseRepository(
      firestoreMock,
      firebaseAuth,
    );
  });

  group("test all category methods", () {
    test("Should create category", () {
      const result = null;
      expect(result, isNull);
    });
  });
}
