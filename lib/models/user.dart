class UserModel {
  String id;
  String email;

  UserModel({
    required this.id,
    required this.email,
  });

  toJson() {
    return {"email": email};
  }
}
