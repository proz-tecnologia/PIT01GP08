import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:financial_app/shared/models/category.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:financial_app/services/category_repository.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  late String uid;
  late CategoryFirebaseRepository categoryFirebaseRepository;
  late FakeFirebaseFirestore firestoreMock;

  setUp(() {
    uid = '';
    firestoreMock = FakeFirebaseFirestore();
    categoryFirebaseRepository = CategoryFirebaseRepository(
      firestoreMock,
      uid,
    );
  });

  group("test all category methods", () {
    test("Should create category", () async {
      final newCategory = Category(
          color: Colors.black,
          name: "Categoria",
          type: Type.income,
          icon: Icons.abc_outlined);
      await categoryFirebaseRepository.createCategory(newCategory);
      final docsCreated = await categoryFirebaseRepository.firestorePath.get();
      bool result = false;
      for (var doc in docsCreated.docs) {
        if (doc.data()["name"] == "Categoria") {
          result = true;
        }
      }
      expect(result, isTrue);
    });
  });
}
