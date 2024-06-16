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

  // @override
  // void initState() {
  //   super.initState();
  //   context.read<ProfileCubit>().fetchUserData();
  // }

  @override
  void initState() {
    super.initState();
    // Fetch user data when the screen is first initialized
    _fetchUserData();
  }

  // Fetch user data method
  void _fetchUserData() {
    context.read<ProfileCubit>().fetchUserData().catchError((error) {
      // If there's an error fetching user data, show the error dialog
      _showErrorDialog(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 24.w, top: 15.w, right: 23.w),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: BlocConsumer<ProfileCubit, ProfileState>(
                    listener: (context, state) {
                      if (state is ProfileSuccess) {
                        _profileImageUrl = state.userData.pictureUrl;
                      } else if (state is ProfileError) {
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(content: Text('Error: ${state.errMsg}')),
                        // );
                        _showErrorDialog(state.errMsg);
                      }
                    },
                    builder: (context, state) {
                      if (state is ProfileLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is ProfileSuccess) {
                        userNameController.text = state.userData.displayName;
                        userWeightController.text =
                            state.userData.weight.toString();
                        userHeightController.text =
                            state.userData.height.toString();

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Your Profile",
                                  style: isDarkTheme
                                      ? TextStyles.font24whiteBold2
                                      : TextStyles
                                          .font24rusasyBold2, //TextStyles.font24BinkBold
                                ),
                                verticalSpace(8),
                                Text(
                                  "Please take a few minutes to fill out your profile within the provided fields..",
                                  style: isDarkTheme
                                      ? TextStyles.font14LightGrayRegular
                                      : TextStyles
                                          .font14MoreGrayRegular, //TextStyles.font14MoreGrayRegular,
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
                                            ? NetworkImage(_profileImageUrl!)
                                            : AssetImage(
                                                    "assets/images/avatar.png")
                                                as ImageProvider<Object>,
                                    radius: 60,
                                    onBackgroundImageError:
                                        (error, stackTrace) {
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
                              isNumeric: true,
                              hintText: "Weight",
                              label: "Weight",
                            ),
                            verticalSpace(27),
                            buildUpdateRow(
                              controller: userHeightController,
                              isNumeric: true,
                              hintText: "Height",
                              label: "Height",
                            ),
                            verticalSpace(10),
                          ],
                        );
                      } else if (state is ProfileError) {
                        return Center(child: Text('Error: ${state.errMsg}'));
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: _updateProfile,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        ColorsProvider.primaryBink),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 60.0)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: Text("Save"),
                ),
              ),
              verticalSpace(30),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUpdateRow({
    required TextEditingController controller,
    required String hintText,
    required String label,
    bool isNumeric = false,
  }) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextField(
            keyboardType: isNumeric ? TextInputType.number : null,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: isDarkTheme ? Colors.white : Colors.black,
              ),
              labelText: label,
              labelStyle:
                  TextStyle(color: isDarkTheme ? Colors.white : Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: isDarkTheme ? Colors.white : Colors.black),
                borderRadius: BorderRadius.circular(16),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: ColorsProvider.primaryBink),
                borderRadius: BorderRadius.circular(16),
              ),
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
          weight: int.parse(userWeightController.text),
          height: int.parse(userHeightController.text),
          imageFile: _pickedImage,
        )
        .then((_) {
      widget.onProfileUpdated();
    }).catchError((error) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Error: $error')),
      // );
      _showErrorDialog(error.toString());
    });
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
