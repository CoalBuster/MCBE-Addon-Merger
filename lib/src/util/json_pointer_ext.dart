import 'package:json_patch/json_patch.dart';

extension JsonPointerExtension on JsonPointer {
  operator +(JsonPointer other) =>
      JsonPointer.fromSegments(segments + other.segments);

  append(String path) => JsonPointer.fromString(
      toString() + (path.startsWith('/') ? path : '/$path'));

  up(int times) => JsonPointer.fromSegments(
      segments.reversed.skip(times).toList().reversed.toList());
}
