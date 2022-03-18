class ShopFavoritesModel{
  bool? status;
  Null message;
  FavoritsDataModel? data;

   ShopFavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message=json['message'];
    data = FavoritsDataModel.fromJson(json['data']);
  }
}

class FavoritsDataModel{
  int? currentPage;
  List<DeltailesFavoritesData> data=[];
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  Null? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;

  FavoritsDataModel.fromJson(Map<String,dynamic>json){
    currentPage=json['id'];
    json['data'].forEach((element){
      data.add(DeltailesFavoritesData.fromJson(element));
    });
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class DeltailesFavoritesData{
  int? favId;
  ProductsData? data;

  DeltailesFavoritesData.fromJson(Map<String,dynamic>json){
    favId=json['id'];
    data=ProductsData.fromJson(json['product']);
  }
}

class ProductsData{
  int? id;
  dynamic price;
  dynamic oldPrice;
  int ?discount;
  String ?image;
  String ?name;
  String ?description;
  ProductsData.fromJson(Map<String,dynamic>json){
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    description=json['description'];

  }


}
