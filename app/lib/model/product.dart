enum Category {
  all,
  accessories,
  clothing,
  home,
}

class Product {
  const Product({
    // required this.category,
    // required this.id,
    // required this.isFeatured,
    required this.name,
    required this.price,
    required this.image,
    required this.detail,
    required this.docid,
  });

  // final Category category;
  // final int id;
  // final bool isFeatured;
  final String name;
  final int price;
  final String image;
  final String detail;
  final String docid;

  String get assetName => image;
  // String get assetPackage => 'shrine_images';

  // factory Product.fromMap({required int id, required Map<String, dynamic> map}) {
  //   return Product(
  //       // id: id,
  //       // isFeatured: map['is'],
  //       name: map['name']??'',
  //       price: map['price']??'',
  //       image: map['image']??'',
  //       detail: map['deatil']??'',
  //   );
  // }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['name'] = name;
    data['price'] = price;
    data['image'] = 'https://handong.edu/site/handong/res/img/logo.png';

    return data;
  }

  // @override
  // String toString() => "$name (id=$id)";
}
