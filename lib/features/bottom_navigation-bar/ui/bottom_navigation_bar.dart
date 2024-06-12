import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/core/helpers/extensions.dart';
import 'package:medical_app/core/routing/routes.dart';
import 'package:medical_app/core/theming/colors.dart';
import 'package:medical_app/features/cart/logic/cubit/cart_cubit.dart';
import 'package:medical_app/features/home/ui/home_screen.dart';
import 'package:medical_app/features/lab-test/ui/lab_test_screen.dart';
import 'package:medical_app/features/login/logic/cubit/login_cubit.dart';
import 'package:medical_app/features/nearby-pharmacies/ui/nearby_pharmacy_location.dart';
import 'package:medical_app/features/profile/logic/cubit/profile_cubit.dart';
import 'package:medical_app/features/profile/ui/profile_screen.dart';
import 'package:medical_app/features/lab-test/logic/cubit/lab_test_cubit.dart';

class HomeStartWithBottomNav extends StatefulWidget {
  const HomeStartWithBottomNav({super.key});

  @override
  State<HomeStartWithBottomNav> createState() => _HomeStartWithBottomNavState();
}

class _HomeStartWithBottomNavState extends State<HomeStartWithBottomNav> {
  int currentIndex = 0;

  late List<Widget> pages;
  late HomeScreen homeScreen;
  late Profile profile;
  late LabTest labTest;
  late NearbyPharmacies nearbyPharmacies;

  late Widget currentPage;

  @override
  void initState() {
    homeScreen = const HomeScreen();
    nearbyPharmacies = NearbyPharmacies();
    labTest = const LabTest();
    profile = Profile(
      onProfileUpdated: () {
        // Show dialog when profile is updated successfully
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Profile updated successfully!'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Pop the dialog
                    // Navigator.popUntil(
                    //     context, ModalRoute.withName(Routes.profile));
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );

    pages = [
      homeScreen,
      labTest,
      nearbyPharmacies,
      profile,
    ];
    currentPage = pages[currentIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    final colorChoice = isDarkTheme ? Colors.grey.shade800 : Colors.white;
    final iconColorChoice = isDarkTheme ? Colors.grey.shade500 : Colors.white;
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: ColorsProvider.primaryBink,
        backgroundColor: isDarkTheme ? Colors.grey.shade700 : Colors.white,
        height: 66,
        color: colorChoice,
        animationDuration: const Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          Icon(
            Icons.home,
            size: 28,
            color: currentIndex == 0
                ? iconColorChoice
                : ColorsProvider.naveIconColor,
          ),
          Icon(
            Icons.science_sharp,
            size: 28,
            color: currentIndex == 1
                ? iconColorChoice
                : ColorsProvider.naveIconColor,
          ),
          Icon(
            Icons.location_on,
            size: 28,
            color: currentIndex == 2
                ? iconColorChoice
                : ColorsProvider.naveIconColor,
          ),
          Icon(
            Icons.person,
            size: 28,
            color: currentIndex == 3
                ? iconColorChoice
                : ColorsProvider.naveIconColor,
          ),
        ],
      ),
      // body: pages[currentIndex],
      body: IndexedStack(
        index: currentIndex,
        children: [
          homeScreen,
          // BlocProvider<LabTestCubit>(
          //   create: (context) => LabTestCubit(Dio()), // Provide LabTestCubit
          //   child: labTest,
          // ),

          MultiBlocProvider(
            providers: [
              BlocProvider<LabTestCubit>(
                create: (context) =>
                    LabTestCubit(Dio()), // Provide LabTestCubit
              ),
            ],
            child: labTest,
          ),
          nearbyPharmacies,
          BlocProvider<ProfileCubit>(
            create: (context) => ProfileCubit(),
            child: profile,
          ),
        ],
      ),
    );
  }
}
