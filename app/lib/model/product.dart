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
    required this.image,
    required this.detail,
    required this.docid,
  });

  // final Category category;
  // final int id;
  // final bool isFeatured;
  final String name;
  final String image;
  final String detail;
  final String docid;


  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['name'] = name;
    data['image'] = 'https://handong.edu/site/handong/res/img/logo.png';

    return data;
  }

  // @override
  // String toString() => "$name (id=$id)";
}
