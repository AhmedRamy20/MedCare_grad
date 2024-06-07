import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/core/helpers/extensions.dart';
import 'package:medical_app/core/helpers/spacing.dart';
import 'package:medical_app/core/routing/routes.dart';
import 'package:medical_app/core/theming/colors.dart';
import 'package:medical_app/core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_app/features/profile/logic/cubit/profile_cubit.dart';
import 'package:medical_app/features/profile/logic/cubit/profile_state.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  final VoidCallback onProfileUpdated;
  const Profile({Key? key, required this.onProfileUpdated});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController userNameController = TextEditingController();
  //final TextEditingController userEmailController = TextEditingController();
  final TextEditingController userWeightController = TextEditingController();
  final TextEditingController userHeightController = TextEditingController();
  XFile? _pickedImage;

  String? _profileImageUrl;

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
                    _profileImageUrl = state.userData.pictureUrl;
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
                  userNameController.text = state.userData.displayName;
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
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          GestureDetector(
                            onTap: _pickImage,
                            child: CircleAvatar(
                              backgroundColor: Colors.grey.shade200,
                              backgroundImage: _pickedImage != null
                                  ? FileImage(File(_pickedImage!.path))
                                  : _profileImageUrl != null
                                       ?NetworkImage(_profileImageUrl!)
                                      : AssetImage("assets/images/avatar.png")
                                          as ImageProvider<Object>,
                              radius: 60,
                              onBackgroundImageError: (error, stackTrace) {
                                setState(() {
                                  _profileImageUrl = null;
                                });
                              },
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: IconButton(
                              icon: Icon(
                                Icons.camera_alt_sharp,
                                color: Colors.white,
                                size: 25,
                              ),
                              onPressed: _pickImage,
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(31),
                      buildUpdateRow(
                        controller: userNameController,
                        hintText: "Name",
                        label: "Name",
                      ),
                      verticalSpace(20),
                      buildUpdateRow(
                        controller: userWeightController,
                        hintText: "Weight",
                        label: "Weight",
                      ),
                      verticalSpace(27),
                      buildUpdateRow(
                        controller: userHeightController,
                        hintText: "Height",
                        label: "Height",
                      ),
                      verticalSpace(27),
                      ElevatedButton(
                        onPressed: _updateProfile,
                        child: Text("Save"),
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
      ],
    );
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = pickedFile;
      });
    }
  }
  void _updateProfile() {
    context
        .read<ProfileCubit>()
        .updateUserData(
          displayName: userNameController.text,
          weight:int.parse(userWeightController.text) ,
          height:int.parse(userHeightController.text),
          imageFile: _pickedImage,
        )
        .then((_) {
      widget.onProfileUpdated();
      })
    .catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    });
  }
}
