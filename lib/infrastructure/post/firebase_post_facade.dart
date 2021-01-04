import 'package:ar_post/domain/core/value_objects.dart';
import 'package:ar_post/domain/post/i_post_facade.dart';
import 'package:ar_post/infrastructure/post/upload_file_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ar_post/domain/post/post_failure.dart';
import 'package:ar_post/domain/post/post.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@LazySingleton(as: IPostFacade)
class FirebasePostFacade extends IPostFacade {
  final FirebaseFirestore _firebaseFirestore;
  final UploadFileManager _uploadFileManager;

  FirebasePostFacade(this._firebaseFirestore, this._uploadFileManager);

  @override
  Future<Either<PostFailure, Unit>> deletePost(UniqueId postId) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<Either<PostFailure, List<Post>>> fetchMostRecentPosts() {
    // TODO: implement fetchMostRecentPosts
    throw UnimplementedError();
  }

  @override
  Future<Either<PostFailure, List<Post>>> fetchUserPosts(UniqueId userId) {
    // TODO: implement fetchUserPosts
    throw UnimplementedError();
  }

  @override
  Future<Either<PostFailure, Unit>> likePost(UniqueId postId) {
    // TODO: implement likePost
    throw UnimplementedError();
  }

  @override
  Future<Either<PostFailure, Post>> publishPost(
      UniqueId userId, CachedImage image) async {
    final downloadUrl = await _uploadFileManager.uploadFile(image);
    final postId = Uuid().v1();

    await _firebaseFirestore.collection("posts").doc(postId).set({
      "userId": userId.getOrCrash(),
      "imageUrl": downloadUrl,
    });
  }
}
