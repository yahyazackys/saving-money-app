import 'package:flutter/material.dart';

import '../themes/theme.dart';

class SpendingFormWidget extends StatefulWidget {
  const SpendingFormWidget({super.key});

  @override
  State<SpendingFormWidget> createState() => _SpendingFormWidgetState();
}

class _SpendingFormWidgetState extends State<SpendingFormWidget> {
  String? selectedValue;
  final List<String> categories = ['Option 1', 'Option 2', 'Option 3'];

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
                iconColor: Color(0xff8D92A3),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(15),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Category",
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text(
                    'Category...',
                    style: subTextStyle.copyWith(
                      fontSize: 13,
                    ),
                  ),
                  value: selectedValue,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down,
                      color: Color(0xff8D92A3)),
                  style: blackTextStyle.copyWith(
                    fontSize: 13,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue;
                    });
                  },
                  items: categories.map(
                    (String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: Text(
                            option,
                            style: subTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
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
                iconColor: Color(0xff8D92A3),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(15),
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
