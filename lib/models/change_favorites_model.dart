class FavoritsModel{
  bool ?status;
  String?message;

  FavoritsModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
  }
}