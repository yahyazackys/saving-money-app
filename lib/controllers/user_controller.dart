import 'dart:convert';

import 'package:savingmoney/home.dart';
import 'package:savingmoney/pages/Login.dart';
import 'package:savingmoney/pages/Profile.dart';
import 'package:sp_util/sp_util.dart';
import 'package:savingmoney/config/config.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:savingmoney/models/user_model.dart';

import '../themes/theme.dart';

class UserController extends GetxController {
  var isEditing = false.obs;
  RxBool isLoading = false.obs;

  TextEditingController nameUser = TextEditingController(
    text: SpUtil.getString("name_user").toString() == ""
        ? ''
        : SpUtil.getString("name_user").toString(),
  );
  TextEditingController emailUser = TextEditingController(
    text: SpUtil.getString("email_user").toString() == ""
        ? ''
        : SpUtil.getString("email_user").toString(),
  );
  TextEditingController occupationUser = TextEditingController(
    text: SpUtil.getString("occupation_user").toString() == ""
        ? ''
        : SpUtil.getString("occupation_user").toString(),
  );
  TextEditingController nohpUser = TextEditingController(
    text: SpUtil.getString("nohp_user").toString() == ""
        ? ''
        : SpUtil.getString("nohp_user").toString(),
  );
  TextEditingController currentPasswordUser = TextEditingController();
  TextEditingController newPasswordUser = TextEditingController();
  TextEditingController confirmPasswordUser = TextEditingController();

  Future<UserModel> editUser() async {
    var userId = SpUtil.getInt("id_user") ?? 0;
    var url = Uri.parse('${Config.urlApi}user/edit/$userId');

    try {
      isLoading.value = true;
      await SpUtil.getInstance();
      String token = SpUtil.getString("token_user") ?? "";
      if (token.isNotEmpty) {
        // Token memiliki isi, lakukan sesuatu di sini
        final response = await http.post(url, headers: {
          'Authorization': 'Bearer $token',
        }, body: {
          'name': nameUser.text,
          'email': emailUser.text,
          'occupation': occupationUser.text,
          'phone_number': nohpUser.text,
        });
        print(response.body);

        var responseDecode = json.decode(response.body);

        Map<String, dynamic> dataError = responseDecode["data"];
        print(dataError);

        if (response.statusCode == 200) {
          SpUtil.putInt("id_userUpdated", responseDecode["data"]["id"] ?? 0);
          SpUtil.putString(
              "name_userUpdated", responseDecode["data"]["name"] ?? "");
          SpUtil.putString(
              "email_userUpdated", responseDecode["data"]["email"] ?? "");
          SpUtil.putString("occupation_userUpdated",
              responseDecode["data"]["occupation"] ?? "");
          SpUtil.putString(
              "nohp_userUpdated", responseDecode["data"]["phone_number"] ?? "");

          Get.snackbar(
            "Success",
            responseDecode["message"],
            snackPosition: SnackPosition.TOP,
            backgroundColor: whiteColor,
            colorText: primaryColor,
          );
          isLoading.value = false;

          Get.offAll(const Home(
            initialScreen: Profile(),
            onTabChanged: 2,
          ));
          return UserModel.fromJson(responseDecode);
        } else {
          isLoading.value = false;

          Get.snackbar(
            "Error",
            responseDecode["message"] == "Error Validation"
                ? dataError.toString()
                : responseDecode["message"],
            margin: const EdgeInsets.all(10),
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          throw Exception('Failed to edit user: ${response.statusCode}');
        }
      } else {
        throw Exception('Empty Token!');
      }
    } catch (e) {
      print(e);
      throw Exception('Error fetching user data: $e');
    }
  }

  Future<UserModel?> editPassword() async {
    var userId = SpUtil.getInt("id_user") ?? 0;
    var url = Uri.parse('${Config.urlApi}password/edit/$userId');

    try {
      isLoading.value = true;
      await SpUtil.getInstance();
      String token = SpUtil.getString("token_user") ?? "";
      if (token.isNotEmpty) {
        final response = await http.post(
          url,
          headers: {'Authorization': 'Bearer $token'},
          body: {
            'current_password': currentPasswordUser.text,
            'password': newPasswordUser.text,
            'password_confirmation': confirmPasswordUser.text,
          },
        );

        var responseDecode = json.decode(response.body);
        if (responseDecode == null) {
          throw Exception('Invalid response from server');
        }

        if (response.statusCode == 403) {
          Get.snackbar(
            "Error",
            "Current password doesn't match",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } else if (response.statusCode == 200) {
          newPasswordUser.clear();
          confirmPasswordUser.clear();
          isLoading.value = false;
          Get.snackbar(
            "Success",
            responseDecode["message"],
            snackPosition: SnackPosition.TOP,
            backgroundColor: whiteColor,
            colorText: primaryColor,
          );
          Get.offAll(const Home(
            initialScreen: Profile(),
            onTabChanged: 2,
          ));
          return UserModel.fromJson(responseDecode);
        } else {
          isLoading.value = false;
          Map<String, dynamic> dataError = responseDecode["data"] ?? {};
          Get.snackbar(
            "Error",
            responseDecode["message"] == "Error Validation"
                ? dataError.toString()
                : responseDecode["message"],
            margin: const EdgeInsets.all(10),
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return null;
        }
      } else {
        throw Exception('Empty Token!');
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Error : ",
        e.toString(),
        margin: const EdgeInsets.all(10),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return null;
    } finally {
      isLoading.value = false;
    }
    return null;
  }

  Future<UserModel?> deleteUser(BuildContext context) async {
    var userId = SpUtil.getInt("id_user") ?? 0;
    var url = Uri.parse('${Config.urlApi}user/delete/$userId');

    try {
      isLoading.value = true;
      await SpUtil.getInstance();
      String token = SpUtil.getString("token_user") ?? "";
      if (token.isNotEmpty) {
        final response = await http.delete(
          url,
          headers: {'Authorization': 'Bearer $token'},
        );

        var responseDecode = json.decode(response.body);
        if (responseDecode == null) {
          throw Exception('Invalid response from server');
        }

        if (response.statusCode == 200) {
          isLoading.value = false;
          SpUtil.remove("id_user");
          SpUtil.remove("name_user");
          SpUtil.remove("email_user");
          SpUtil.remove("occupation_user");
          SpUtil.remove("nohp_user");
          SpUtil.remove("token_user");
          SpUtil.remove("password_user");

          Get.snackbar(
            "Success",
            responseDecode["message"],
            snackPosition: SnackPosition.TOP,
            backgroundColor: whiteColor,
            colorText: primaryColor,
          );
          Get.offAll(const Login());
          return UserModel.fromJson(responseDecode);
        } else {
          isLoading.value = false;
          Map<String, dynamic> dataError = responseDecode["data"] ?? {};
          Get.snackbar(
            "Error",
            responseDecode["message"] == "Error Validation"
                ? dataError.toString()
                : responseDecode["message"],
            margin: const EdgeInsets.all(10),
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return null;
        }
      } else {
        throw Exception('Empty Token!');
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Error : ",
        e.toString(),
        margin: const EdgeInsets.all(10),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return null;
    } finally {
      isLoading.value = false;
    }
  }
}
