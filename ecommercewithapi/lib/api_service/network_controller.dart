import 'dart:convert';

import 'package:ecommercewithapi/models/cart_model.dart';
import 'package:ecommercewithapi/models/category_model.dart';
import 'package:http/http.dart' as http;

import '../models/product_model.dart';
class NetworkController{

  static Future<List<Product>> getPosts() async {
    var url = Uri.parse("https://fakestoreapi.com/products/");
    final response = await http.get(url, headers: {"Content-Type": "application/json"});
    final List body = json.decode(response.body);
    return body.map((e) => Product.fromJson(e)).toList();
  }

  static Future<Product> getSinglePosts(String id) async {
    var url = Uri.parse("https://fakestoreapi.com/products/$id/");
    final response = await http.get(url, headers: {"Content-Type": "application/json"});
    final  body = json.decode(response.body);
    return Product.fromJson(body);
  }


  static Future<List<Product>> getCategoryProduct(String category) async {
    var url = Uri.parse("https://fakestoreapi.com/products/category/$category/");
    final response = await http.get(url, headers: {"Content-Type": "application/json"});
    final List body = json.decode(response.body);
    return body.map((e) => Product.fromJson(e)).toList();
  }



  static Future<List<cartProduct>> getCartProduct(String userId) async {
    var url = Uri.parse("https://fakestoreapi.com/carts?userId=$userId/");
    final response = await http.get(url, headers: {"Content-Type": "application/json"});
    final List body = json.decode(response.body);
    return body.map((e) => cartProduct.fromJson(e)).toList();
  }





}