class RegisterUser {
  bool? statues;
  UserData? data;
  String? message;
  RegisterUser.fromJson(Map json) {
    statues = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}

class UserData {
  String? name;
  String? token;
  UserData.fromJson(Map json) {
    name = json['name'];
    token = json['token'];
  }
}

/*
{status: true, 
 message: Registration done successfully,
 data: {
   name: Mike nabil,
   email: mike@gmail.com,
   phone: 01284823321, 
   id: 10677, 
   image: https://student.valuxapps.com/storage/assets/defaults/user.jpg,
   token: ssss
  }
}
{status: false, 
 message: This phone has been used before, 
 data: null
}
*/