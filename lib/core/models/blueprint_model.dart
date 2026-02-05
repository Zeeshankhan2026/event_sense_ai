class EventBlueprintModel {
  final List<CategoryModel> categories;
  final List<TimelineModel> timeline;
  final List<String> vendorCategories;

  EventBlueprintModel({
    required this.categories,
    required this.timeline,
    required this.vendorCategories,
  });

  factory EventBlueprintModel.fromMap(Map<String, dynamic> map) {
    return EventBlueprintModel(
      categories: (map['categories'] as List? ?? [])
          .map((e) => CategoryModel.fromMap(e))
          .toList(),

      timeline: (map['timeline'] as List? ?? [])
          .map((e) => TimelineModel.fromMap(e))
          .toList(),

      vendorCategories: List<String>.from(
        map['vendor_categories'] ?? [],
      ),
    );
  }
}

class CategoryModel {
  final String name;
  final int estimatedBudget;
  final String status;

  CategoryModel({
    required this.name,
    required this.estimatedBudget,
    this.status = "not_started",
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      name: map['name'] ?? '',
      estimatedBudget: (map['estimated_budget'] ?? 0).toInt(),
      status: map['status'] ?? "not_started",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "estimated_budget": estimatedBudget,
      "status": status,
    };
  }
}
class TimelineModel {
  final String title;
  final int daysBefore;

  TimelineModel({
    required this.title,
    required this.daysBefore,
  });

  factory TimelineModel.fromMap(Map<String, dynamic> map) {
    return TimelineModel(
      title: map['title'] ?? '',
      daysBefore: (map['days_before'] ?? 0).toInt(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "days_before": daysBefore,
    };
  }
}
