import 'dart:convert';

import 'package:flutter/material.dart';
import '../model/categories_model.dart';
import '../network/call_api.dart';
import '../network/constant.dart';
import 'package:http/http.dart' as http;

class CategoriesProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _errorMessage = "";

  String get errorMessage => _errorMessage;
  CategoriesModel _list;

  get getCategoriesModelData => _list;

  Future<Null> callAPIForCategoriesData() async {
    _isLoading = true;
    notifyListeners();

    http.Response response =
        await CallAPI().getWithoutHeader(BASE_URL + CATEGORIES);
    int statusCode = response.statusCode;
    print("callAPIForCategoriesData" + statusCode.toString());
    print("callAPIForCategoriesData" + response.body.toString());
    if (statusCode < 200 || statusCode >= 400 || json == null) {
      Map<String, dynamic> mapResponse = json.decode(response.body);
      _errorMessage =
          mapResponse['Message'] != null ? mapResponse['Message'] : "No";
      notifyListeners();
      _isLoading = false;
    } else {
      _isLoading = false;
      _list = CategoriesModel.fromJson(json.decode(response.body));
      print(_list.categories.length.toString());
      notifyListeners();
    }
  }
}
