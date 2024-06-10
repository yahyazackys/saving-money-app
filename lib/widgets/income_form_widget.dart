import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savingmoney/controllers/transaction_controller.dart';

import '../themes/theme.dart';

class IncomeFormWidget extends StatefulWidget {
  final FocusNode amount;
  final FocusNode information;

  const IncomeFormWidget({
    super.key,
    required this.amount,
    required this.information,
  });

  @override
  State<IncomeFormWidget> createState() => _IncomeFormWidgetState();
}

class _IncomeFormWidgetState extends State<IncomeFormWidget> {
  // FocusNode focusNode = FocusNode();
  // final FocusNode focusNode2 = FocusNode();

  // @override
  // void dispose() {
  //   amount.dispose();
  //   focusNode2.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final tC = Get.put(TransactionController());

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
              focusNode: widget.amount,
              controller: tC.amount,
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
              focusNode: widget.information,
              controller: tC.description,
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
          Obx(
            () => InkWell(
              onTap: (() {
                tC.addIncome();
              }),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    width: 1,
                    color: subColor,
                  ),
                ),
                child: tC.isLoading == true
                    ? CircularProgressIndicator(
                        color: whiteColor,
                      )
                    : Text(
                        "Submit",
                        style: whiteTextStyle.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.center,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
