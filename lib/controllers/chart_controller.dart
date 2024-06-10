import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sp_util/sp_util.dart';

import '../config/config.dart';
import '../models/chart_model.dart';

class ChartController extends GetxController {
  RxList<IncomeData> incomeData = <IncomeData>[].obs;
  RxList<SpendingData> spendingData = <SpendingData>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchChartData();
  }

  Future<void> fetchChartData() async {
    try {
      isLoading(true);
      await SpUtil.getInstance();
      String token = SpUtil.getString("token_user") ?? "";
      var response = await http.get(
        Uri.parse('${Config.urlApi}chart'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        var data = responseData['data'];
        incomeData.value = data['income'].entries.map<IncomeData>((entry) {
          return IncomeData(
            entry.key,
            entry.value.toDouble(),
          );
        }).toList();

        spendingData.value =
            data['spending'].entries.map<SpendingData>((entry) {
          return SpendingData(
            entry.key,
            entry.value.toDouble(),
          );
        }).toList();
      } else {
        print('Failed to load chart data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching chart data: $error');
    } finally {
      isLoading(false);
    }
  }
}
