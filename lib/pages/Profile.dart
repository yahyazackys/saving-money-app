import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savingmoney/controllers/auth_controller.dart';
import 'package:savingmoney/pages/ChangePassword.dart';
import 'package:sp_util/sp_util.dart';

import '../controllers/user_controller.dart';
import '../themes/theme.dart';
import 'EditProfile.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? person = null;

  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());
    final userC = Get.put(UserController());

    return Scaffold(
      backgroundColor: lightColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Center(
          child: Text(
            'Profile',
            style: blackTextStyle.copyWith(
              fontSize: 23,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        elevation: 0,
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 30,
        ),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: person == null
                        ? Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: subColor,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Icon(
                              Icons.person_2_rounded,
                              size: 80,
                              color: whiteColor,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: subColor,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Image.asset(
                              person!,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        SpUtil.getString("name_userUpdated").toString() == ""
                            ? SpUtil.getString("name_user").toString()
                            : SpUtil.getString("name_userUpdated").toString(),
                        style: blackTextStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        SpUtil.getString("email_userUpdated").toString() == ""
                            ? SpUtil.getString("email_user").toString()
                            : SpUtil.getString("email_userUpdated").toString(),
                        style: subTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 30,
                ),
                color: subColor,
                width: MediaQuery.of(context).size.width,
                height: 01,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfile(),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 30,
                  ),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 2,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit_document,
                        size: 30,
                        color: blackColor,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Edit Profile",
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Changepassword(),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 30,
                  ),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 2,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.password_outlined,
                        size: 30,
                        color: blackColor,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Change Password",
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: (() {
                  userC.deleteUser(context);
                }),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 30,
                  ),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 2,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete_forever,
                        size: 30,
                        color: blackColor,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Delete Account",
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                "App Version 1.0 2024",
                style: subTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 50,
              ),
              Obx(
                () => InkWell(
                  onTap: (() {
                    authC.logout();
                  }),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: redColor,
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
                            "Logout",
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
    );
  }
}
