

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/model/user_model.dart';
import 'package:flutter_assignment/model/user_req.dart';

 class ApiService{

 static final dio = Dio();

 static Future<List<UserRecord>> getUserData()async {

   var url = "https://jsonplaceholder.typicode.com/photos";
    final response = await dio.get(url);
    if(response.statusCode==200){
      debugPrint('responsse $response');
      return (response.data as List).map((e) => UserRecord.fromJson(e)).toList();
    }else {
      return [];
   }
 }

 static Future<bool> postUserData(UserReq userReq)async {

   var url = "https://jsonplaceholder.typicode.com/photos";
   final response = await dio.post(url,data: userReq.toJson());
   debugPrint(' respondse ${response.data}');
   return response.statusCode==201;
 }
}