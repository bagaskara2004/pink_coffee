class Product {
  int? id;
  String? name;
  String? price;
  String? description;
  String? photo;
  String? kategori;
  String? rekomended;

  Product(
      {this.id,
      this.name,
      this.price,
      this.description,
      this.photo,
      this.kategori,
      this.rekomended});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['price'] = price;
    map['description'] = description;
    map['photo'] = photo;
    map['kategori'] = kategori;
    map['rekomended'] = rekomended;
    return map;
  }

  Product.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    price = map['price'];
    description = map['description'];
    photo = map['photo'];
    kategori = map['kategori'];
    rekomended = map['rekomended'];
  }
}
