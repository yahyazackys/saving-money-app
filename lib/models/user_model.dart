class UserModel {
  UserModel({
    required this.id,
    required this.nameUser,
    required this.emailUser,
    required this.occupationUser,
    required this.noHpUser,
    required this.gambarUser,
    required this.passwordUser,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String nameUser;
  String emailUser;
  String occupationUser;
  String noHpUser;
  String gambarUser;
  String passwordUser;
  DateTime createdAt;
  DateTime updatedAt;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] ?? 0,
        nameUser: json["name"] ?? "",
        emailUser: json["email"] ?? "",
        occupationUser: json["occupation"] ?? "",
        noHpUser: json["phone_number"] ?? "",
        gambarUser: json["image"] ?? "",
        passwordUser: json["password"] ?? "",
        createdAt: DateTime.parse(
            json["created_at"] ?? DateTime.now().toIso8601String()),
        updatedAt: DateTime.parse(
            json["updated_at"] ?? DateTime.now().toIso8601String()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameUser,
        "email": emailUser,
        "occupation": occupationUser,
        "phone_number": noHpUser,
        "image": gambarUser,
        "password": passwordUser,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
