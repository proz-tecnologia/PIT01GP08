import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class PixRepository {
  Future<void> setPixKeys(Map<String, String> updatedPixKeys);
  Future<void> deletePixKey(String pixKeyDescription);
  Future<Map<String, String>> getAllPixKeys();
}

class PixFirebaseRepository implements PixRepository {
  final firestorePath = FirebaseFirestore.instance
      .collection('pix-keys')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  @override
  Future<void> setPixKeys(Map<String, String> updatedPixKeys) async {
    try {
      firestorePath.set(updatedPixKeys);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deletePixKey(String pixKeyDescription) async {
    try {
      firestorePath.update({pixKeyDescription: FieldValue.delete()});
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, String>> getAllPixKeys() async {
    try {
      final snapshot = await firestorePath.get();
      final pixKeys = snapshot.data();
      final result = <String, String>{};
      if (pixKeys?.isNotEmpty ?? false) {
        for (var e in (pixKeys?.entries)!) {
          result.addAll(
            {e.key: e.value.toString()},
          );
        }
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
