import 'package:flutter/material.dart';

import '../themes/theme.dart';

class IncomeFormWidget extends StatefulWidget {
  const IncomeFormWidget({super.key});

  @override
  State<IncomeFormWidget> createState() => _IncomeFormWidgetState();
}

class _IncomeFormWidgetState extends State<IncomeFormWidget> {
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
              // controller: taskC.title,
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
            height: 20,
          ),
          Text(
            "Description",
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
              // controller: taskC.description,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              style: blackTextStyle.copyWith(
                fontSize: 13,
              ),
              decoration: InputDecoration(
                hintStyle: subTextStyle.copyWith(
                  fontSize: 13,
                ),
                hintText: 'Description',
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
            onTap: null,
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
