import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/core/theming/colors.dart';
import 'package:medical_app/features/home/ui/home_screen.dart';
import 'package:medical_app/features/lab-test/ui/lab_test_screen.dart';
import 'package:medical_app/features/nearby-pharmacies/ui/nearby_pharmacy_location.dart';
import 'package:medical_app/features/profile/ui/profile_screen.dart';

class HomeStartWithBottomNav extends StatefulWidget {
  const HomeStartWithBottomNav({super.key});

  // final String username;
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
    homeScreen = HomeScreen();
    nearbyPharmacies = const NearbyPharmacies();
    labTest = const LabTest();
    profile = const Profile();

    pages = [
      homeScreen,
      labTest,
      nearbyPharmacies,
      profile,
    ];
    // currentPage = HomeScreen(
    //   username: widget.username,
    // );
    currentPage = pages[currentIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: ColorsProvider.primaryBink,
        backgroundColor: Colors.white,
        height: 66,
        color: ColorsProvider.naveColor,
        animationDuration: const Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          // IconButton(icon: Icon(Icons.home), onPressed: () {}),
          Icon(
            Icons.home,
            size: 28,
            color:
                currentIndex == 0 ? Colors.white : ColorsProvider.naveIconColor,
          ),
          Icon(
            Icons.science_sharp,
            size: 28,
            color:
                currentIndex == 1 ? Colors.white : ColorsProvider.naveIconColor,
          ),
          Icon(
            Icons.location_on,
            size: 28,
            color:
                currentIndex == 2 ? Colors.white : ColorsProvider.naveIconColor,
          ),
          Icon(
            Icons.person,
            size: 28,
            color:
                currentIndex == 3 ? Colors.white : ColorsProvider.naveIconColor,
          ),
        ],
      ),
      body: pages[currentIndex],
    );
  }
}
