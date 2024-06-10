import 'dart:convert';
import 'package:get/get.dart';
import 'package:savingmoney/models/category_model.dart';
import 'package:sp_util/sp_util.dart';
import 'package:http/http.dart' as http;

import '../config/config.dart';

class CategoryController extends GetxController {
  RxList<CategoryModel> categoryList = RxList<CategoryModel>();
  RxBool isLoading = false.obs;

  Future<List<CategoryModel>> getCategories(String tipe) async {
    String endpoint = "";

    if (tipe == "category") {
      endpoint = "categories";
    }

    List<CategoryModel> listCategories = [];

    try {
      await SpUtil.getInstance();
      String token = SpUtil.getString("token_user") ?? "";
      var response =
          await http.get(Uri.parse(Config.urlApi + endpoint), headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        List listCategoryResponse = responseBody['data'];
        print(listCategoryResponse);

        listCategoryResponse.forEach((json) {
          listCategories.add(CategoryModel.fromJson(json));
        });
      } else {
        listCategories = [];
      }
    } catch (e) {
      print(e);
    }

    return listCategories;
  }

  Future<void> fetchCategories() async {
    try {
      List<CategoryModel> tasks = await getCategories("category");
      if (tasks.isNotEmpty) {
        categoryList.assignAll(tasks);
      }
    } catch (e) {
      print("errornya dalaah $e");
    }
    update();
  }
}
