import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:stock_app/core/services/Navigation_Service.dart';
import 'package:stock_app/windows/security/SecurityScreen.dart';

import '../RouterGenerator.dart';
import '../models/IDataResponse.dart';

class ApiProvider {
  static const baseUrl = "https://stock-app-du2e.onrender.com/";

  static Future<void> registerUser(dynamic Adata) async {
    if (kDebugMode) {
      print(Adata);
    }
    var url = Uri.parse("${baseUrl}registration");

    final res = await http.post(url,
        body: jsonEncode(Adata), headers: {"Content-Type": "application/json"});

    var jsonResponse = jsonDecode(res.body);
    if (kDebugMode) {
      print(jsonResponse);
    }
    if (kDebugMode) {
      print(res.statusCode);
    }
    try {
      if (res.statusCode == 200) {
        var data = jsonEncode(Adata);

        print("succes registered");
      } else {
        print("Impossible d'accéder à la reponse du serveur");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> loginUser(dynamic Adata) async {
    if (kDebugMode) {
      print(Adata);
    }
    var url = Uri.parse("${baseUrl}login");

    final res = await http.post(url,
        body: jsonEncode(Adata), headers: {"Content-Type": "application/json"});
    var jsonResponse = jsonDecode(res.body);
    if (kDebugMode) {
      print(jsonResponse);
    }
    if (kDebugMode) {
      print(res.statusCode);
    }
    try {
      if (res.statusCode == 200) {
        var data = jsonEncode(Adata);
        NavigationService.navigateTo(RouterGenerator.firstRoute);
        SecurityScreen.isAdmin.value = jsonResponse["isAdmin"];

        if (kDebugMode) {
          print(SecurityScreen.isAdmin.value);
          print(SecurityScreen.isLoaded.value);
        }
        print("succes log");
      } else {
        print(
            "Impossible d'accéder à la reponse du serveur:: ${res.statusCode}");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<DataResponse<dynamic>> addGest(dynamic payload) async {
    var url = Uri.parse("${ApiProvider.baseUrl}registration");
    try {
      Response response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(payload));
      var data = jsonDecode(response.body);
      return DataResponse.fromJson(data);
    } catch (error, stacktrace) {
      debugPrint("Exception occured: $error stackTrace: $stacktrace");
      return DataResponse.withError(error);
    }
  }

  static Future<DataResponse<dynamic>> getProductsList() async {
    var url = Uri.parse("${ApiProvider.baseUrl}products");
    try {
      Response response =
          await http.get(url, headers: {"Content-Type": "application/json"});
      var data = jsonDecode(response.body);
      return DataResponse.fromJson(data);
    } catch (error, stacktrace) {
      debugPrint("Exception occured: $error stackTrace: $stacktrace");
      return DataResponse.withError(error);
    }
  }

  static Future<DataResponse<dynamic>> addProduct(dynamic payload) async {
    var url = Uri.parse("${ApiProvider.baseUrl}add-product");
    try {
      Response response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(payload));
      var data = jsonDecode(response.body);
      return DataResponse.fromJson(data);
    } catch (error, stacktrace) {
      debugPrint("Exception occured: $error stackTrace: $stacktrace");
      return DataResponse.withError(error);
    }
  }

  static Future<DataResponse<dynamic>> updateProduct(
      String id, dynamic payload) async {
    var url = Uri.parse("${ApiProvider.baseUrl}update-products/$id");
    try {
      Response response = await http.put(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(payload));
      var data = jsonDecode(response.body);
      return DataResponse.fromJson(data);
    } catch (error, stacktrace) {
      debugPrint("Exception occured: $error stackTrace: $stacktrace");
      return DataResponse.withError(error);
    }
  }

  static Future<DataResponse<dynamic>> deleteProduct(String id) async {
    var url = Uri.parse("${ApiProvider.baseUrl}delete-products/$id");
    try {
      Response response =
          await http.delete(url, headers: {"Content-Type": "application/json"});
      var data = jsonDecode(response.body);
      return DataResponse.fromJson(data);
    } catch (error, stacktrace) {
      debugPrint("Exception occured: $error stackTrace: $stacktrace");
      return DataResponse.withError(error);
    }
  }

  // static getAllClient(dynamic payload) async {
  //   var url = Uri.parse("${baseUrl}getAllClient");

  //   final res =
  //       await http.get(url, headers: {"Content-Type": "application/json"});
  //   var jsonResponse = jsonDecode(res.body);

  //   payload = jsonResponse["success"];
  //   print("mypayload is : $payload");
  //   try {
  //     if (res.statusCode == 200) {
  //       print("got successfully all clients");
  //       print("etape 1 : $payload");
  //       print("etape 2 $jsonResponse");
  //       print("etape 3 : ${jsonResponse["success"]}");
  //       print("etape 4 : ${jsonResponse["success"][0]}");
  //     } else {
  //       print("Impossible d'accéder à la reponse du serveur");
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // static addProduct(Map cdata) async {
  //   print(cdata);
  //   var url = Uri.parse("${baseUrl}add-product");

  //   final res = await http.post(url, body: cdata);
  //   try {
  //     if (res.statusCode == 200) {
  //       var data = json.decode(json.encode(res.body.toString()));
  //       print(data);
  //       print("succes connect");
  //     } else {
  //       print("Impossible d'accéder à la reponse du serveur");
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }
}
