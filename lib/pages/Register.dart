import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savingmoney/pages/Login.dart';

import '../controllers/auth_controller.dart';
import '../themes/theme.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();
  final FocusNode _focusNode6 = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    _focusNode5.dispose();
    _focusNode6.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());

    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
        _focusNode2.unfocus();
        _focusNode3.unfocus();
        _focusNode4.unfocus();
        _focusNode5.unfocus();
        _focusNode6.unfocus();
      },
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Container(
          padding: const EdgeInsets.only(
            top: 60,
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: whiteColor,
                      ),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(
                        left: 20,
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                    color: whiteColor,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        "Register Now!",
                        style: blackTextStyle.copyWith(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Please complete all the information below!",
                        style: redTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            width: 1,
                            color: subColor,
                          ),
                        ),
                        child: TextField(
                          focusNode: _focusNode,
                          controller: authC.name,
                          style: blackTextStyle.copyWith(
                            fontSize: 13,
                          ),
                          decoration: InputDecoration(
                            hintStyle: subTextStyle.copyWith(
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                            ),
                            hintText: 'Fullname...',
                            iconColor: const Color(0xff8D92A3),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(15),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            width: 1,
                            color: subColor,
                          ),
                        ),
                        child: TextField(
                          focusNode: _focusNode2,
                          controller: authC.email,
                          style: blackTextStyle.copyWith(
                            fontSize: 13,
                          ),
                          decoration: InputDecoration(
                            hintStyle: subTextStyle.copyWith(
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                            ),
                            hintText: 'Email...',
                            iconColor: const Color(0xff8D92A3),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(15),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            width: 1,
                            color: subColor,
                          ),
                        ),
                        child: TextField(
                          focusNode: _focusNode3,
                          controller: authC.occupation,
                          style: blackTextStyle.copyWith(
                            fontSize: 13,
                          ),
                          decoration: InputDecoration(
                            hintStyle: subTextStyle.copyWith(
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                            ),
                            hintText: 'Occupation...',
                            iconColor: const Color(0xff8D92A3),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(15),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            width: 1,
                            color: subColor,
                          ),
                        ),
                        child: TextField(
                          focusNode: _focusNode4,
                          controller: authC.noHp,
                          style: blackTextStyle.copyWith(
                            fontSize: 13,
                          ),
                          decoration: InputDecoration(
                            hintStyle: subTextStyle.copyWith(
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                            ),
                            hintText: 'No Handphone...',
                            iconColor: const Color(0xff8D92A3),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(15),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            width: 1,
                            color: subColor,
                          ),
                        ),
                        child: TextField(
                          focusNode: _focusNode5,
                          controller: authC.password,
                          style: blackTextStyle.copyWith(
                            fontSize: 13,
                          ),
                          decoration: InputDecoration(
                            hintStyle: subTextStyle.copyWith(
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                            ),
                            hintText: 'Password...',
                            iconColor: const Color(0xff8D92A3),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(15),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            width: 1,
                            color: subColor,
                          ),
                        ),
                        child: TextField(
                          focusNode: _focusNode6,
                          controller: authC.confirmPassword,
                          style: blackTextStyle.copyWith(
                            fontSize: 13,
                          ),
                          decoration: InputDecoration(
                            hintStyle: subTextStyle.copyWith(
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                            ),
                            hintText: 'Confirm Password...',
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
                            authC.register();
                          }),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
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
                            child: authC.isLoading == true
                                ? CircularProgressIndicator(
                                    color: whiteColor,
                                  )
                                : Text(
                                    "Sign Up",
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: (() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => const Login()),
                            ),
                          );
                        }),
                        child: Text(
                          "Already have an account? Sign In",
                          style: blackTextStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
