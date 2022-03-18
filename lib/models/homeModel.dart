class HomeModel {
  late bool status;
  HomeDataModel? data;
  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProdcutModel> products = [];
  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannerModel.fromJson(element));
    });

    json['products'].forEach((element) {
      products.add(ProdcutModel.fromJson(element));
    });
  }
}

class BannerModel {
   int? id;
   String? image;
  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProdcutModel {
   int? id;
   dynamic price;
   dynamic oldPrice;
  dynamic discount;
   String?image;
   String? name;
   bool? inFavorit;
   bool? inCart;
  ProdcutModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    name = json['name'];
    inCart = json['in_cart'];
    inFavorit = json['in_favorites'];
  }
}
