// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:sp_util/sp_util.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SavingController extends GetxController {
  var isEditing = false.obs;
  RxBool isLoading = false.obs;
  TextEditingController amount = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController targetDate = TextEditingController();

  void clearAddTask() {
    amount.clear();
    description.clear();
    targetDate.clear();
    description.clear();
  }
}
