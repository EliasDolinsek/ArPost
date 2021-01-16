import 'package:ar_post/domain/core/value_objects.dart';
import 'package:ar_post/domain/post/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

extension QueryDocumentSnapshotDomainX on QueryDocumentSnapshot {
  Post toDomainPost(UniqueId userId) {
    final likesList = data()["likes"] as List<String>;
    return Post(
      id: UniqueId.fromUniqueString(data()["id"] as String),
      imageUrl: data()["imageUrl"] as String,
      likes: likesList.length,
      liked: likesList.contains(userId.getOrCrash()),
    );
  }
}
