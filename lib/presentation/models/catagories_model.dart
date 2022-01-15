class Catagories {
  late bool status;
  String? message;
  late CatgoriesData data;
  Catagories.fromJson(Map json) {
    status = json['status'];
    message = json['message'];
    data = CatgoriesData.fromJson(json['data']);
  }
}

class CatgoriesData {
  late int currentPage;
  List<DataModel> dataList = [];
  CatgoriesData.fromJson(Map json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      dataList.add(DataModel.fromJson(element));
    });
  }
}

class DataModel {
  late int id;
  late String name;
  late String image;
  DataModel.fromJson(Map json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
/*
{
    "status": true,
    "message": null,
    "data": {
        "current_page": 1,
        "data": [
            {
                "id": 44,
                "name": "اجهزه الكترونيه",
                "image": "https://student.valuxapps.com/storage/uploads/categories/16301438353uCFh.29118.jpg"
            },
            {
                "id": 43,
                "name": "مكافحة كورونا",
                "image": "https://student.valuxapps.com/storage/uploads/categories/1630142480dvQxx.3658058.jpg"
            },
            {
                "id": 42,
                "name": "رياضة",
                "image": "https://student.valuxapps.com/storage/uploads/categories/1630141824IkQpJ.sports.png"
            },
            {
                "id": 40,
                "name": "ادوات الاناره",
                "image": "https://student.valuxapps.com/storage/uploads/categories/16300981128XWfI.Group 1548@3x.png"
            }
        ],
        "first_page_url": "https://student.valuxapps.com/api/categories?page=1",
        "from": 1,
        "last_page": 1,
        "last_page_url": "https://student.valuxapps.com/api/categories?page=1",
        "next_page_url": null,
        "path": "https://student.valuxapps.com/api/categories",
        "per_page": 35,
        "prev_page_url": null,
        "to": 4,
        "total": 4
    }
}
 */