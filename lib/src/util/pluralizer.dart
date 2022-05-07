extension Pluralizer on int {
  String pluralText(
    String singleVariant,
    String multipleVariant, [
    String? inBetween,
  ]) {
    final between = inBetween == null ? '' : '$inBetween ';
    return this == 1
        ? '$this $between$singleVariant'
        : '$this $between$multipleVariant';
  }
}
