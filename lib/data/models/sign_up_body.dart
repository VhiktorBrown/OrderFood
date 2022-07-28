class SignUpBody{
  String name;
  String username;
  String email;
  String phone;
  String password;

  SignUpBody({required this.name,
    required this.username,
    required this.phone,
    required this.email,
    required this.password
  });

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = <String, dynamic>{};

    data["name"] = name;
    data["username"] = username;
    data["email"] = email;
    data["phone"] = phone;
    data["password"] = password;

    return data;
  }

}