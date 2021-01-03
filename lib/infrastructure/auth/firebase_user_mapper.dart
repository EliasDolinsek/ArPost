import 'package:ar_post/domain/core/value_objects.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ar_post/domain/auth/user.dart' as ar_post;

extension FirebaseUserDomainX on User {
  ar_post.User toDomain() {
    return ar_post.User(id: UniqueId.fromUniqueString(uid));
  }
}
