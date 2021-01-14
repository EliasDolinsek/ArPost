import 'dart:io';

import 'package:ar_post/domain/core/value_objects.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

abstract class UploadFileManager {
  Future<String> uploadFile(LocalImage image);
}

@LazySingleton(as: UploadFileManager)
class FirestoreUploadFileManager implements UploadFileManager {
  final FirebaseStorage _firebaseStorage;

  FirestoreUploadFileManager(this._firebaseStorage);

  @override
  Future<String> uploadFile(LocalImage image) async {
    final id = Uuid().v1();
    final reference = _firebaseStorage.ref().child("$id.png");
    final result = await reference.putData(image.getOrCrash());
    return result.ref.getDownloadURL();
  }
}
