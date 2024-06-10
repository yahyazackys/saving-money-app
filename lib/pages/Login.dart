import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:savingmoney/pages/Register.dart';

import '../controllers/auth_controller.dart';
import '../themes/theme.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    _focusNode2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());

    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
        _focusNode2.unfocus();
      },
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Container(
          padding: const EdgeInsets.only(
            top: 140,
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Text(
                    "Saving for the Future Safely, Independently, Stably, Growing!",
                    style: whiteTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                SvgPicture.asset(
                  'assets/login.svg',
                  width: 300,
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
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "Welcome Back!",
                        style: blackTextStyle.copyWith(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
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
                          controller: authC.emailLogin,
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
                      SizedBox(
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
                          controller: authC.passwordLogin,
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
                      SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => InkWell(
                          onTap: (() {
                            authC.login();
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
                                    "Sign In",
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: (() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => const Register()),
                            ),
                          );
                        }),
                        child: Text(
                          "Don’t have an account? Sign Up ",
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
