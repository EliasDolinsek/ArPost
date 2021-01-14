import 'package:ar_post/domain/core/value_objects.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';

@freezed
abstract class Post with _$Post {
  const factory Post({
    @required UniqueId id,
    @required String imageUrl,
    @required int likes,
    @required bool liked
  }) = _RemotePost;
}
