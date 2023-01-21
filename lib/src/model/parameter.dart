class Parameter<T> {
  final String name;
  final String path;

  Type get type => T;

  Parameter(this.name, this.path);
}

abstract class Parameterized {
  List<Parameter> parameters([String? name]);
}

abstract class Named {
  String? get name => null;
  dynamic get value;
}
