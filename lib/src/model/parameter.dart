class Parameter<T> {
  final String name;
  final String path;

  Type get type => T;

  Parameter(this.name, this.path);
}
