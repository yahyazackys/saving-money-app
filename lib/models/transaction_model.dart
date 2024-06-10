class TransactionModel {
  TransactionModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.amount,
    required this.description,
    required this.categoryId,
    required this.missionId,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int userId;
  String type;
  double amount;
  String description;
  int categoryId;
  int missionId;
  String createdAt;
  String updatedAt;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json["id"] ?? 0,
        userId: json["user_id"] ?? 0,
        type: json["type"] ?? "",
        amount: double.tryParse(json['amount'].toString()) ?? 0.0,
        description: json["description"] ?? "",
        categoryId: json["category_id"] ?? 0,
        missionId: json["missions_id"] ?? 0,
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "type": type,
        "amount": amount,
        "description": description,
        "category_id": categoryId,
        "missions_id": missionId,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
