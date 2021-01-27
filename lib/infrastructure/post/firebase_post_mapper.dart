import 'package:ar_post/domain/core/value_objects.dart';
import 'package:ar_post/domain/post/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

extension QueryDocumentSnapshotDomainX on DocumentSnapshot {
  Post toDomainPost(UniqueId userId) {
    final likesList =
        (data()["likes"] as List).map((e) => e as String).toList();
    return Post(
      id: UniqueId.fromUniqueString(id),
      imageUrl: data()["imageUrl"] as String,
      likes: likesList.length,
      liked: likesList.contains(userId.getOrCrash()),
      userEmail: data()["userEmail"] as String,
      likesList: likesList,
    );
  }
}
