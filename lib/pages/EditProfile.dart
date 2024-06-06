import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../themes/theme.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          "Edit Profile",
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
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          // Tambahkan SingleChildScrollView
          child: Padding(
            padding: const EdgeInsets.all(
              30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SvgPicture.asset(
                    'assets/edit-profile.svg',
                    width: 160,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    "Please complete all the information below!",
                    style: redTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Full Name",
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
                  "Occupation",
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
                    style: blackTextStyle.copyWith(
                      fontSize: 13,
                    ),
                    decoration: InputDecoration(
                      hintStyle: subTextStyle.copyWith(
                        fontSize: 13,
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
                Text(
                  "Email",
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
                    style: blackTextStyle.copyWith(
                      fontSize: 13,
                    ),
                    decoration: InputDecoration(
                      hintStyle: subTextStyle.copyWith(
                        fontSize: 13,
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
                Text(
                  "No. Handphone",
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
                  child: TextFormField(
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                    ),
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(fontSize: 13),
                      hintText: 'No. Handphone...',
                      iconColor: Color(0xff8D92A3),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(15),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
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
                        'Save',
                        style: whiteTextStyle.copyWith(
                            fontWeight: FontWeight.bold),
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
