class ComponentParam<T> {
  final String name;
  final T value;

  Type get type => T.runtimeType;

  ComponentParam(this.name, this.value);
}

abstract class Component {
  List<ComponentParam> get parameters;

  dynamic toJson();
}
