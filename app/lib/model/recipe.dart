class Recipe {
  const Recipe({
    required this.name,
    // required this.image,
    required this.detail,
    required this.docid,
    required this.imageurl,
  });

  final String name;
  // final String image;
  final String detail;
  final String docid;
  final String imageurl;

  // String get assetName => image;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['name'] = name;
    data['image'] = 'https://handong.edu/site/handong/res/img/logo.png';

    return data;
  }
}
