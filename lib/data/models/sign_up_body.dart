class SignUpBody{
  String? id;
  String? name;
  String? username;
  String? email;
  String? phone;
  String? password;

  SignUpBody({
    this.id="",
    required this.name,
    required this.username,
    required this.phone,
    required this.email,
    required this.password
  });

  SignUpBody.fromJson(Map<String, dynamic> json){
    id = json["_id"];
    name = json["name"];
    username = json["username"];
    email = json["email"];
    phone = json["phone"];
    password = json["password"];
  }

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