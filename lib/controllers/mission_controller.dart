import 'dart:convert';
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:savingmoney/notification_helper.dart';
import 'package:sp_util/sp_util.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../config/config.dart';
import '../home.dart';
import '../models/mission_model.dart';
import '../models/transaction_model.dart';
import '../pages/LandingPage.dart';
import '../themes/theme.dart';
import 'transaction_controller.dart';

class MissionController extends GetxController {
  final tC = Get.put(TransactionController());
  TextEditingController targetDate = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController categoryId = TextEditingController();
  TextEditingController title = TextEditingController();

  RxBool isLoading = false.obs;
  RxList<MissionModel> missionList = RxList<MissionModel>();
  RxList<TransactionModel> spendingByMissionList = <TransactionModel>[].obs;
  RxDouble totalSpendingByMission = 0.0.obs;

  void clearInputan() {
    targetDate.clear();
    amount.clear();
    description.clear();
    title.clear();
  }

  Future<MissionModel?> addMission({
    required String title,
    required String targetAmount,
    required String targetDate,
    required String categoryId,
    // required String description,
  }) async {
    var url = Uri.parse('${Config.urlApi}mission-add');

    try {
      isLoading.value = true;
      await SpUtil.getInstance();
      String token = SpUtil.getString("token_user") ?? "";
      if (token.isNotEmpty) {
        final response = await http.post(url, headers: {
          'Authorization': 'Bearer $token',
        }, body: {
          'title': title,
          'target_amount': targetAmount,
          'target_date': targetDate,
          'category_id': categoryId,
          // 'description': description,
        });

        print("Response Body: ${response.body}");

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

          return MissionModel.fromJson(responseDecode);
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
      // print('Error parsing JSON: $e');
      // Get.snackbar(
      //   "Error",
      //   "$e",
      //   margin: const EdgeInsets.all(10),
      //   snackPosition: SnackPosition.BOTTOM,
      //   backgroundColor: Colors.red,
      //   colorText: Colors.white,
      // );
    }
    return null;
  }

  Future<List<MissionModel>> getMissions(String tipe) async {
    String endpoint = "";

    if (tipe == "mission") {
      endpoint = "missions";
    }

    List<MissionModel> listMissions = [];

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
          listMissions.add(MissionModel.fromJson(json));
        });
      } else {
        listMissions = [];
      }
    } catch (e) {
      print(e);
    }

    return listMissions;
  }

  Future<void> fetchMissions() async {
    try {
      List<MissionModel> tasks = await getMissions("mission");
      if (tasks.isNotEmpty) {
        missionList.assignAll(tasks);
        for (var mission in tasks) {
          await fetchSpendingByMission(mission);
        }
      }
    } catch (e) {
      print("errornya dalaah $e");
    }
    update();
  }

  Future<void> fetchSpendingByMission(MissionModel mission) async {
    try {
      await SpUtil.getInstance();
      String token = SpUtil.getString("token_user") ?? "";
      var response = await http.get(
        Uri.parse('${Config.urlApi}spending-to-mission/${mission.id}'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        List<TransactionModel> spendingData = [];
        responseData['data'].forEach((data) {
          spendingData.add(TransactionModel.fromJson(data));
        });
        spendingByMissionList.assignAll(spendingData);
        calculateTotals(mission);
        tC.update();
      } else {
        // print('Failed to load spending data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching spending data: $error');
    }
  }

  Future<void> fetchNotif() async {
    try {
      await SpUtil.getInstance();
      String token = SpUtil.getString("token_user") ?? "";
      var response = await http.get(
        Uri.parse('${Config.urlApi}send-whatsapp-notification'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        print("success");
      } else {
        print('Failed to load spending data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching spending data: $error');
    }
  }

  void calculateTotals(MissionModel mission) {
    totalSpendingByMission.value = spendingByMissionList
        .where((transaction) => transaction.missionId == mission.id)
        .fold(0, (sum, transaction) => sum + transaction.amount);

    if (totalSpendingByMission >= mission.targetAmount) {
      missionList.remove(mission);
    }
  }
}
