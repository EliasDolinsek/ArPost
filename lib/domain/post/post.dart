import 'package:ar_post/domain/auth/value_objects.dart';
import 'package:ar_post/domain/core/value_objects.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';

@freezed
abstract class Post with _$Post {
  const factory Post({
    @required UniqueId id,
    @required EmailAddress emailAddress,
    @required ImageUrl imageUrl,
  }) = _RemotePost;
}
