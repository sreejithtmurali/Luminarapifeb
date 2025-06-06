import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled3/Model/User.dart';
import 'package:untitled3/Model/allproducts/Data.dart';
import 'package:untitled3/Model/allproducts/Respproductsall.dart';
import 'package:untitled3/service/userservice2.dart';
class ApiService{
 static const apiEnvironment=ApiEnvironment.prod;
 final baseurl= apiEnvironment.baseUrl;
 Future<List<Products>?> fetchproducts() async {
   var url=Uri.parse("$baseurl/products-all/");
   var headers={
     'accept': 'application/json' ,
     'Content-Type': 'application/json',
     'Authorization':'Bearer ${await Userservice2().getaccesskey()}'
   };
   print("$url:::::$headers");
   try
   {
     final response=await http.get(url,headers: headers);
     if(response.statusCode>=200 && response.statusCode<=299){
       var json=jsonDecode(response.body);
       var resp=Respproductsall.fromJson(json);
       var list=resp.data;
       return list;

     }
   }
   catch(e)
   {
     print(e);

   }
 }

   Future<User?>login({required String email,required String password }) async {
    var url=Uri.parse("$baseurl/login");
    var headers={
      'accept': 'application/json' ,
      'Content-Type': 'application/json'
    };
    var body=jsonEncode({
      "email": "$email",
      "password": "$password"
    });
    try
    {
      print("url:$url:::$body  :::$headers");
        final response = await http.post(url, headers: headers, body: body);
        print(response.body);
        if (response.statusCode >= 200 && response.statusCode <= 299) {
          var json = jsonDecode(response.body);
          var user = User.fromJson(json);
          return user;
        }
    }catch(e){
      print(e);
    }
  }

 Future<bool?> register({required String email, required String password, required String name, required String place, required String phone, required String pincode}) async {
    var url=Uri.parse("$baseurl/registration/");
    var headers={
      'accept': 'application/json' ,
      'Content-Type': 'application/json'
    };
    var body=jsonEncode({

        "name": "$name",
        "phone": num.parse(phone),
        "place": "$place",
        "pincode": int.parse(pincode),
        "email": "$email",
        "password": "$password"

    });
    try
    {
      print("url:$url:::$body  :::$headers");
      final response = await http.post(url, headers: headers, body: body);
      print(response.body);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
      return true;
      }
    }catch(e){
      print(e);
      return false;
    }
    return false;
  }
}

enum ApiEnvironment {
  dev("replace_development_server_address"),
  prod("https://freeapi.luminartechnohub.com");
  const ApiEnvironment(this.baseUrl);
  final String baseUrl;
}