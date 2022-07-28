class SignUpBody{
  String name;
  String email;
  String phone;
  String password;

  SignUpBody({required this.name,
    required this.phone,
    required this.email,
    required this.password
  });

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = <String, dynamic>{};

    data["name"] = name;
    data["email"] = email;
    data["phone"] = phone;
    data["password"] = password;

    return data;
  }

}