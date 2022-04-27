class CountOrRange {
  final num? count;
  final num? max;
  final num? min;

  const CountOrRange.count(this.count)
      : max = null,
        min = null;

  const CountOrRange.range(this.min, this.max) : count = null;

  factory CountOrRange.fromJson(dynamic cor) => cor is num
      ? CountOrRange.count(cor)
      : CountOrRange.range(cor['min'], cor['max']);

  dynamic toJson() => count ?? {'min': min, 'max': max};

  @override
  String toString() => count?.toString() ?? '$min-$max';
}
