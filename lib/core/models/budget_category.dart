class BudgetCategory {
  final String name;
  double allocated;

  BudgetCategory({
    required this.name,
    required this.allocated,
  });

  factory BudgetCategory.fromMap(Map<String, dynamic> map) {
    return BudgetCategory(
      name: map["name"] ?? "",
      allocated: (map["estimated_budget"] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "estimated_budget": allocated,
    };
  }
}
