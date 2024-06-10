import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/user_controller.dart';
import '../themes/theme.dart';

class Changepassword extends StatefulWidget {
  const Changepassword({super.key});

  @override
  State<Changepassword> createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
  @override
  Widget build(BuildContext context) {
    final userC = Get.put(UserController());

    return Scaffold(
      backgroundColor: lightColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          "Change Password",
          style: blackTextStyle.copyWith(
            fontSize: 23,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 24,
            color: blackColor,
          ),
        ),
        elevation: 0,
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(
              30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SvgPicture.asset(
                    'assets/change-password.svg',
                    width: 200,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    "Enter your current password and make sure to fill in the new password correctly.",
                    style: subTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Current Password",
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
                    controller: userC.currentPasswordUser,
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                    ),
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                      hintText: 'Current Password...',
                      iconColor: const Color(0xff8D92A3),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 30,
                      ),
                      suffixIcon: Container(
                        margin: const EdgeInsets.only(
                          right: 12,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        child: Icon(
                          Icons.lock,
                          color: blackColor,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "New Password",
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
                    controller: userC.newPasswordUser,
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                    ),
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                      hintText: 'New Password...',
                      iconColor: const Color(0xff8D92A3),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 30,
                      ),
                      suffixIcon: Container(
                        margin: const EdgeInsets.only(
                          right: 12,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        child: Icon(
                          Icons.lock,
                          color: blackColor,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Confirm New Password",
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
                    controller: userC.confirmPasswordUser,
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                    ),
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                      hintText: 'Confirm New Password...',
                      iconColor: const Color(0xff8D92A3),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 30,
                      ),
                      suffixIcon: Container(
                        margin: const EdgeInsets.only(
                          right: 12,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        child: Icon(
                          Icons.lock,
                          color: blackColor,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Obx(
                  () => InkWell(
                    onTap: (() {
                      userC.editPassword();
                    }),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
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
                      child: userC.isLoading == true
                          ? CircularProgressIndicator(
                              color: whiteColor,
                            )
                          : Text(
                              "Save",
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
          ),
        ),
      ),
    );
  }
}
