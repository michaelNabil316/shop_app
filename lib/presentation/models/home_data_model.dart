class HomeModel {
  late bool statues;
  String? message;
  late HomeData data;
  HomeModel.fromjson(Map json) {
    statues = json['status'];
    message = json['message'];
    data = HomeData.fromJson(json['data']);
  }
}

class HomeData {
  late List<Banner> banners = [];
  late List<Product> products = [];
  HomeData.fromJson(Map json) {
    json['banners'].forEach((element) {
      Banner newbanner = Banner.fromJson(element);
      banners.add(newbanner);
    });
    json['products'].forEach((element) {
      products.add(Product.fromJson(element));
    });
  }
}

class Banner {
  late int id;
  late String image;
  Banner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class Product {
  late int id;
  late String image;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String name;
  late String description;
  // late List images;
  late bool inFavorites;
  late bool inCart;

  Product.fromJson(Map json) {
    id = json['id'];
    image = json['image'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    name = json['name'];
    description = json['description'];
    // json['images'].forEach((el) => images.add(el));
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
