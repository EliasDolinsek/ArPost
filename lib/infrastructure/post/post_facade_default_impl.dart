import 'package:ar_post/domain/core/value_objects.dart';
import 'package:ar_post/domain/post/i_post_facade.dart';
import 'package:ar_post/infrastructure/post/upload_file_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ar_post/domain/post/post_failure.dart';
import 'package:ar_post/domain/post/post.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import 'firebase_post_mapper.dart';

@LazySingleton(as: IPostFacade)
class PostFacadeDefaultImpl extends IPostFacade {
  final FirebaseFirestore _firebaseFirestore;
  final UploadFileManager _uploadFileManager;

  PostFacadeDefaultImpl(this._firebaseFirestore, this._uploadFileManager);

  @override
  Future<Either<PostFailure, Unit>> deletePost(UniqueId postId) async {
    _firebaseFirestore.collection("posts").doc(postId.getOrCrash()).delete();
    return right(unit);
  }

  @override
  Future<Either<PostFailure, List<Post>>> fetchMostRecentPosts(
      UniqueId userId) async {
    final posts = await _firebaseFirestore
        .collection("posts")
        .orderBy("release_date")
        .get();

    return right(posts.docs.map((e) => e.toDomainPost(userId)).toList());
  }

  @override
  Future<Either<PostFailure, List<Post>>> fetchUserPosts(UniqueId userId) {
    // TODO: implement fetchUserPosts
    throw UnimplementedError();
  }

  @override
  Future<Either<PostFailure, Unit>> likePost(UniqueId postId) {}

  @override
  Future<Either<PostFailure, Unit>> publishPost(
      UniqueId userId, LocalImage image) async {
    final downloadUrl = await _uploadFileManager.uploadFile(image);
    final postId = Uuid().v4();

    await _firebaseFirestore.collection("posts").doc(postId).set({
      "userId": userId.getOrCrash(),
      "imageUrl": downloadUrl,
    });

    return right(unit);
  }

  @override
  Future<Either<PostFailure, Unit>> savePostLocally(LocalImage image) async {
    ImageGallerySaver.saveFile(image.getOrCrash().path);
    return right(unit);
  }
}
