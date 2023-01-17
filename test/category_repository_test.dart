import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:financial_app/services/category_repository.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  late String uid;
  late CategoryFirebaseRepository categoryFirebaseRepository;
  late FakeFirebaseFirestore firestoreMock;

  setUp(() async {
    uid = '';
    firestoreMock = FakeFirebaseFirestore();
    categoryFirebaseRepository = CategoryFirebaseRepository(
      firestoreMock,
      uid,
    );
  });

  group("test all category methods", () {
    test("Should create category", () {
      const result = null;
      expect(result, isNull);
    });
  });
}
