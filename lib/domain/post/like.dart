import 'package:ar_post/domain/core/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'like.freezed.dart';

@freezed
abstract class Like with _$Like {
  const factory Like({@required UniqueId userId}) = _Like;
}
