// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:medical_app/core/helpers/spacing.dart';
// import 'package:medical_app/core/theming/colors.dart';
// import 'package:medical_app/core/theming/styles.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:medical_app/features/profile/logic/cubit/profile_cubit.dart';
// import 'package:medical_app/features/profile/logic/cubit/profile_state.dart';

// class Profile extends StatefulWidget {
//   const Profile({Key? key});

//   @override
//   State<Profile> createState() => _ProfileState();
// }

// class _ProfileState extends State<Profile> {
//   final TextEditingController userNameController = TextEditingController();
//   final TextEditingController userEmailController = TextEditingController();
//   final TextEditingController userWeightController = TextEditingController();
//   final TextEditingController userHeightController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     context.read<ProfileCubit>().fetchUserData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.only(left: 24.w, top: 15.w, right: 23.w),
//           child: SingleChildScrollView(
//             child: BlocBuilder<ProfileCubit, ProfileState>(
//               builder: (context, state) {
//                 if (state is ProfileLoading) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (state is ProfileSuccess) {
//                   // Update controllers with user data
//                   userNameController.text = state.userData.displayName;
//                   userEmailController.text = state.userData.email;
//                   userWeightController.text = state.userData.weight.toString();
//                   userHeightController.text = state.userData.height.toString();

//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Your Profile",
//                             style: TextStyles.font24BinkBold,
//                           ),
//                           verticalSpace(8),
//                           Text(
//                             "Please take a few minutes to fill out your profile with as much detail as possible.",
//                             style: TextStyles.font14MoreGrayRegular,
//                           ),
//                         ],
//                       ),
//                       verticalSpace(20),
//                       SizedBox(
//                         width: 120,
//                         height: 120,
//                         child: CircleAvatar(
//                           backgroundColor: Colors.grey.shade200,
//                           backgroundImage:
//                               const AssetImage("assets/images/avatar.png"),
//                         ),
//                       ),
//                       verticalSpace(31),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             width: 250,
//                             child: TextField(
//                               controller: userNameController,
//                               decoration: InputDecoration(
//                                 hintText: "Name",
//                                 label: Text("Name"),
//                               ),
//                             ),
//                           ),
//                           TextButton(
//                             onPressed: () {},
//                             child: const Text(
//                               "Save",
//                               style: TextStyle(
//                                 color: ColorsProvider.primaryBink,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       verticalSpace(20),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             width: 250,
//                             child: TextField(
//                               controller: userWeightController,
//                               decoration: InputDecoration(
//                                 hintText: "Weight",
//                                 label: Text("Weight"),
//                               ),
//                             ),
//                           ),
//                           TextButton(
//                             onPressed: () {},
//                             child: const Text(
//                               "Save",
//                               style: TextStyle(
//                                 color: ColorsProvider.primaryBink,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       verticalSpace(27),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             width: 250,
//                             child: TextField(
//                               controller: userHeightController,
//                               decoration: InputDecoration(
//                                 hintText: "Height",
//                                 label: Text("Height"),
//                               ),
//                             ),
//                           ),
//                           TextButton(
//                             onPressed: () {},
//                             child: const Text(
//                               "Save",
//                               style: TextStyle(
//                                 color: ColorsProvider.primaryBink,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   );
//                 } else if (state is ProfileError) {
//                   return Center(child: Text('Error: ${state.errMsg}'));
//                 } else {
//                   return Container(); // Empty container for initial state
//                 }
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/core/helpers/spacing.dart';
import 'package:medical_app/core/theming/colors.dart';
import 'package:medical_app/core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_app/features/profile/logic/cubit/profile_cubit.dart';
import 'package:medical_app/features/profile/logic/cubit/profile_state.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController userWeightController = TextEditingController();
  final TextEditingController userHeightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 24.w, top: 15.w, right: 23.w),
          child: SingleChildScrollView(
            child: BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                if (state is ProfileSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Profile updated successfully')),
                  );
                } else if (state is ProfileError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${state.errMsg}')),
                  );
                }
              },
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ProfileSuccess) {
                  // Update controllers with user data
                  userNameController.text = state.userData.displayName;
                  userEmailController.text = state.userData.email;
                  userWeightController.text = state.userData.weight.toString();
                  userHeightController.text = state.userData.height.toString();

                  return Column(
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
                        ],
                      ),
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
                      verticalSpace(31),
                      buildUpdateRow(
                        controller: userNameController,
                        hintText: "Name",
                        label: "Name",
                        onSave: () {
                          context.read<ProfileCubit>().updateUserData(
                                displayName: userNameController.text,
                              );
                        },
                      ),
                      verticalSpace(20),
                      buildUpdateRow(
                        controller: userWeightController,
                        hintText: "Weight",
                        label: "Weight",
                        onSave: () {
                          context.read<ProfileCubit>().updateUserData(
                                weight: int.tryParse(userWeightController.text),
                              );
                        },
                      ),
                      verticalSpace(27),
                      buildUpdateRow(
                        controller: userHeightController,
                        hintText: "Height",
                        label: "Height",
                        onSave: () {
                          context.read<ProfileCubit>().updateUserData(
                                height: int.tryParse(userHeightController.text),
                              );
                        },
                      ),
                    ],
                  );
                } else if (state is ProfileError) {
                  return Center(child: Text('Error: ${state.errMsg}'));
                } else {
                  return Container(); // Empty container for initial state
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUpdateRow({
    required TextEditingController controller,
    required String hintText,
    required String label,
    required VoidCallback onSave,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 250,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              labelText: label,
            ),
          ),
        ),
        TextButton(
          onPressed: onSave,
          child: const Text(
            "Save",
            style: TextStyle(
              color: ColorsProvider.primaryBink,
            ),
          ),
        ),
      ],
    );
  }
}
