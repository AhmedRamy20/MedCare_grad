import 'package:flutter/material.dart';
import 'package:medical_app/core/helpers/spacing.dart';
import 'package:medical_app/core/theming/styles.dart';
import 'package:medical_app/core/widgets/general_text_form_feild.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_app/core/widgets/med_app_generic_button.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // late double screenWidth;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _birthdayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 24.w, top: 15.w, right: 23.w),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your Profile",
                          style: TextStyles.font24BinkBold,
                        ),
                        verticalSpace(8),
                        Text(
                          "Please take a few minutes to fill out your profile with as much detail as possible.",
                          style: TextStyles.font14MoreGrayRegular,
                        ),
                      ]),
                  verticalSpace(20),
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage:
                          const AssetImage("assets/images/avatar.png"),
                    ),
                  ),
                  verticalSpace(11),
                  //! Use Flexible or Expanded for flexible sizing
                  // Flexible(
                  //   child: MyTextFormFeild(
                  //     hitText: 'height',
                  //     keyboardType: TextInputType.number,
                  //     validator: (value) {
                  //       if (value == null || value.isEmpty) {
                  //         return "Enter Your height";
                  //       }
                  //       return null; // Return null if validation passes
                  //     },
                  //   ),
                  // ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyTextFormFeild(
                        hitText: 'weight',
                        keyboardType: TextInputType.number,
                        width: 143.w,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Your weight";
                          }
                          return null;
                        },
                      ),
                      MyTextFormFeild(
                        hitText: 'height',
                        keyboardType: TextInputType.number,
                        width: 143.w,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Your height";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),

                  verticalSpace(20),
                  MyTextFormFeild(
                    hitText: 'Name',
                    keyboardType: TextInputType.text,
                    // width: 143.w,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Your Name";
                      }
                      return null;
                    },
                  ),
                  verticalSpace(20),
                  MyTextFormFeild(
                    hitText: 'Birthday',
                    keyboardType: TextInputType.number,
                    showDatePicker: true,
                    controller: _birthdayController,
                    // width: 143.w,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Your Birthday";
                      }
                      return null;
                    },
                  ),
                  verticalSpace(20),
                  MyTextFormFeild(
                    hitText: 'gender',
                    keyboardType: TextInputType.text,
                    // width: 143.w,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Your gender";
                      }
                      return null;
                    },
                  ),

                  verticalSpace(27),
                  //! Save button

                  MedAppButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print("Its all good mate..");
                      } else {
                        print("NOOOOOOOO");
                      }
                    },
                    buttonText: "Save",
                    textStyle: TextStyles.font16WhiteSemiBold,
                    buttonWidth: 240,
                    buttonHeight: 52,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
