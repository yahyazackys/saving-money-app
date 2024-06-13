import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savingmoney/controllers/chart_controller.dart';
import 'package:savingmoney/notification_helper.dart';
import 'package:savingmoney/themes/theme.dart';
import 'package:savingmoney/widgets/income_form_widget.dart';
import 'package:savingmoney/widgets/mission_card_widget.dart';
import 'package:savingmoney/widgets/mission_form_widget.dart';
import 'package:savingmoney/widgets/spending_form_widget.dart';
import 'package:sp_util/sp_util.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../controllers/mission_controller.dart';
import '../controllers/transaction_controller.dart';
import '../models/chart_model.dart';

class Landingpage extends StatefulWidget {
  const Landingpage({super.key});

  @override
  State<Landingpage> createState() => _LandingpageState();
}

class _LandingpageState extends State<Landingpage> {
  final missionC = Get.put(MissionController());
  final tC = Get.put(TransactionController());
  final chartC = Get.put(ChartController());
  final NotificationHelper notifyHelper = NotificationHelper();

  int currentTab = 0;

  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    _focusNode2.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    chartC.fetchChartData();
    tC.fetchIncomes();
    tC.fetchSpendings();
    initializeData();
  }

  void initializeData() async {
    await notifyHelper.scheduledNotification();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
        _focusNode2.unfocus();
      },
      child: Scaffold(
        backgroundColor: primaryColor,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 80,
                  bottom: 40,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Center(
                        child: Text(
                          SpUtil.getString("name_userUpdated").toString() == ""
                              ? "Hi, " +
                                  SpUtil.getString("name_user").toString()
                              : "Hi, " +
                                  SpUtil.getString("name_userUpdated")
                                      .toString(),
                          style: whiteTextStyle.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        "Total Amount",
                        style: subTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Obx(() {
                      double totalAmount = tC.totalAmount;
                      return Center(
                        child: Text(
                          totalAmount < 0
                              ? "- RM ${(-totalAmount).toStringAsFixed(0).replaceAllMapped(
                                    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                    (Match match) => '${match[1]},',
                                  )}"
                              : "RM ${totalAmount.toStringAsFixed(0).replaceAllMapped(
                                    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                    (Match match) => '${match[1]},',
                                  )}",
                          style: whiteTextStyle.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      );
                    }),
                    // InkWell(
                    //   onTap: () {
                    //     notifyHelper.scheduleNotification();
                    //     // notifyHelper.displayNotification(
                    //     //   title: 'yahya gantenk',
                    //     //   body: 'irfan jelek, danil jelek',
                    //     // );
                    //   },
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(80),
                    //       border: Border.all(
                    //         color: primaryColor,
                    //       ),
                    //       color: greenColor,
                    //     ),
                    //     padding: const EdgeInsets.symmetric(
                    //       horizontal: 26,
                    //       vertical: 8,
                    //     ),
                    //     child: Text(
                    //       'Incomefud',
                    //       style: whiteTextStyle.copyWith(
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 16,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // InkWell(
                    //   onTap: () {
                    //     notifyHelper.scheduledNotification();
                    //     // notifyHelper.displayNotification(
                    //     //   title: 'yahya gantenk',
                    //     //   body: 'irfan jelek, danil jelek',
                    //     // );
                    //   },
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(80),
                    //       border: Border.all(
                    //         color: primaryColor,
                    //       ),
                    //       color: greenColor,
                    //     ),
                    //     padding: const EdgeInsets.symmetric(
                    //       horizontal: 26,
                    //       vertical: 8,
                    //     ),
                    //     child: Text(
                    //       'Incomefudawdwadd',
                    //       style: whiteTextStyle.copyWith(
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 16,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 40),
                    missionC.missionList.isEmpty
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(
                              left: 30,
                              top: 40,
                            ),
                            child: Text(
                              "Mission Goals",
                              style: whiteTextStyle.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                    const SizedBox(height: 10),
                    Obx(() {
                      if (missionC.missionList.isEmpty) {
                        return Container();
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //     top: 10,
                        //   ),
                        //   child: Center(
                        //     child: Column(
                        //       children: [
                        //         Image.asset(
                        //           'assets/empty.png',
                        //           width: 100,
                        //         ),
                        //         Text(
                        //           "Mission Goals Empty",
                        //           style: whiteTextStyle.copyWith(
                        //             fontSize: 18,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // );
                      } else {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: missionC.missionList.map((mission) {
                              return GestureDetector(
                                onTap: () {
                                  // Get.to(DetailPriorityTask(
                                  //   priority: task,
                                  // ));
                                },
                                child: MissionCardWidget(mission: mission),
                              );
                            }).toList(),
                          ),
                        );
                      }
                    }),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              child: Container(
                margin: const EdgeInsets.only(
                    // top: 450,
                    ),
                child: Stack(
                  children: [
                    Positioned(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        padding: const EdgeInsets.only(
                          top: 100,
                          bottom: 60,
                        ),
                        margin: const EdgeInsets.only(
                          top: 100,
                        ),
                        decoration: BoxDecoration(
                          color: lightColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60),
                          ),
                        ),
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Text(
                                  "Savings Menu",
                                  style: blackTextStyle.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              currentTab = 0;
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(80),
                                              border: Border.all(
                                                color: primaryColor,
                                              ),
                                              color: currentTab == 0
                                                  ? primaryColor
                                                  : Colors.transparent,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 22,
                                              vertical: 8,
                                            ),
                                            child: Text(
                                              'Income',
                                              style: currentTab == 0
                                                  ? whiteTextStyle.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    )
                                                  : primaryTextStyle.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              currentTab = 1;
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(80),
                                              border: Border.all(
                                                color: primaryColor,
                                              ),
                                              color: currentTab == 1
                                                  ? primaryColor
                                                  : Colors.transparent,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 22,
                                              vertical: 8,
                                            ),
                                            child: Text(
                                              'Spending',
                                              style: currentTab == 1
                                                  ? whiteTextStyle.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    )
                                                  : primaryTextStyle.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              currentTab = 2;
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(80),
                                              border: Border.all(
                                                color: primaryColor,
                                              ),
                                              color: currentTab == 2
                                                  ? primaryColor
                                                  : Colors.transparent,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 22,
                                              vertical: 8,
                                            ),
                                            child: Text(
                                              'Mission',
                                              style: currentTab == 2
                                                  ? whiteTextStyle.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    )
                                                  : primaryTextStyle.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    currentTab == 0
                                        ? IncomeFormWidget(
                                            amount: _focusNode,
                                            information: _focusNode2,
                                          )
                                        : Container(),
                                    currentTab == 1
                                        ? const SpendingFormWidget()
                                        : Container(),
                                    currentTab == 2
                                        ? const MissionFormWidget()
                                        : Container(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        // color: whiteColor,
                        child: Obx(() {
                          if (chartC.isLoading.value) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            return Center(
                              child: SingleChildScrollView(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  // height: 300,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0C1F63),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 180,
                                        child: SfCartesianChart(
                                          // title: const ChartTitle(
                                          //   text: 'Monthly Analysis',
                                          // ),
                                          legend: const Legend(
                                            isVisible: true,
                                            textStyle: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          primaryXAxis: const CategoryAxis(
                                            // title: AxisTitle(
                                            //   text: 'Month',
                                            // ),
                                            labelStyle: TextStyle(
                                              color: Colors.white,
                                            ),
                                            // majorGridLines: MajorGridLines(
                                            //   width: 0,
                                            // ),
                                          ),
                                          primaryYAxis: const NumericAxis(
                                            // title: AxisTitle(
                                            //   text: 'Amount (RM)',
                                            // ),
                                            labelStyle: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          series: <LineSeries>[
                                            LineSeries<IncomeData, String>(
                                              dataSource: chartC.incomeData,
                                              xValueMapper:
                                                  (IncomeData data, _) =>
                                                      data.monthYear,
                                              yValueMapper:
                                                  (IncomeData data, _) =>
                                                      data.amount,
                                              name: 'Income',
                                              markerSettings:
                                                  const MarkerSettings(
                                                isVisible: true,
                                              ),
                                              dataLabelSettings:
                                                  const DataLabelSettings(
                                                isVisible: true,
                                                labelAlignment:
                                                    ChartDataLabelAlignment.top,
                                                textStyle: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            LineSeries<SpendingData, String>(
                                              dataSource: chartC.spendingData,
                                              xValueMapper:
                                                  (SpendingData data, _) =>
                                                      data.monthYear,
                                              yValueMapper:
                                                  (SpendingData data, _) =>
                                                      data.amount,
                                              name: 'Spending',
                                              markerSettings:
                                                  const MarkerSettings(
                                                isVisible: true,
                                              ),
                                              // dataLabelSettings: DataLabelSettings(
                                              //   isVisible:
                                              //       true, // Menampilkan data label
                                              //   labelAlignment:
                                              //       ChartDataLabelAlignment
                                              //           .top, // Penataan label data
                                              //   textStyle: TextStyle(
                                              //     color: Colors.white, // Warna teks
                                              //   ),
                                              // ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // Column(
        //   children: [
        //     Container(
        //       padding: const EdgeInsets.symmetric(
        //         // horizontal: 20,
        //         vertical: 60,
        //       ),
        //       width: MediaQuery.of(context).size.width,
        //       // height: MediaQuery.of(context).size.height,
        //       decoration: BoxDecoration(
        //         color: Colors.transparent,
        //       ),
        //       child: SafeArea(
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Center(
        //               child: Text(
        //                 SpUtil.getString("name_userUpdated").toString() == ""
        //                     ? "Hi, " +
        //                         SpUtil.getString("name_user").toString() +
        //                         " Welcome Back!"
        //                     : "Hi, " +
        //                         SpUtil.getString("name_userUpdated").toString() +
        //                         " Welcome Back!",
        //                 style: whiteTextStyle.copyWith(
        //                   fontSize: 24,
        //                   fontWeight: FontWeight.w700,
        //                 ),
        //               ),
        //             ),
        //             const SizedBox(height: 10),
        //             Center(
        //               child: Text(
        //                 "Total Amount",
        //                 style: subTextStyle.copyWith(
        //                   fontSize: 12,
        //                   fontWeight: FontWeight.w700,
        //                 ),
        //               ),
        //             ),
        //             const SizedBox(height: 6),
        //             Obx(() {
        //               double totalAmount = tC.totalAmount;
        //               return Center(
        //                 child: Text(
        //                   totalAmount < 0
        //                       ? "- RM ${(-totalAmount).toStringAsFixed(0).replaceAllMapped(
        //                             RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        //                             (Match match) => '${match[1]},',
        //                           )}"
        //                       : "RM ${totalAmount.toStringAsFixed(0).replaceAllMapped(
        //                             RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        //                             (Match match) => '${match[1]},',
        //                           )}",
        //                   style: whiteTextStyle.copyWith(
        //                     fontSize: 24,
        //                     fontWeight: FontWeight.w700,
        //                   ),
        //                 ),
        //               );
        //             }),
        //             const SizedBox(height: 40),
        //             Padding(
        //               padding: const EdgeInsets.only(left: 30),
        //               child: Text(
        //                 "Mission Goals",
        //                 style: whiteTextStyle.copyWith(
        //                   fontSize: 20,
        //                   fontWeight: FontWeight.w700,
        //                 ),
        //                 textAlign: TextAlign.start,
        //               ),
        //             ),
        //             const SizedBox(height: 10),
        //             Obx(() {
        //               if (missionC.missionList.isEmpty) {
        //                 return Padding(
        //                   padding: const EdgeInsets.only(
        //                     top: 10,
        //                   ),
        //                   child: Center(
        //                     child: Column(
        //                       children: [
        //                         Image.asset(
        //                           'assets/empty.png',
        //                           width: 100,
        //                         ),
        //                         Text(
        //                           "Mission Goals Empty",
        //                           style: whiteTextStyle.copyWith(
        //                             fontSize: 18,
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 );
        //               } else {
        //                 return SingleChildScrollView(
        //                   scrollDirection: Axis.horizontal,
        //                   child: Row(
        //                     children: missionC.missionList.map((mission) {
        //                       return GestureDetector(
        //                         onTap: () {
        //                           // Get.to(DetailPriorityTask(
        //                           //   priority: task,
        //                           // ));
        //                         },
        //                         child: MissionCardWidget(mission: mission),
        //                       );
        //                     }).toList(),
        //                   ),
        //                 );
        //               }
        //             }),
        //           ],
        //         ),
        //       ),
        //     ),
        //     Expanded(
        //       child: SingleChildScrollView(
        //         scrollDirection: Axis.vertical,
        //         child: Container(
        //           margin: const EdgeInsets.only(
        //               // top: 450,
        //               ),
        //           child: Stack(
        //             children: [
        //               Positioned(
        //                 child: Container(
        //                   width: MediaQuery.of(context).size.width,
        //                   height: MediaQuery.of(context).size.height,
        //                   padding: const EdgeInsets.only(
        //                     top: 100,
        //                     bottom: 60,
        //                   ),
        //                   margin: const EdgeInsets.only(
        //                     top: 100,
        //                   ),
        //                   decoration: BoxDecoration(
        //                     color: lightColor,
        //                     borderRadius: const BorderRadius.only(
        //                       topLeft: Radius.circular(60),
        //                       topRight: Radius.circular(60),
        //                     ),
        //                   ),
        //                   child: SingleChildScrollView(
        //                     physics: const NeverScrollableScrollPhysics(),
        //                     child: Column(
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       children: [
        //                         Padding(
        //                           padding:
        //                               const EdgeInsets.symmetric(horizontal: 30),
        //                           child: Text(
        //                             "Savings Menu",
        //                             style: blackTextStyle.copyWith(
        //                               fontSize: 20,
        //                               fontWeight: FontWeight.w700,
        //                             ),
        //                           ),
        //                         ),
        //                         const SizedBox(height: 10),
        //                         Padding(
        //                           padding: const EdgeInsets.symmetric(
        //                             horizontal: 30,
        //                           ),
        //                           child: Column(
        //                             children: [
        //                               Row(
        //                                 mainAxisAlignment:
        //                                     MainAxisAlignment.spaceBetween,
        //                                 children: [
        //                                   GestureDetector(
        //                                     onTap: () {
        //                                       setState(() {
        //                                         currentTab = 0;
        //                                       });
        //                                     },
        //                                     child: Container(
        //                                       decoration: BoxDecoration(
        //                                         borderRadius:
        //                                             BorderRadius.circular(80),
        //                                         border: Border.all(
        //                                           color: primaryColor,
        //                                         ),
        //                                         color: currentTab == 0
        //                                             ? primaryColor
        //                                             : Colors.transparent,
        //                                       ),
        //                                       padding: const EdgeInsets.symmetric(
        //                                         horizontal: 30,
        //                                         vertical: 8,
        //                                       ),
        //                                       child: Text(
        //                                         'Income',
        //                                         style: currentTab == 0
        //                                             ? whiteTextStyle.copyWith(
        //                                                 fontWeight:
        //                                                     FontWeight.bold,
        //                                                 fontSize: 16,
        //                                               )
        //                                             : primaryTextStyle.copyWith(
        //                                                 fontWeight:
        //                                                     FontWeight.bold,
        //                                                 fontSize: 16,
        //                                               ),
        //                                       ),
        //                                     ),
        //                                   ),
        //                                   GestureDetector(
        //                                     onTap: () {
        //                                       setState(() {
        //                                         currentTab = 1;
        //                                       });
        //                                     },
        //                                     child: Container(
        //                                       decoration: BoxDecoration(
        //                                         borderRadius:
        //                                             BorderRadius.circular(80),
        //                                         border: Border.all(
        //                                           color: primaryColor,
        //                                         ),
        //                                         color: currentTab == 1
        //                                             ? primaryColor
        //                                             : Colors.transparent,
        //                                       ),
        //                                       padding: const EdgeInsets.symmetric(
        //                                         horizontal: 30,
        //                                         vertical: 8,
        //                                       ),
        //                                       child: Text(
        //                                         'Spending',
        //                                         style: currentTab == 1
        //                                             ? whiteTextStyle.copyWith(
        //                                                 fontWeight:
        //                                                     FontWeight.bold,
        //                                                 fontSize: 16,
        //                                               )
        //                                             : primaryTextStyle.copyWith(
        //                                                 fontWeight:
        //                                                     FontWeight.bold,
        //                                                 fontSize: 16,
        //                                               ),
        //                                       ),
        //                                     ),
        //                                   ),
        //                                   GestureDetector(
        //                                     onTap: () {
        //                                       setState(() {
        //                                         currentTab = 2;
        //                                       });
        //                                     },
        //                                     child: Container(
        //                                       decoration: BoxDecoration(
        //                                         borderRadius:
        //                                             BorderRadius.circular(80),
        //                                         border: Border.all(
        //                                           color: primaryColor,
        //                                         ),
        //                                         color: currentTab == 2
        //                                             ? primaryColor
        //                                             : Colors.transparent,
        //                                       ),
        //                                       padding: const EdgeInsets.symmetric(
        //                                         horizontal: 30,
        //                                         vertical: 8,
        //                                       ),
        //                                       child: Text(
        //                                         'Mission',
        //                                         style: currentTab == 2
        //                                             ? whiteTextStyle.copyWith(
        //                                                 fontWeight:
        //                                                     FontWeight.bold,
        //                                                 fontSize: 16,
        //                                               )
        //                                             : primaryTextStyle.copyWith(
        //                                                 fontWeight:
        //                                                     FontWeight.bold,
        //                                                 fontSize: 16,
        //                                               ),
        //                                       ),
        //                                     ),
        //                                   ),
        //                                 ],
        //                               ),
        //                               const SizedBox(height: 20),
        //                               currentTab == 0
        //                                   ? const IncomeFormWidget()
        //                                   : Container(),
        //                               currentTab == 1
        //                                   ? const SpendingFormWidget()
        //                                   : Container(),
        //                               currentTab == 2
        //                                   ? const MissionFormWidget()
        //                                   : Container(),
        //                             ],
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //               Container(
        //                 width: MediaQuery.of(context).size.width,
        //                 // color: whiteColor,
        //                 child: Obx(() {
        //                   if (chartC.isLoading.value) {
        //                     return const Center(
        //                         child: CircularProgressIndicator());
        //                   } else {
        //                     return Center(
        //                       child: SingleChildScrollView(
        //                         child: Container(
        //                           width: MediaQuery.of(context).size.width * 0.75,
        //                           // height: 300,
        //                           decoration: BoxDecoration(
        //                             color: const Color(0xFF0C1F63),
        //                             borderRadius: BorderRadius.circular(30),
        //                           ),
        //                           child: Column(
        //                             mainAxisAlignment: MainAxisAlignment.center,
        //                             crossAxisAlignment: CrossAxisAlignment.center,
        //                             children: [
        //                               SizedBox(
        //                                 height: 180,
        //                                 child: SfCartesianChart(
        //                                   // title: const ChartTitle(
        //                                   //   text: 'Monthly Analysis',
        //                                   // ),
        //                                   legend: const Legend(
        //                                     isVisible: true,
        //                                     textStyle: TextStyle(
        //                                       color: Colors.white,
        //                                     ),
        //                                   ),
        //                                   primaryXAxis: const CategoryAxis(
        //                                     // title: AxisTitle(
        //                                     //   text: 'Month',
        //                                     // ),
        //                                     labelStyle: TextStyle(
        //                                       color: Colors.white,
        //                                     ),
        //                                     // majorGridLines: MajorGridLines(
        //                                     //   width: 0,
        //                                     // ),
        //                                   ),
        //                                   primaryYAxis: const NumericAxis(
        //                                     // title: AxisTitle(
        //                                     //   text: 'Amount (RM)',
        //                                     // ),
        //                                     labelStyle: TextStyle(
        //                                       color: Colors.white,
        //                                     ),
        //                                   ),
        //                                   series: <LineSeries>[
        //                                     LineSeries<IncomeData, String>(
        //                                       dataSource: chartC.incomeData,
        //                                       xValueMapper:
        //                                           (IncomeData data, _) =>
        //                                               data.monthYear,
        //                                       yValueMapper:
        //                                           (IncomeData data, _) =>
        //                                               data.amount,
        //                                       name: 'Income',
        //                                       markerSettings:
        //                                           const MarkerSettings(
        //                                         isVisible: true,
        //                                       ),
        //                                       dataLabelSettings:
        //                                           const DataLabelSettings(
        //                                         isVisible: true,
        //                                         labelAlignment:
        //                                             ChartDataLabelAlignment.top,
        //                                         textStyle: TextStyle(
        //                                           color: Colors.white,
        //                                         ),
        //                                       ),
        //                                     ),
        //                                     LineSeries<SpendingData, String>(
        //                                       dataSource: chartC.spendingData,
        //                                       xValueMapper:
        //                                           (SpendingData data, _) =>
        //                                               data.monthYear,
        //                                       yValueMapper:
        //                                           (SpendingData data, _) =>
        //                                               data.amount,
        //                                       name: 'Spending',
        //                                       markerSettings:
        //                                           const MarkerSettings(
        //                                         isVisible: true,
        //                                       ),
        //                                       // dataLabelSettings: DataLabelSettings(
        //                                       //   isVisible:
        //                                       //       true, // Menampilkan data label
        //                                       //   labelAlignment:
        //                                       //       ChartDataLabelAlignment
        //                                       //           .top, // Penataan label data
        //                                       //   textStyle: TextStyle(
        //                                       //     color: Colors.white, // Warna teks
        //                                       //   ),
        //                                       // ),
        //                                     ),
        //                                   ],
        //                                 ),
        //                               ),
        //                             ],
        //                           ),
        //                         ),
        //                       ),
        //                     );
        //                   }
        //                 }),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
