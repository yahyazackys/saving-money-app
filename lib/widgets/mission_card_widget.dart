import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:savingmoney/controllers/mission_controller.dart';
import 'package:savingmoney/models/mission_model.dart';
import 'package:sp_util/sp_util.dart';
import 'package:http/http.dart' as http;

import '../config/config.dart';
import '../controllers/transaction_controller.dart';
import '../models/transaction_model.dart';
import '../themes/theme.dart';

class MissionCardWidget extends StatelessWidget {
  final MissionModel mission;
  const MissionCardWidget({required this.mission, super.key});

  @override
  Widget build(BuildContext context) {
    final tC = Get.put(TransactionController());
    // final missionC = Get.put(MissionController());
    RxList<TransactionModel> spendingByMissionList = RxList<TransactionModel>();
    RxDouble totalSpendingByMission = 0.0.obs;

    void calculateTotals() {
      totalSpendingByMission.value =
          spendingByMissionList.fold(0.0, (sum, item) => sum + item.amount);
    }

    Future<void> fetchSpendingByMission() async {
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
          calculateTotals();
          print(spendingByMissionList);
          tC.update();
        } else {
          print('Failed to load task: ${response.statusCode}');
        }
      } catch (error) {
        print('Error fetching task: $error');
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchSpendingByMission();
    });

    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      // height: 130,
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 20,
      ),
      margin: const EdgeInsets.only(
        left: 30,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              DateFormat('d MMM yyyy').format(DateTime.parse(
                mission.targetDate,
              )),
              style: whiteTextStyle.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Target",
                style: blackTextStyle.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
              Text(
                "RM ${mission.targetAmount.toStringAsFixed(0).replaceAllMapped(
                      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                      (Match match) => '${match[1]},',
                    )}",
                style: blackTextStyle.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Information",
                style: blackTextStyle.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                ),
              ),
              Text(
                mission.title,
                style: blackTextStyle.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Category",
                style: blackTextStyle.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                ),
              ),
              Text(
                mission.category!.name,
                style: blackTextStyle.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Amount",
                style: blackTextStyle.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
              Obx(() {
                return Text(
                  "RM ${totalSpendingByMission.toStringAsFixed(0).replaceAllMapped(
                        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                        (Match match) => '${match[1]},',
                      )}",
                  style: blackTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
