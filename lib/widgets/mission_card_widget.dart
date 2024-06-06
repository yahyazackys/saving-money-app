import 'package:flutter/material.dart';

import '../themes/theme.dart';

class MissionCardWidget extends StatefulWidget {
  const MissionCardWidget({super.key});

  @override
  State<MissionCardWidget> createState() => _MissionCardWidgetState();
}

class _MissionCardWidgetState extends State<MissionCardWidget> {
  @override
  Widget build(BuildContext context) {
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
        color: primaryColor,
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
              color: whiteColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "12 January 2025",
              style: primaryTextStyle.copyWith(
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
                style: whiteTextStyle.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
              Text(
                "RM 200.000",
                style: whiteTextStyle.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
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
                style: whiteTextStyle.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                ),
              ),
              Text(
                "Buy A BMW",
                style: whiteTextStyle.copyWith(
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
                style: whiteTextStyle.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                ),
              ),
              Text(
                "Vehicle",
                style: whiteTextStyle.copyWith(
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
                style: whiteTextStyle.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
              Text(
                "RM 20.000",
                style: whiteTextStyle.copyWith(
                  fontWeight: FontWeight.w700,
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
