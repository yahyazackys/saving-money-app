import 'dart:convert';

import 'package:savingmoney/config/config.dart';
import 'package:savingmoney/controllers/transaction_controller.dart';
import 'package:savingmoney/home.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sp_util/sp_util.dart';
import 'package:savingmoney/pages/LandingPage.dart';
import 'package:savingmoney/pages/Login.dart';
import 'package:savingmoney/themes/theme.dart';

import 'mission_controller.dart';

class AuthController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController occupation = TextEditingController();
  TextEditingController noHp = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  TextEditingController emailLogin = TextEditingController();
  TextEditingController passwordLogin = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isObescure = true.obs;
  RxBool isObescure2 = true.obs;
  RxString token = ''.obs;

  final missionC = Get.put(MissionController());
  final transactionC = Get.put(TransactionController());

  void clearInputan() {
    name.clear();
    email.clear();
    occupation.clear();
    noHp.clear();
    password.clear();
    confirmPassword.clear();
    emailLogin.clear();
    passwordLogin.clear();
  }

  // register
  Future register() async {
    // url endpoint
    var url = Uri.parse("${Config.urlApi}register");

    try {
      isLoading.value = true;
      final response = await http.post(url, body: {
        'name': name.text,
        'email': email.text,
        'occupation': occupation.text,
        'phone_number': noHp.text,
        'password': password.text,
        'password_confirmation': confirmPassword.text,
      });

      print(response.body);

      var responseDecode = json.decode(response.body);

      Map<String, dynamic> dataError = responseDecode["data"];

      // cek statusCode dari response
      if (response.statusCode == 200) {
        clearInputan();

        // tampilkan snackbar pesan berhasil
        Get.snackbar(
          "Success",
          responseDecode["message"],
          snackPosition: SnackPosition.TOP,
          backgroundColor: baseColor,
          colorText: primaryColor,
        );

        Get.offAll(const Login());
      } else {
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
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Error",
        e.toString(),
        margin: const EdgeInsets.all(10),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // register
  Future login() async {
    // url endpoint
    var url = Uri.parse("${Config.urlApi}login");

    try {
      isLoading.value = true;

      final response = await http.post(url, body: {
        'email': emailLogin.text,
        'password': passwordLogin.text,
      });

      print(response.body);
      var responseDecode = json.decode(response.body);

      if (response.statusCode == 200) {
        if (responseDecode != null && responseDecode["access_token"] != null) {
          await SpUtil.getInstance();

          SpUtil.putInt("id_user", responseDecode["data"]["id"] ?? 0);
          SpUtil.putString("name_user", responseDecode["data"]["name"] ?? "");
          SpUtil.putString("email_user", responseDecode["data"]["email"] ?? "");
          SpUtil.putString(
              "occupation_user", responseDecode["data"]["occupation"] ?? "");
          SpUtil.putString(
              "nohp_user", responseDecode["data"]["phone_number"] ?? "");
          SpUtil.putString(
              "noprefix_user", responseDecode["data"]["phone_prefix"] ?? "");
          SpUtil.putString("token_user", responseDecode["access_token"] ?? "");
          SpUtil.putString(
              "password_user", responseDecode["data"]["password"] ?? "");
          clearInputan();
          isLoading.value = false;
          // redirect to the home page
          Get.offAll(const Home(
            initialScreen: Landingpage(),
            onTabChanged: 0,
          ));
        } else {
          isLoading.value = false;
          Get.snackbar(
            "Input Data Correctly!",
            "Access token missing",
            showProgressIndicator: true,
            margin: const EdgeInsets.all(10),
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        isLoading.value = false;
        Get.snackbar(
          "Input Data Correctly!",
          responseDecode["message"],
          margin: const EdgeInsets.all(10),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

      // print(response.body);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Erroraa",
        e.toString(),
        margin: const EdgeInsets.all(10),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // logout
  void logout() {
    try {
      isLoading.value = true;
      clearInputan();
      missionC.missionList.clear();
      missionC.clearInputan();

      transactionC.clearInputan();
      transactionC.incomeList.clear();
      transactionC.spendingList.clear();
      transactionC.totalIncome.value = 0.0;
      transactionC.totalSpending.value = 0.0;

      SpUtil.clear();

      // tampilkan snackbar pesan berhasil
      Get.snackbar(
        "Success",
        "Log Out Successfully!",
        margin: const EdgeInsets.all(10),
        snackPosition: SnackPosition.TOP,
        backgroundColor: baseColor,
        colorText: primaryColor,
      );

      isLoading.value = false;

      // redirect ke home page
      Get.offAll(const Login());
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Log Out Failed!",
        e.toString(),
        margin: const EdgeInsets.all(10),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
