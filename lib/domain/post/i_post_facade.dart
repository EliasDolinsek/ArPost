import 'package:ar_post/domain/auth/user.dart';
import 'package:ar_post/domain/core/value_objects.dart';
import 'package:ar_post/domain/post/post.dart';
import 'package:ar_post/domain/post/post_failure.dart';
import 'package:dartz/dartz.dart';

abstract class IPostFacade {
  Future<Either<PostFailure, Unit>> publishPost(User user,
      LocalImage image);

  Future<Either<PostFailure, Unit>> savePostLocally(LocalImage image);

  Future<Either<PostFailure, List<Post>>> fetchMostRecentPosts(UniqueId userId);

  Future<Either<PostFailure, List<Post>>> fetchUserPosts(UniqueId userId);

  Future<Either<PostFailure, Unit>> deletePost(UniqueId postId);

  Future<Either<PostFailure, Unit>> likePost(UniqueId postId);
}
