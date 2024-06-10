// import 'package:flutter/foundation.dart';

import 'category_model.dart';

class MissionModel {
  MissionModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.targetAmount,
    required this.targetDate,
    required this.categoryId,
    required this.category,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int userId;
  String title;
  double targetAmount;
  String targetDate;
  int categoryId;
  CategoryModel? category;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  factory MissionModel.fromJson(Map<String, dynamic> json) => MissionModel(
        id: json["id"] ?? 0,
        userId: json["user_id"] ?? 0,
        title: json["title"] ?? "",
        targetAmount: double.tryParse(json['target_amount'].toString()) ?? 0.0,
        targetDate: json["target_date"] ?? "",
        categoryId: json["category_id"] ?? 0,
        category: CategoryModel.fromJson(json["category"]),
        description: json["description"] ?? "",
        createdAt: DateTime.parse(
            json["created_at"] ?? DateTime.now().toIso8601String()),
        updatedAt: DateTime.parse(
            json["updated_at"] ?? DateTime.now().toIso8601String()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "target_amount": targetAmount,
        "target_date": targetDate,
        "category_id": categoryId,
        "category": category?.toJson(),
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
