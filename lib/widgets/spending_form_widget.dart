import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savingmoney/controllers/category_controller.dart';
import 'package:savingmoney/controllers/mission_controller.dart';
import 'package:savingmoney/controllers/transaction_controller.dart';
import 'package:savingmoney/models/mission_model.dart';

import '../models/category_model.dart';
import '../themes/theme.dart';

class SpendingFormWidget extends StatefulWidget {
  const SpendingFormWidget({super.key});

  @override
  State<SpendingFormWidget> createState() => _SpendingFormWidgetState();
}

class _SpendingFormWidgetState extends State<SpendingFormWidget> {
  final transactionC = Get.put(TransactionController());
  final categoryC = Get.put(CategoryController());
  final missionC = Get.put(MissionController());

  CategoryModel? selectedCategory;
  MissionModel? selectedMission;
  bool categoryToggled = true;
  bool missionToggled = false;

  void categoryToggleButton() {
    setState(() {
      if (!categoryToggled) {
        categoryToggled = true;
        missionToggled = false;
        selectedMission = null;
      }
    });
  }

  void missionToggleButton() {
    setState(() {
      if (!missionToggled) {
        missionToggled = true;
        categoryToggled = false;
        selectedCategory = null;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    selectedCategory = null;
    selectedMission = null;
    categoryC.fetchCategories();
    missionC.fetchMissions();
  }

  void _submitSpending() async {
    if (selectedCategory != null || selectedMission != null) {
      try {
        await transactionC.addSpending(
          amount: transactionC.amountSpending.text,
          categoryId: selectedCategory?.id.toString() ?? "",
          missionId: selectedMission?.id.toString() ?? "",
          description: transactionC.descriptionSpending.text,
        );
      } catch (e) {
        print('Error submitting spending: $e');
        Get.snackbar(
          "Error",
          "An error occurred while submitting the spending.",
          margin: const EdgeInsets.all(10),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "Please Input Data Correctly!",
        margin: const EdgeInsets.all(10),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Amount",
            style: blackTextStyle.copyWith(
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 2,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: TextField(
              controller: transactionC.amountSpending,
              style: blackTextStyle.copyWith(
                fontSize: 13,
              ),
              decoration: InputDecoration(
                hintStyle: subTextStyle.copyWith(
                  fontSize: 13,
                ),
                hintText: 'Amount...',
                iconColor: const Color(0xff8D92A3),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(15),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Flexible(
                flex: 1,
                child: GestureDetector(
                  onTap: categoryToggleButton,
                  child: categoryToggled
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            border: Border.all(
                              color: baseColor,
                              width: 0.2,
                            ),
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            // horizontal: 20,
                            vertical: 16,
                          ),
                          child: Text(
                            "Category",
                            style: whiteTextStyle.copyWith(
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            border: Border.all(
                              color: baseColor,
                              width: 0.2,
                            ),
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            // horizontal: 20,
                            vertical: 16,
                          ),
                          child: Text(
                            "Category",
                            style: primaryTextStyle.copyWith(
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Flexible(
                flex: 1,
                child: GestureDetector(
                    onTap: missionToggleButton,
                    child: missionToggled
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              border: Border.all(
                                color: baseColor,
                                width: 0.2,
                              ),
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              // horizontal: 20,
                              vertical: 16,
                            ),
                            child: Text(
                              "Mission",
                              style: whiteTextStyle.copyWith(
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: whiteColor,
                              border: Border.all(
                                color: baseColor,
                                width: 0.2,
                              ),
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              // horizontal: 20,
                              vertical: 16,
                            ),
                            child: Text(
                              "Mission",
                              style: primaryTextStyle.copyWith(
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          categoryToggled
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 2,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Obx(() {
                      if (categoryC.isLoading == true) {
                        return const CircularProgressIndicator();
                      } else if (categoryC.categoryList.isEmpty) {
                        return Text(
                          'No categories available',
                          style: subTextStyle.copyWith(
                            fontSize: 13,
                          ),
                        );
                      } else {
                        return DropdownButtonHideUnderline(
                          child: DropdownButton<CategoryModel>(
                            hint: Text(
                              'Select Category...',
                              style: subTextStyle.copyWith(
                                fontSize: 13,
                              ),
                            ),
                            value: categoryC.categoryList
                                    .contains(selectedCategory)
                                ? selectedCategory
                                : null,
                            isExpanded: true,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: blackColor,
                            ),
                            style: blackTextStyle.copyWith(
                              fontSize: 13,
                            ),
                            onChanged: (CategoryModel? newValue) {
                              setState(() {
                                selectedCategory = newValue;
                                transactionC.categoryId.text =
                                    newValue!.id.toString();
                              });
                            },
                            items: categoryC.categoryList
                                .map((CategoryModel category) {
                              return DropdownMenuItem<CategoryModel>(
                                value: category,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  child: Text(
                                    category.name,
                                    style: blackTextStyle.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      }
                    }),
                  ),
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 2,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Obx(() {
                      if (missionC.isLoading == true) {
                        return const CircularProgressIndicator();
                      } else if (missionC.missionList.isEmpty) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            // horizontal: 10,
                          ),
                          child: Text(
                            'No Missions Available',
                            style: blackTextStyle.copyWith(
                              fontSize: 13,
                            ),
                          ),
                        );
                      } else {
                        return DropdownButtonHideUnderline(
                          child: DropdownButton<MissionModel>(
                            hint: Text(
                              'Select Mission...',
                              style: subTextStyle.copyWith(
                                fontSize: 13,
                              ),
                            ),
                            value:
                                missionC.missionList.contains(selectedMission)
                                    ? selectedMission
                                    : null,
                            isExpanded: true,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: blackColor,
                            ),
                            style: blackTextStyle.copyWith(
                              fontSize: 13,
                            ),
                            onChanged: (MissionModel? newValue) {
                              setState(() {
                                selectedMission = newValue;
                                transactionC.missionId.text =
                                    newValue!.id.toString();
                              });
                            },
                            items: missionC.missionList
                                .map((MissionModel mission) {
                              return DropdownMenuItem<MissionModel>(
                                value: mission,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  child: Text(
                                    mission.title,
                                    style: blackTextStyle.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      }
                    }),
                  ),
                ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Information",
            style: blackTextStyle.copyWith(
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 2,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: TextField(
              controller: transactionC.descriptionSpending,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              style: blackTextStyle.copyWith(
                fontSize: 13,
              ),
              decoration: InputDecoration(
                hintStyle: subTextStyle.copyWith(
                  fontSize: 13,
                ),
                hintText: 'Information...',
                iconColor: const Color(0xff8D92A3),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(15),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: _submitSpending,
            child: Container(
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(100),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 16,
              ),
              child: Center(
                child: Text(
                  'Submit',
                  style: whiteTextStyle.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
