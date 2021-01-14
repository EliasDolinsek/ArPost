import 'package:ar_post/domain/core/value_objects.dart';
import 'package:ar_post/domain/post/post.dart';
import 'package:ar_post/domain/post/post_failure.dart';
import 'package:dartz/dartz.dart';

abstract class IPostFacade {
  Future<Either<PostFailure, Post>> publishPost(
      UniqueId userId, LocalImage image);
  Future<Either<PostFailure, List<Post>>> fetchMostRecentPosts();
  Future<Either<PostFailure, List<Post>>> fetchUserPosts(UniqueId userId);
  Future<Either<PostFailure, Unit>> deletePost(UniqueId postId);
  Future<Either<PostFailure, Unit>> likePost(UniqueId postId);
}
