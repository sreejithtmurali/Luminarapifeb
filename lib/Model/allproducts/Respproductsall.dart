import 'Data.dart';
import 'dart:convert';

Respproductsall respproductsallFromJson(String str) => Respproductsall.fromJson(json.decode(str));
String respproductsallToJson(Respproductsall data) => json.encode(data.toJson());
class Respproductsall {
  Respproductsall({
      this.msg, 
      this.data,});

  Respproductsall.fromJson(dynamic json) {
    msg = json['Msg'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Products.fromJson(v));
      });
    }
  }
  String? msg;
  List<Products>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Msg'] = msg;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}