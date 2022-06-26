abstract class LootCondition {
  final String condition;

  LootCondition({
    required this.condition,
  });

  Map<String, dynamic> toJson();
}
