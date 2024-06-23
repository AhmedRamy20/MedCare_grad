import 'package:badges/badges.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_app/core/cache/cache_helper.dart';
import 'package:medical_app/core/helpers/extensions.dart';
import 'package:medical_app/core/helpers/spacing.dart';
import 'package:medical_app/core/networking/endpoints.dart';
import 'package:medical_app/core/routing/routes.dart';
import 'package:medical_app/core/theming/appTheme/cubit/app_theme_cubit.dart';
import 'package:medical_app/core/theming/colors.dart';
import 'package:medical_app/core/theming/styles.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:medical_app/features/cart/logic/cubit/cart_cubit.dart';
import 'package:medical_app/features/cart/logic/cubit/cart_state.dart';
import 'package:medical_app/features/home/logic/cubit/medicine_cubit.dart';
import 'package:medical_app/features/home/logic/cubit/medicine_state.dart';
import 'package:medical_app/features/home/ui/medicine_details_screen.dart';
import 'package:medical_app/features/home/ui/widgets/medicine_shimmer_loading.dart';
import 'package:medical_app/features/login/logic/cubit/login_cubit.dart';
import 'package:medical_app/features/profile/logic/cubit/profile_cubit.dart';
import 'package:medical_app/features/profile/logic/cubit/profile_state.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:badges/badges.dart' as badges;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FocusNode _searchFocusNode = FocusNode();
  bool isSearchExpanded = false;
  final searchController = TextEditingController();

  bool isSearchFocused = false;

  String userUniqename = '';

  @override
  void initState() {
    super.initState();
    context.read<MedicineCubit>().fetchMedicines();
    context.read<ProfileCubit>().fetchUserData();
    getUsernameFromCache();

    _searchFocusNode.addListener(() {
      setState(() {
        isSearchFocused = _searchFocusNode.hasFocus;
      });
    });
  }

  Future<void> getUsernameFromCache() async {
    final cachedUsername = await ChacheHelper().getDataString(key: ApiKey.name);
    setState(() {
      userUniqename = cachedUsername ?? '';
    });
  }

  Future<void> _handleRefresh() async {
    await context.read<MedicineCubit>().fetchMedicines();
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
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: ColorsProvider.primaryBink,
          size: 30,
        ),
        actions: [
          BlocBuilder<CartCubit, CartState>(
            builder: (context, cartState) {
              int cartItemCount = 0;
              if (cartState is CartItemsUpdated) {
                cartItemCount = cartState.medicineCartItems.length +
                    cartState.labTestCartItems.length;
              }
              Widget badgeWidget = cartItemCount > 0
                  ? badges.Badge(
                      badgeContent: Text(
                        '$cartItemCount',
                        style: const TextStyle(color: Colors.white),
                      ),
                      // position: BadgePosition.topEnd(end: 3),
                      position: BadgePosition.topEnd(
                        top: 2,
                        end: 12,
                      ),
                      badgeStyle: const BadgeStyle(
                        badgeColor: Colors.red,
                        padding: EdgeInsets.all(5),
                        elevation: 0,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Transform(
                          transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
                          alignment: Alignment.center,
                          child: IconButton(
                            onPressed: () {
                              // context.pushNamed(Routes.paymentCheckout); //MyCartViewBody
                              context.pushNamed(Routes.cart);
                            },
                            icon: const Icon(
                              Icons.shopping_cart,
                              color: ColorsProvider
                                  .primaryBink, //ColorsProvider.greeting1Color
                              size: 33,
                            ),
                          ),
                        ),
                      ),
                    )
                  : IconButton(
                      onPressed: () {},
                      icon: Transform(
                        transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
                        alignment: Alignment.center,
                        child: IconButton(
                          onPressed: () {
                            // context.pushNamed(Routes.paymentCheckout); //MyCartViewBody
                            context.pushNamed(Routes.cart);
                          },
                          icon: const Icon(
                            Icons.shopping_cart,
                            color: ColorsProvider
                                .primaryBink, //ColorsProvider.greeting1Color
                            size: 33,
                          ),
                        ),
                      ),
                    );
              return badgeWidget;
            },
          ),
        ],
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Stack(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Icon(
                    Icons.menu,
                    color: ColorsProvider.primaryBink,
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Scaffold.of(context).openDrawer(),
                      splashColor: ColorsProvider.primaryBink,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        elevation: 0,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileSuccess) {
                      final userData = state.userData;
                      // Determine the image provider based on userData.pictureUrl
                      // ImageProvider<Object>? imageProvider;
                      // if (userData.pictureUrl != null &&
                      //     userData.pictureUrl!.isNotEmpty) {
                      //   imageProvider =
                      //       CachedNetworkImageProvider(userData.pictureUrl!);
                      // } else if (userData.pictureUrl == null) {
                      //   imageProvider = AssetImage("assets/images/avatar.png");
                      // } else {
                      //   imageProvider = AssetImage("assets/images/avatar.png");
                      // }
                      return UserAccountsDrawerHeader(
                        decoration: const BoxDecoration(
                          color: ColorsProvider.primaryBink,
                        ),
                        accountName: Text(
                          "Welcome,${userData.displayName}",
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        accountEmail: Text(
                          userData.email,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        // currentAccountPicture: CircleAvatar(
                        //   backgroundColor: Colors.grey.shade200,
                        //   backgroundImage: imageProvider,
                        //   errorWidget: (context, url, error) => CircleAvatar(
                        //     backgroundColor: Colors.grey.shade200,
                        //     child: Image.asset("assets/images/avatar.png"),
                        //   ),
                        // ),

                        //!!! This is the user img
                        // currentAccountPicture: CircleAvatar(
                        //   backgroundColor: Colors.grey.shade200,
                        //   child: ClipOval(
                        //     child: CachedNetworkImage(
                        //       useOldImageOnUrlChange: true,
                        //       imageUrl: userData.pictureUrl ?? '',
                        //       placeholder: (context, url) {
                        //         return const CircularProgressIndicator();
                        //       },
                        //       errorWidget: (context, url, error) =>
                        //           Image.asset("assets/images/avatar.png"),
                        //       fit: BoxFit.cover,
                        //       width: double.infinity,
                        //       height: double.infinity,
                        //     ),
                        //   ),
                        // ),
                      );
                    } else {
                      return DrawerHeader(
                        decoration: BoxDecoration(
                          color:
                              isDarkTheme ? Colors.grey.shade800 : Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.settings,
                                  color: isDarkTheme
                                      ? Colors.white70
                                      : ColorsProvider.darkGray,
                                ),
                                horizontalSpace(10),
                                Text(
                                  'Settings',
                                  style: TextStyle(
                                    color: isDarkTheme
                                        ? Colors.white
                                        : ColorsProvider.darkGray,
                                    fontSize: 17,
                                  ),
                                ),
                                // verticalSpace(20),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
                verticalSpace(20),
                ListTile(
                  leading: const Icon(
                    Icons.contact_support,
                    color: ColorsProvider.primaryBink, //Color(0xffE99987)
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
                  leading: const Icon(
                    Icons.phone,
                    color: ColorsProvider.primaryBink, //Color(0xffE99987)
                    size: 24,
                  ),
                  title: Text(
                    "Contact Us",
                    style: isDarkTheme
                        ? const TextStyle(color: Colors.white)
                        : TextStyles.font14GrayRegular,
                  ),
                  onTap: () {
                    _launchPhoneDialer();
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.science,
                    color: ColorsProvider.primaryBink,
                    size: 24,
                  ),
                  title: Text(
                    "Test Result",
                    style: isDarkTheme
                        ? const TextStyle(color: Colors.white)
                        : TextStyles.font14GrayRegular,
                  ),
                  onTap: () {
                    context.pop();
                    context.pushNamed(Routes.labTestResult);
                  },
                ),
                ListTile(
                  leading: isDarkTheme
                      ? const Icon(
                          Icons.dark_mode,
                          // color: Color(0xffE99987),
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
                      ? const TextStyle(
                          color: Color.fromARGB(255, 190, 20, 8),
                          fontWeight: FontWeight.bold,
                        )
                      : const TextStyle(
                          color: Color.fromARGB(255, 190, 20, 8),
                          fontWeight: FontWeight.bold,
                        ),
                ),
                onTap: () async {
                  //** logout confirmation */
                  bool shouldLogout =
                      await _showLogoutConfirmationDialog(context);
                  if (shouldLogout) {
                    await context.read<LoginCubit>().clearUserData();
                    await context.read<CartCubit>().clearCart();
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
      body: RefreshIndicator(
        color: ColorsProvider.primaryBink,
        onRefresh: _handleRefresh,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Hi, $userUniqename",
                    style: isDarkTheme
                        ? TextStyles.font24whiteBold2
                        : TextStyles.font24rusasyBold2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "Hope you doing well..",
                  style: isDarkTheme
                      ? TextStyle(color: Colors.white)
                      : TextStyles.font11GrayRegular,
                ),
                if (!isSearchExpanded)
                  SizedBox(
                    height: 200,
                    child: CarouselSlider(
                      items: [
                        "assets/images/slid11.png",
                        "assets/images/slid22.png",
                        "assets/images/slid3.png"
                      ].map((e) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: isDarkTheme
                                ? Color.fromARGB(255, 33, 36, 52)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset(
                            e,
                            fit: BoxFit.fitWidth,
                          ),
                        );
                      }).toList(),
                      options: CarouselOptions(
                        height: 200,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 2),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                      ),
                    ),
                  ),
                verticalSpace(8),
                Container(
                  height: 56, // Fixed height
                  decoration: BoxDecoration(
                    color: isDarkTheme
                        ? ColorsProvider.feildWhite
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.search,
                          color: isDarkTheme ? Colors.grey : Colors.grey,
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _searchFocusNode.requestFocus();
                          },
                          child: TextField(
                            controller: searchController,
                            focusNode: _searchFocusNode,
                            cursorColor: isDarkTheme
                                ? ColorsProvider.primaryBink
                                : ColorsProvider.primaryBink,
                            decoration: const InputDecoration(
                              hintText: "Search a Drug",
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 19,
                            ),
                            onChanged: (searchedValue) {
                              print("Search value: $searchedValue");
                              context
                                  .read<MedicineCubit>()
                                  .searchMedicines(searchedValue);
                            },
                            onSubmitted: (value) {
                              _searchFocusNode.unfocus();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpace(5),
                BlocBuilder<MedicineCubit, MedicineState>(
                  builder: (context, state) {
                    if (state is MedicineListLoadingState) {
                      return const MedicineShimmerLoading();
                    } else if (state is MedicineListState) {
                      final medicineCount = state.medicines.length > 4
                          ? 4
                          : state.medicines.length;

                      if (state.medicines.isEmpty) {
                        return const Center(
                          child: Text("No medicines found."),
                        );
                      }

                      return Column(
                        children: List.generate(
                          medicineCount,
                          (index) {
                            final medicine = state.medicines[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MedicineDetailsScreen(
                                        medicine: medicine),
                                  ),
                                );
                              },
                              child: ListTile(
                                leading: SizedBox(
                                  height: 100,
                                  width: 100,
                                  //* old
                                  // child: medicine.pictureUrl.isNotEmpty
                                  //     ? Image.network(medicine.pictureUrl)
                                  //     : const Placeholder(),
                                  child: Hero(
                                    // tag: medicine.id,
                                    tag: medicine.id,
                                    child: AspectRatio(
                                      aspectRatio: 2.0,
                                      child: medicine.pictureUrl.isNotEmpty
                                          ? FancyShimmerImage(
                                              imageUrl: medicine.pictureUrl,
                                              boxFit: BoxFit.cover,
                                              errorWidget: Container(
                                                child: const Icon(
                                                  Icons.error,
                                                  color: ColorsProvider
                                                      .primaryBink,
                                                ),
                                              ),
                                            )
                                          : const Icon(
                                              Icons.error,
                                              color: ColorsProvider.primaryBink,
                                            ),
                                    ),
                                  ),
                                  //! fancy
                                  // child: FancyShimmerImage(
                                  //   imageUrl: medicine.pictureUrl,
                                  // ),
                                ),
                                //! name
                                title: Text(
                                  medicine.name,
                                  style: isDarkTheme
                                      ? TextStyle(
                                          color: Colors.white, fontSize: 14.sp)
                                      : TextStyles.font14DarkMediam,
                                ),

                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      medicine.description,
                                      style: isDarkTheme
                                          ? TextStyle(
                                              color: Colors.white70,
                                              fontSize: 14.sp)
                                          : TextStyles.font14LightGrayRegular,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: '\$ ',
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 16,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '${medicine.price.toStringAsFixed(2)}',
                                            style: isDarkTheme
                                                ? const TextStyle(
                                                    color: Colors.white60,
                                                    fontSize: 16)
                                                : const TextStyle(
                                                    color: ColorsProvider
                                                        .greeting2Color,
                                                    fontSize: 16,
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Transform(
                                  transform: Matrix4.identity()
                                    ..scale(-1.0, 1.0, 1.0),
                                  alignment: Alignment.center,
                                  child: IconButton(
                                    onPressed: () {
                                      BlocProvider.of<CartCubit>(context)
                                          .addToMedicineCart(medicine);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              '${medicine.name} added to cart'),
                                          duration: const Duration(seconds: 1),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.shopping_cart,
                                      color: ColorsProvider.primaryBink,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else if (state is MedicineFilteredState) {
                      // Display the filtered list of medicines
                      final medicineCount = state.medicines.length > 4
                          ? 4
                          : state.medicines.length;
                      return Column(
                        children: List.generate(
                          medicineCount,
                          (index) {
                            final medicine = state.medicines[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MedicineDetailsScreen(
                                        medicine: medicine),
                                  ),
                                );
                              },
                              child: ListTile(
                                leading: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: medicine.pictureUrl.isNotEmpty
                                      ? Image.network(medicine.pictureUrl)
                                      : const Placeholder(),
                                ),
                                title: Text(
                                  medicine.name,
                                  style: TextStyles.font14DarkMediam,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      medicine.description,
                                      style: TextStyles.font14LightGrayRegular,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: '\$ ',
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 16,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '${medicine.price.toStringAsFixed(2)}',
                                            style: const TextStyle(
                                              color:
                                                  ColorsProvider.greeting2Color,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: Center(
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: CircularProgressIndicator(
                              color: ColorsProvider.primaryBink,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: !isSearchFocused,
        child: FloatingActionButton(
          heroTag: "The Boys",
          elevation: 0,
          onPressed: () {
            context.pushNamed(Routes.chatbotScreen);
          },
          backgroundColor: ColorsProvider.primaryBink,
          child: const Icon(
            Icons.chat_bubble,
            color:
                Color.fromARGB(255, 196, 204, 215), //ColorsProvider.primaryBink
          ),
        ),
      ),
    );
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

    @override
    void dispose() {
      _searchFocusNode.dispose();
      searchController.dispose();
      try {
        final cubit = context.read<MedicineCubit>();
        final cubitProf = context.read<ProfileCubit>();
        cubit.close();
        cubitProf.close();
      } catch (e) {
        print('Error disposing MedicineCubit: $e');
      }
      super.dispose();
    }
  }

  void _launchPhoneDialer() async {
    final phoneNumber = 'tel:+201019686065';
    if (await canLaunch(phoneNumber)) {
      await launch(phoneNumber);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }
}
