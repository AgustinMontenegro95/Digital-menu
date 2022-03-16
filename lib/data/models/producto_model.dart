class Producto {
  Producto({
    this.categoria,
    this.nombre,
    this.descripcion,
    this.precio,
  });

  String? categoria;
  String? nombre;
  String? descripcion;
  String? precio;

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        categoria: json["categoria"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        precio: json["precio"],
      );

  Map<String, dynamic> toJson() => {
        "categoria": categoria,
        "nombre": nombre,
        "descripcion": descripcion,
        "precio": precio,
      };
}
