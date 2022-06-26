import 'package:json_annotation/json_annotation.dart';

import 'component.dart';

part 'unknown.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UnknownComponent extends Component {
  final dynamic json;

  UnknownComponent({
    required this.json,
  });

  @override
  get parameters =>
      json.entries.map((e) => ComponentParam(e.key, e.value)).toList();

  factory UnknownComponent.fromJson(dynamic json) =>
      _$UnknownComponentFromJson({'json': json});

  @override
  dynamic toJson() => _$UnknownComponentToJson(this)['json'];

  @override
  String toString() => json.toString();
}
