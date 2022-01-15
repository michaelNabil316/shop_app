class FavoritesChangeModel {
  late bool status;
  late String message;
  FavoritesChangeModel.fromJson(Map json) {
    status = json['status'];
    message = json['message'];
  }
}

/*
{"status":true,"message":"Deleted Successfully",
"data":{"id":43549,"product":{"id":54,"price":11499,"old_price":12499,
"discount":8,"image":"https://student.valuxapps.com/storage/uploads/products/1615441020ydvqD.item_XXL_51889566_32a329591e022.jpeg"}}}
*/