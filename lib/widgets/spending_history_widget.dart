import 'package:flutter/material.dart';

import '../themes/theme.dart';

class SpendingHistoryWidget extends StatefulWidget {
  const SpendingHistoryWidget({super.key});

  @override
  State<SpendingHistoryWidget> createState() => _SpendingHistoryWidgetState();
}

class _SpendingHistoryWidgetState extends State<SpendingHistoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 20,
      ),
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.shade500,
        //     blurRadius: 20,
        //     offset: const Offset(0, 0),
        //   ),
        // ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Spending",
                style: redTextStyle.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              Text(
                "- RM 250",
                style: redTextStyle.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
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
                "Information",
                style: blackTextStyle.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              Text(
                "for buy a doll",
                style: blackTextStyle.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "",
              ),
              Text(
                "09:00 AM",
                style: blackTextStyle.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: greenColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Success",
                  style: whiteTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                "12 January 2024",
                style: blackTextStyle.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
