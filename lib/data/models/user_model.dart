class UserModel {
  String? uid;
  String? name;
  String? email;
  String? nombreEmpresa;
  String? image;
  String? direccion;
  String? telefono;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.nombreEmpresa,
    this.direccion,
    this.telefono,
    this.image,
  });
  //receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      telefono: map['telefono'],
      direccion: map['direccion'],
      image: map['image'],
      nombreEmpresa: map['nombreEmpresa'],
    );
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uId'];
    name = json['name'];
    email = json['email'];
    nombreEmpresa = json['nombreEmpresa'];
    image = json['image'];
    direccion = json['direccion'];
    telefono = json['telefono'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uid,
      'name': name,
      'email': email,
      'nombreEmpresa': nombreEmpresa,
      'image': image,
      'direccion': direccion,
      'telefono': telefono,
    };
  }
}
