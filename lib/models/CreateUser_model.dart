class CreateUserModel {
  String? name;
  String? email;
  String? uId;
  String? phone;

  CreateUserModel({
    this.name,
    this.email,
    this.uId,
    this.phone,
  });

  CreateUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    uId = json['uId'];
    phone = json['phone'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'uId': uId,
      'phone': phone,
    };
  }
}
