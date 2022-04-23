import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum ModuleType {
  data,
  javascript,
  resources,
}
