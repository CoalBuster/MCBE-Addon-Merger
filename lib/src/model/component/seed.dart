import 'package:json_annotation/json_annotation.dart';

import 'component.dart';

part 'seed.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SeedComponent implements Component {
  final String cropResult;
  final String plantAt;

  SeedComponent({
    required this.cropResult,
    required this.plantAt,
  });

  @override
  get parameters => [
        ComponentParam('Plant At', plantAt),
        ComponentParam('Get Crop', cropResult),
      ];

  factory SeedComponent.fromJson(Map<String, dynamic> json) =>
      _$SeedComponentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SeedComponentToJson(this);

  @override
  String toString() => 'Plant on $plantAt to grow $cropResult';
}
