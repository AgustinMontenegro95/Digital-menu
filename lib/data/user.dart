class UserModel {
  String? uId;
  String? name;
  String? email;
  String? nombreEmpresa;
  String? image;
  String? direccion;
  String? telefono;

  UserModel({
    this.uId,
    this.name,
    this.email,
    this.nombreEmpresa,
    this.direccion,
    this.telefono,
    this.image,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    name = json['name'];
    email = json['email'];
    nombreEmpresa = json['nombreEmpresa'];
    image = json['image'];
    direccion = json['direccion'];
    telefono = json['telefono'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'email': email,
      'nombreEmpresa': nombreEmpresa,
      'image': image,
      'direccion': direccion,
      'telefono': telefono,
    };
  }
}
