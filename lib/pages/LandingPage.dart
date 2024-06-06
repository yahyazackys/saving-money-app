import 'package:flutter/material.dart';
import 'package:savingmoney/themes/theme.dart';
import 'package:savingmoney/widgets/income_form_widget.dart';
import 'package:savingmoney/widgets/mission_card_widget.dart';
import 'package:savingmoney/widgets/mission_form_widget.dart';
import 'package:savingmoney/widgets/spending_form_widget.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 30,
                ),
                child: Column(
                  children: [
                    Text(
                      "Hi, Alif Welcome Back!",
                      style: whiteTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Total Amount",
                      style: subTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "RM 10.000",
                      style: whiteTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.only(
                  top: 60,
                  bottom: 130,
                ),
                decoration: BoxDecoration(
                  color: lightColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(80),
                    topRight: Radius.circular(80),
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          "Mission Goals",
                          style: blackTextStyle.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            MissionCardWidget(),
                            MissionCardWidget(),
                            MissionCardWidget(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currentTab = 0;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(80),
                                      border: Border.all(
                                        color: primaryColor,
                                      ),
                                      color: currentTab == 0
                                          ? primaryColor
                                          : Colors.transparent,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 30,
                                      vertical: 8,
                                    ),
                                    child: Text(
                                      'Income',
                                      style: currentTab == 0
                                          ? whiteTextStyle.copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            )
                                          : primaryTextStyle.copyWith(
                                              fontWeight: FontWeight.bold,
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
                                      borderRadius: BorderRadius.circular(80),
                                      border: Border.all(
                                        color: primaryColor,
                                      ),
                                      color: currentTab == 1
                                          ? primaryColor
                                          : Colors.transparent,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 30,
                                      vertical: 8,
                                    ),
                                    child: Text(
                                      'Spending',
                                      style: currentTab == 1
                                          ? whiteTextStyle.copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            )
                                          : primaryTextStyle.copyWith(
                                              fontWeight: FontWeight.bold,
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
                                      borderRadius: BorderRadius.circular(80),
                                      border: Border.all(
                                        color: primaryColor,
                                      ),
                                      color: currentTab == 2
                                          ? primaryColor
                                          : Colors.transparent,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 30,
                                      vertical: 8,
                                    ),
                                    child: Text(
                                      'Mission',
                                      style: currentTab == 2
                                          ? whiteTextStyle.copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            )
                                          : primaryTextStyle.copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                                height:
                                    20), // Tambahkan SizedBox untuk jarak antar widget
                            currentTab == 0
                                ? const IncomeFormWidget()
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
          ],
        ),
      ),
    );
  }
}
