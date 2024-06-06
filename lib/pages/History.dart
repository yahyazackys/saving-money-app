import 'package:flutter/material.dart';
import 'package:savingmoney/widgets/income_history_widget.dart';
import 'package:savingmoney/widgets/spending_history_widget.dart';
import '../themes/theme.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Center(
          child: Text(
            'Recent Amount',
            style: blackTextStyle.copyWith(
              fontSize: 23,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        elevation: 0,
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Material(
              color: whiteColor,
              child: TabBar(
                indicatorColor: primaryColor,
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 1.5,
                  ),
                  insets: EdgeInsets.symmetric(
                    horizontal: 96,
                  ),
                ),
                tabs: [
                  Tab(
                    child: Text(
                      'Income',
                      style: blackTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Spending',
                      style: blackTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                  top: 30,
                  bottom: 120,
                ),
                child: TabBarView(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          IncomeHistoryWidget(),
                          IncomeHistoryWidget(),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          SpendingHistoryWidget(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
