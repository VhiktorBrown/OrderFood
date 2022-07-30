
class User {
  String? id;
  String? name;
  String? username;
  String? email;
  String? phone;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
        id: json["_id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"]
    );
  }
}