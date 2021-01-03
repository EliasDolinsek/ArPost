import 'package:ar_post/domain/auth/value_objects.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';

@freezed
abstract class Post with _$Post {
  const factory Post({
    @required EmailAddress emailAddress,
    @required String imageUrl,
  }) = _Post;
}
