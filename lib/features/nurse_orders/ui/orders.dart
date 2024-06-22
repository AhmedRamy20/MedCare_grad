import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_app/core/cache/cache_helper.dart';
import 'package:medical_app/core/helpers/extensions.dart';
import 'package:medical_app/core/helpers/spacing.dart';
import 'package:medical_app/core/networking/endpoints.dart';
import 'package:medical_app/core/routing/routes.dart';
import 'package:medical_app/features/login/logic/cubit/login_cubit.dart';

import '../../../../core/theming/appTheme/cubit/app_theme_cubit.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _isApproved = false;
  bool _isDenied = false;

  String userUniqename = '';

  //! Fetching Nurse name

  @override
  void initState() {
    super.initState();
    getUsernameFromCache();
  }

  Future<void> getUsernameFromCache() async {
    final cachedUsername = await ChacheHelper().getDataString(key: ApiKey.name);
    setState(() {
      userUniqename = cachedUsername ?? '';
    });
  }

  Future<bool> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Logout',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
              'With logging out your data will be cleared from our app Are you sure you want to Logout?'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsProvider.primaryBink,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 13, right: 15, left: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Cancel'),
                ),

                //**** */
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 13, right: 15, left: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Logout'),
                ),
              ],
            ),
          ],
        );
      },
    ).then((value) => value ?? false);
  }

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Orders Received",
          style: isDarkTheme
              ? const TextStyle(color: Colors.white)
              : TextStyles.font24BlackBold,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: Drawer(
        elevation: 0,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DrawerHeader(
                  // decoration: BoxDecoration(
                  //   color: isDarkTheme ? Colors.grey.shade800 : Colors.white,
                  // ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      verticalSpace(15),
                      Container(
                        color: Colors.transparent,
                        child: const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/avatar.png'),
                          radius: 48,
                        ),
                      ),
                      verticalSpace(10),
                    ],
                  ),
                ),
                verticalSpace(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Hi, ",
                      style: isDarkTheme
                          ? const TextStyle(
                              color: Colors.white,
                            )
                          : TextStyles.font14GrayRegular,
                    ),
                    Text(
                      userUniqename,
                      style: isDarkTheme
                          ? const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            )
                          : const TextStyle(
                              color: ColorsProvider.discriptionTestGrey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                    ),
                  ],
                ),
                ListTile(
                  leading: const Icon(
                    Icons.receipt,
                    color: ColorsProvider.primaryBink,
                    size: 24,
                  ),
                  title: Text(
                    "Orders",
                    style: isDarkTheme
                        ? const TextStyle(color: Colors.white)
                        : TextStyles.font14GrayRegular,
                  ),
                  onTap: () {
                    context.pop();
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.contact_support,
                    color: ColorsProvider.primaryBink,
                    size: 24,
                  ),
                  title: Text(
                    "About Us",
                    style: isDarkTheme
                        ? const TextStyle(color: Colors.white)
                        : TextStyles.font14GrayRegular,
                  ),
                  onTap: () {
                    aboutUsDialog(context, isDarkTheme);
                  },
                ),
                ListTile(
                  leading: isDarkTheme
                      ? const Icon(
                          Icons.dark_mode,
                          color: ColorsProvider.primaryBink,
                          size: 24,
                        )
                      : const Icon(
                          Icons.light_mode,
                          color: ColorsProvider.primaryBink,
                          size: 24,
                        ),
                  title: Text(
                    "Theme",
                    style: isDarkTheme
                        ? const TextStyle(color: Colors.white)
                        : TextStyles.font14GrayRegular,
                  ),
                  trailing: Switch(
                    value: isDarkTheme,
                    onChanged: (value) {
                      context.read<AppThemeCubit>().toggleTheme();
                    },
                    activeColor: ColorsProvider.primaryBink,
                    inactiveThumbColor: Colors.grey.shade500,
                    inactiveTrackColor: Colors.white,
                    // inactiveThumbImage: AssetImage('assets/images/google.png'),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ListTile(
                leading: const Icon(
                  Icons.logout_outlined,
                  color: ColorsProvider.primaryBink,
                  size: 24,
                ),
                title: Text(
                  "Logout",
                  style: isDarkTheme
                      ? const TextStyle(color: Color.fromARGB(255, 255, 17, 0))
                      : const TextStyle(color: Color.fromARGB(255, 255, 17, 0)),
                ),
                onTap: () async {
                  //! call method conf..
                  bool shouldLogout =
                      await _showLogoutConfirmationDialog(context);
                  if (shouldLogout) {
                    await loginCubit.clearUserData();
                    context.read<AppThemeCubit>().resetTheme();
                    context.pushNamedAndRemoveUntil(
                      Routes.loginScreen,
                      predicate: (route) => false,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.only(right: 12.0, left: 12.0, top: 12.0),
              child: GestureDetector(
                onTap: () {
                  context.pushNamed(Routes.patientDetails);
                },
                child: ListTile(
                  leading: SizedBox(
                    width: 80.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        "https://apollohealthlib.blob.core.windows.net/health-library/2021/07/shutterstock_1704731518-2048x1365.jpg",
                        fit: BoxFit.cover,
                        width: 80.0,
                        height: 90.0,
                      ),
                    ),
                  ),
                  title: const Text(
                    "Blood Test",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: const Row(
                    children: [
                      Text(
                        "Ordered by ",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "Ramy",
                        style: TextStyle(
                          color: ColorsProvider.primaryBink,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  trailing: const Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("20/6/2024"),
                      Text("10:30"),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void approve() {
    setState(() {
      _isApproved = true;
      _isDenied = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Patient Order Approved'),
        backgroundColor: Colors.green,
      ),
    );

    print('Approved');
  }

  void deny() {
    setState(() {
      _isApproved = false;
      _isDenied = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Patient Order Denied.'),
        backgroundColor: Colors.red,
      ),
    );

    print('Denied');
  }

  void aboutUsDialog(BuildContext context, bool isDarkTheme) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.contact_support,
          color: ColorsProvider.primaryBink,
          size: 32,
        ),
        content: SizedBox(
          height: 90,
          child: Column(
            children: [
              const Text(
                  "We are the team of MedCare App and we will be more than happy to help.."),
              verticalSpace(10),
              SelectableText(
                'MedCare Phone: +01019686065',
                style: isDarkTheme
                    ? TextStyle(color: Colors.white, fontSize: 14.sp)
                    : TextStyles.font14DarkMediam,
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              // foregroundColor: ColorsProvider.primaryBink,
              backgroundColor: isDarkTheme
                  ? ColorsProvider.primaryBink
                  : ColorsProvider.primaryBink,
              elevation: 2,
            ),
            onPressed: () {
              context.pop();
            },
            child: Text(
              'Noted',
              style: TextStyles.font13WhiteSemiBold,
            ),
          ),
        ],
      ),
    );
  }
}
