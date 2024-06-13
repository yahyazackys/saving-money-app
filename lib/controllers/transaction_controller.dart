import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:savingmoney/models/transaction_model.dart';
import 'package:sp_util/sp_util.dart';
import 'package:http/http.dart' as http;

import '../config/config.dart';
import '../home.dart';
import '../pages/LandingPage.dart';
import '../themes/theme.dart';

class TransactionController extends GetxController {
  TextEditingController targetDate = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController amountSpending = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController descriptionSpending = TextEditingController();
  TextEditingController categoryId = TextEditingController();
  TextEditingController missionId = TextEditingController();

  RxBool isLoading = false.obs;
  RxList<TransactionModel> incomeList = RxList<TransactionModel>();
  RxList<TransactionModel> spendingList = RxList<TransactionModel>();
  // RxList<TransactionModel> spendingByMissionList = RxList<TransactionModel>();

  RxDouble totalIncome = 0.0.obs;
  RxDouble totalSpending = 0.0.obs;
  // RxDouble totalSpendingByMission = 0.0.obs;

  void calculateTotals() {
    totalIncome.value = incomeList.fold(0.0, (sum, item) => sum + item.amount);
    totalSpending.value =
        spendingList.fold(0.0, (sum, item) => sum + item.amount);
    // totalSpendingByMission.value =
    //     spendingByMissionList.fold(0.0, (sum, item) => sum + item.amount);
  }

  // void calculateTotalMissionAmount() {
  //   totalSpendingByMission.value = spendingByMissionList.fold(
  //     0.0,
  //     (sum, item) => sum + item.amount,
  //   );
  // }

  // Method to get the total amount
  double get totalAmount => totalIncome.value - totalSpending.value;

  @override
  void onInit() {
    super.onInit();
    ever(incomeList, (_) => calculateTotals());
    ever(spendingList, (_) => calculateTotals());
    // ever(spendingByMissionList, (_) => calculateTotals());
  }

  void clearInputan() {
    targetDate.clear();
    amount.clear();
    description.clear();
    amountSpending.clear();
    descriptionSpending.clear();
  }

  Future<TransactionModel?> addIncome() async {
    var url = Uri.parse('${Config.urlApi}income-add');

    try {
      isLoading.value = true;
      await SpUtil.getInstance();
      String token = SpUtil.getString("token_user") ?? "";
      if (token.isNotEmpty) {
        final response = await http.post(url, headers: {
          'Authorization': 'Bearer $token',
        }, body: {
          'amount': amount.text,
          'description': description.text,
        });

        var responseDecode = json.decode(response.body);

        Map<String, dynamic> dataError = responseDecode["data"];

        if (response.statusCode == 200) {
          clearInputan();

          Get.snackbar(
            "Success",
            responseDecode["message"],
            snackPosition: SnackPosition.TOP,
            backgroundColor: whiteColor,
            colorText: primaryColor,
          );
          isLoading.value = false;
          Get.offAll(const Home(
            initialScreen: Landingpage(),
            onTabChanged: 0,
          ));

          return TransactionModel.fromJson(responseDecode);
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
        }
      } else {
        throw Exception('Empty Token!');
      }
    } catch (e) {
      isLoading.value = false;
      print('Error parsing JSON: $e');
      Get.snackbar(
        "Error",
        e.toString(),
        margin: const EdgeInsets.all(10),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    return null;
  }

  Future<TransactionModel?> addSpending({
    required String amount,
    required String categoryId,
    required String missionId,
    required String description,
  }) async {
    var url = Uri.parse('${Config.urlApi}spending-add');

    try {
      isLoading.value = true;
      await SpUtil.getInstance();
      String token = SpUtil.getString("token_user") ?? "";
      if (token.isNotEmpty) {
        final response = await http.post(url, headers: {
          'Authorization': 'Bearer $token',
        }, body: {
          'amount': amount,
          'category_id': categoryId,
          'missions_id': missionId,
          'description': description,
        });

        var responseDecode = json.decode(response.body);

        Map<String, dynamic> dataError = responseDecode["data"];

        if (response.statusCode == 400) {
          isLoading.value = false;

          Get.snackbar(
            "Error",
            dataError.toString(),
            margin: const EdgeInsets.all(10),
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }

        if (response.statusCode == 200) {
          clearInputan();

          Get.snackbar(
            "Success",
            responseDecode["message"],
            snackPosition: SnackPosition.TOP,
            backgroundColor: whiteColor,
            colorText: primaryColor,
          );
          isLoading.value = false;
          Get.offAll(const Home(
            initialScreen: Landingpage(),
            onTabChanged: 0,
          ));

          return TransactionModel.fromJson(responseDecode);
        }
      } else {
        throw Exception('Empty Token!');
      }
    } catch (e) {
      isLoading.value = false;
      // Get.snackbar(
      //   "Error",
      //   e.toString(),
      //   margin: const EdgeInsets.all(10),
      //   snackPosition: SnackPosition.TOP,
      //   backgroundColor: Colors.red,
      //   colorText: Colors.white,
      // );
    }
    return null;
  }

  Future<List<TransactionModel>> getMissions(String tipe) async {
    String endpoint = "";

    if (tipe == "income") {
      endpoint = "incomes";
    } else if (tipe == "spending") {
      endpoint = "spendings";
    }

    List<TransactionModel> list = [];

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
          list.add(TransactionModel.fromJson(json));
        });
      } else {
        list = [];
      }
    } catch (e) {
      print(e);
    }

    return list;
  }

  Future<void> fetchIncomes() async {
    try {
      List<TransactionModel> tasks = await getMissions("income");
      if (tasks.isNotEmpty) {
        incomeList.assignAll(tasks);
        calculateTotals();
      }
    } catch (e) {
      print("errornya dalaah $e");
    }
    update();
  }

  Future<void> fetchSpendings() async {
    try {
      List<TransactionModel> tasks = await getMissions("spending");
      if (tasks.isNotEmpty) {
        spendingList.assignAll(tasks);
        calculateTotals();
      }
    } catch (e) {
      print("errornya dalaah $e");
    }
    update();
  }

  // Future<void> fetchSpendingByMission(int missionId) async {
  //   try {
  //     List<TransactionModel> tasks = await getMissions("spendingByMission");
  //     if (tasks.isNotEmpty) {
  //       spendingByMissionList.assignAll(tasks);
  //       calculateTotals();
  //     }
  //   } catch (e) {
  //     print("errornya dalaah $e");
  //   }
  //   update();
  // }

  // Future<void> fetchSpendingByMission(int missionId) async {
  //   try {
  //     await SpUtil.getInstance();
  //     String token = SpUtil.getString("token_user") ?? "";
  //     var response = await http.get(
  //       Uri.parse('${Config.urlApi}spending-to-mission/$missionId'),
  //       headers: {'Authorization': 'Bearer $token'},
  //     );

  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> responseData = json.decode(response.body);
  //       List<TransactionModel> spendingData = [];
  //       responseData['data'].forEach((data) {
  //         spendingData.add(TransactionModel.fromJson(data));
  //       });
  //       spendingByMissionList.assignAll(spendingData);
  //       calculateTotals();

  //       print(spendingByMissionList);
  //       update();
  //     } else {
  //       // print('Failed to load task: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     print('Error fetching task: $error');
  //   }
  // }
}
