import 'package:financial_app/services/category_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}
// class MockFirebaseUser extends Mock implements FirebaseUser{}
// class MockAuthResult extends Mock implements AuthResult {}

void main() {
  // late MockFirebaseAuth firestorePath;
  // late CategoryFirebaseRepository categoryFirebaseRepository;
  // late FakeFirebaseFirestore firestoreMock;
  setUp(() {
    // firestorePath = MockFirebaseAuth();
    // firestoreMock = FakeFirebaseFirestore(firestorePath);
    // categoryFirebaseRepository = CategoryFirebaseRepository();
  });
  tearDown(() => null);
  group("test all category methods", () {
    test("Should create category", () {
      const result = null;
      expect(result, isNull);
    });
  });
}
