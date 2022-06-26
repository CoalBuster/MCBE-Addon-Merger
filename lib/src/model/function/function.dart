abstract class LootFunction {
  final String function;

  LootFunction({
    required this.function,
  });

  Map<String, dynamic> toJson();
}
