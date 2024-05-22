// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:medical_app/core/cache/cache_helper.dart';
// import 'package:medical_app/core/helpers/extensions.dart';
// import 'package:medical_app/core/helpers/spacing.dart';
// import 'package:medical_app/core/networking/endpoints.dart';
// import 'package:medical_app/core/routing/routes.dart';
// import 'package:medical_app/core/theming/colors.dart';
// import 'package:medical_app/core/theming/styles.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:medical_app/features/home/logic/cubit/medicine_cubit.dart';
// import 'package:medical_app/features/home/logic/cubit/medicine_state.dart';
// import 'package:medical_app/features/login/logic/cubit/login_cubit.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final FocusNode _searchFocusNode = FocusNode();
//   bool isSearchExpanded = false;
//   final searchController = TextEditingController();

//   //** username in the Home Page ex- Hi, Ramy  ***//

//   String userUniqename = '';

//   @override
//   void initState() {
//     super.initState();
//     context.read<MedicineCubit>().fetchMedicines();
//     getUsernameFromCache();
//   }

//   Future<void> getUsernameFromCache() async {
//     final cachedUsername = await ChacheHelper().getDataString(key: ApiKey.name);
//     setState(() {
//       userUniqename = cachedUsername ?? '';
//     });
//   }

//   //***         ***//

//   @override
//   void dispose() {
//     _searchFocusNode.dispose();
//     searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final loginCubit = context.read<LoginCubit>();
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(
//           color: ColorsProvider.primaryBink,
//           size: 30,
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: Transform(
//               transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
//               alignment: Alignment.center,
//               child: const Icon(
//                 Icons.shopping_cart,
//                 color: ColorsProvider.greeting1Color,
//                 size: 33,
//               ),
//             ),
//           ),
//         ],
//         //! Starting point
//         leading: Builder(
//           builder: (context) => IconButton(
//             onPressed: () {
//               Scaffold.of(context).openDrawer();
//             },
//             icon: Stack(
//               children: [
//                 const Padding(
//                   padding: EdgeInsets.only(left: 15.0),
//                   child: Icon(
//                     Icons.menu,
//                     color: ColorsProvider.primaryBink,
//                   ),
//                 ),
//                 Positioned.fill(
//                   child: Material(
//                     color: Colors.transparent,
//                     child: InkWell(
//                       onTap: () => Scaffold.of(context).openDrawer(),
//                       splashColor: ColorsProvider.primaryBink,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       drawer: Drawer(
//         elevation: 0,
//         width: 300,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               // padding: EdgeInsets.zero,
//               children: [
//                 DrawerHeader(
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Image.asset(
//                         'assets/images/sec.png',
//                         scale: 0.7,
//                       ),
//                       verticalSpace(30),
//                       const Center(
//                         child: Text(
//                           'Settings',
//                           style: TextStyle(
//                             color: ColorsProvider.darkGray,
//                             fontSize: 17,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 verticalSpace(20),

//                 ListTile(
//                   leading: const Icon(
//                     Icons.contact_support,
//                     color: Color(0xffE99987),
//                     size: 24,
//                   ),
//                   title: Text(
//                     "About Us",
//                     style: TextStyles.font14GrayRegular,
//                   ),
//                   onTap: () {
//                     aboutUsDialog();
//                   },
//                 ),
//                 ListTile(
//                   leading: const Icon(
//                     Icons.science,
//                     color: Color(0xffE99987),
//                     size: 24,
//                   ),
//                   title: Text(
//                     "Test Result",
//                     style: TextStyles.font14GrayRegular,
//                   ),
//                   onTap: () {},
//                 ),
//                 ListTile(
//                   leading: const Icon(
//                     Icons.language,
//                     color: Color(0xffE99987),
//                     size: 24,
//                   ),
//                   title: Text(
//                     "Language",
//                     style: TextStyles.font14GrayRegular,
//                   ),
//                   onTap: () {},
//                 ),
//                 // verticalSpace(150),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 20),
//               child: ListTile(
//                 leading: const Icon(
//                   Icons.logout_outlined,
//                   color: Color(0xffE99987),
//                   size: 24,
//                 ),
//                 title: const Text(
//                   "Logout",
//                   style: TextStyle(color: Color.fromARGB(255, 153, 62, 55)),
//                 ),
//                 onTap: () async {
//                   await loginCubit.clearUserData();
//                   context.pushNamedAndRemoveUntil(
//                     Routes.loginScreen,
//                     predicate: (route) => false,
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               FittedBox(
//                 fit: BoxFit.scaleDown,
//                 child: Text(
//                   "Hi, $userUniqename",
//                   style: TextStyles.font24BinkBold2,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               Text(
//                 "Hope you doing well..",
//                 style: TextStyles.font11GrayRegular,
//               ),
//               // verticalSpace(20),

//               if (!isSearchExpanded)
//                 SizedBox(
//                   height: 200,
//                   child: CarouselSlider(
//                     items: [
//                       "assets/images/slid11.png",
//                       "assets/images/slid22.png",
//                       "assets/images/slid3.png"
//                     ].map((e) {
//                       return Container(
//                         width: MediaQuery.of(context).size.width,
//                         margin: const EdgeInsets.symmetric(horizontal: 5),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Image.asset(
//                           e,
//                           fit: BoxFit.fitWidth,
//                         ),
//                       );
//                     }).toList(),
//                     options: CarouselOptions(
//                       height: 200,
//                       autoPlay: true,
//                       autoPlayInterval: const Duration(seconds: 2),
//                       autoPlayAnimationDuration:
//                           const Duration(milliseconds: 800),
//                       autoPlayCurve: Curves.fastOutSlowIn,
//                     ),
//                   ),
//                 ),
//               verticalSpace(8),
//               AnimatedSize(
//                 duration: const Duration(milliseconds: 300),
//                 curve: Curves.easeInOut,
//                 child: Container(
//                   height: isSearchExpanded ? null : 56,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Row(
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Icon(Icons.search),
//                       ),
//                       Expanded(
//                         child: GestureDetector(
//                           onTap: () {
//                             // _searchFocusNode.requestFocus();
//                             setState(() {
//                               isSearchExpanded = true;
//                             });
//                             FocusScope.of(context)
//                                 .requestFocus(_searchFocusNode);
//                           },
//                           child: TextField(
//                             controller: searchController,
//                             focusNode: _searchFocusNode,
//                             onTap: () {
//                               setState(() {
//                                 isSearchExpanded = true;
//                               });
//                             },
//                             cursorColor: Colors.blue,
//                             decoration: const InputDecoration(
//                               hintText: "Search a Drug",
//                               border: InputBorder.none,
//                               hintStyle: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: 17,
//                               ),
//                             ),
//                             style: const TextStyle(
//                               color: Colors.grey,
//                               fontSize: 19,
//                             ),
//                             onChanged: (searchedValue) {
//                               // searchedItemInList(searchedValue);
//                               // context
//                               //     .read<MedicineCubit>()
//                               //     .searchMedicines(searchedValue);
//                             },
//                             onSubmitted: (value) {
//                               setState(
//                                 () {
//                                   isSearchExpanded = false;
//                                 },
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               //! Fetching medicine

//               verticalSpace(5),

//               isSearchExpanded
//                   ? Container()
//                   : BlocBuilder<MedicineCubit, MedicineState>(
//                       builder: (context, state) {
//                         if (state is MedicineListState) {
//                           final medicineCount = state.medicines.length > 4
//                               ? 4
//                               : state.medicines.length;

//                           return Column(
//                             children: List.generate(
//                               medicineCount,
//                               (index) {
//                                 final medicine = state.medicines[index];
//                                 return ListTile(
//                                   leading: SizedBox(
//                                     height: 100,
//                                     width: 100,
//                                     child: medicine.pictureUrl.isNotEmpty
//                                         ? Image.network(medicine.pictureUrl)
//                                         : const Placeholder(),
//                                   ),
//                                   title: Text(
//                                     medicine.name,
//                                     style: TextStyles.font14DarkMediam,
//                                   ),
//                                   subtitle: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         medicine.description,
//                                         style:
//                                             TextStyles.font14LightGrayRegular,
//                                         maxLines: 1,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                       Text.rich(
//                                         TextSpan(
//                                           children: [
//                                             const TextSpan(
//                                               text: '\$ ',
//                                               style: TextStyle(
//                                                 color: Colors.green,
//                                                 fontSize:
//                                                     16, // Adjust size as needed
//                                               ),
//                                             ),
//                                             TextSpan(
//                                               text:
//                                                   '${medicine.price.toStringAsFixed(2)}',
//                                               style: const TextStyle(
//                                                 color: ColorsProvider
//                                                     .greeting2Color,
//                                                 // Change color as needed
//                                                 fontSize:
//                                                     16, // Adjust size as needed
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             ),
//                           );
//                         } else {
//                           return const Padding(
//                             padding: EdgeInsets.only(
//                                 top: 16.0), // Adjust the top padding as needed
//                             child: Center(
//                               child: SizedBox(
//                                 width: 40, // Adjust size as needed
//                                 height: 40, // Adjust size as needed
//                                 child: CircularProgressIndicator(
//                                   color: ColorsProvider.primaryBink,
//                                 ),
//                               ),
//                             ),
//                           );
//                         }
//                       },
//                     ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: isSearchExpanded
//           ? null
//           : FloatingActionButton(
//               elevation: 0,
//               onPressed: () {
//                 context.pushNamed(Routes.chatbotScreen);
//               },
//               backgroundColor: const Color.fromARGB(255, 228, 197, 208),
//               child: const Icon(
//                 Icons.chat_bubble,
//                 color: ColorsProvider.primaryBink,
//               ),
//             ),
//     );
//   }

//   void aboutUsDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         icon: const Icon(
//           Icons.contact_support,
//           color: ColorsProvider.primaryBink,
//           size: 32,
//         ),
//         content: SizedBox(
//           height: 90,
//           child: Column(
//             children: [
//               const Text(
//                   "We are the team of MedCare App and we will be more than happy to help.."),
//               verticalSpace(10),
//               SelectableText(
//                 'MedCare Phone: +01019686065',
//                 style: TextStyles.font14DarkMediam,
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               primary: ColorsProvider.primaryBink,
//               onPrimary: Colors.white,
//               elevation: 2,
//             ),
//             onPressed: () {
//               context.pop();
//             },
//             child: Text(
//               'Noted',
//               style: TextStyles.font13WhiteSemiBold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/core/cache/cache_helper.dart';
import 'package:medical_app/core/helpers/extensions.dart';
import 'package:medical_app/core/helpers/spacing.dart';
import 'package:medical_app/core/networking/endpoints.dart';
import 'package:medical_app/core/routing/routes.dart';
import 'package:medical_app/core/theming/colors.dart';
import 'package:medical_app/core/theming/styles.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:medical_app/features/home/logic/cubit/medicine_cubit.dart';
import 'package:medical_app/features/home/logic/cubit/medicine_state.dart';
import 'package:medical_app/features/login/logic/cubit/login_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FocusNode _searchFocusNode = FocusNode();
  bool isSearchExpanded = false;
  final searchController = TextEditingController();

  String userUniqename = '';

  @override
  void initState() {
    super.initState();
    context.read<MedicineCubit>().fetchMedicines();
    getUsernameFromCache();
  }

  Future<void> getUsernameFromCache() async {
    final cachedUsername = await ChacheHelper().getDataString(key: ApiKey.name);
    setState(() {
      userUniqename = cachedUsername ?? '';
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: ColorsProvider.primaryBink,
          size: 30,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Transform(
              transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
              alignment: Alignment.center,
              child: IconButton(
                onPressed: () {
                  context.pushNamed(Routes.paymentCheckout); //MyCartViewBody
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  color: ColorsProvider.greeting1Color,
                  size: 33,
                ),
              ),
            ),
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
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/sec.png',
                        scale: 0.7,
                      ),
                      verticalSpace(30),
                      const Center(
                        child: Text(
                          'Settings',
                          style: TextStyle(
                            color: ColorsProvider.darkGray,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpace(20),
                ListTile(
                  leading: const Icon(
                    Icons.contact_support,
                    color: Color(0xffE99987),
                    size: 24,
                  ),
                  title: Text(
                    "About Us",
                    style: TextStyles.font14GrayRegular,
                  ),
                  onTap: () {
                    aboutUsDialog();
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.science,
                    color: Color(0xffE99987),
                    size: 24,
                  ),
                  title: Text(
                    "Test Result",
                    style: TextStyles.font14GrayRegular,
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(
                    Icons.language,
                    color: Color(0xffE99987),
                    size: 24,
                  ),
                  title: Text(
                    "Language",
                    style: TextStyles.font14GrayRegular,
                  ),
                  onTap: () {},
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ListTile(
                leading: const Icon(
                  Icons.logout_outlined,
                  color: Color(0xffE99987),
                  size: 24,
                ),
                title: const Text(
                  "Logout",
                  style: TextStyle(color: Color.fromARGB(255, 153, 62, 55)),
                ),
                onTap: () async {
                  await loginCubit.clearUserData();
                  context.pushNamedAndRemoveUntil(
                    Routes.loginScreen,
                    predicate: (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Hi, $userUniqename",
                  style: TextStyles.font24BinkBold2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                "Hope you doing well..",
                style: TextStyles.font11GrayRegular,
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
                          color: Colors.white,
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
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Container(
                  height: isSearchExpanded ? null : 56,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.search),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _searchFocusNode.requestFocus();

                            setState(() {
                              isSearchExpanded = true;
                            });
                            // FocusScope.of(context)
                            //     .requestFocus(_searchFocusNode);
                          },
                          child: TextField(
                            controller: searchController,
                            focusNode: _searchFocusNode,
                            onTap: () {
                              _searchFocusNode.requestFocus();
                              setState(() {
                                isSearchExpanded = true;
                              });
                            },
                            cursorColor: Colors.blue,
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
                              // context
                              //     .read<MedicineCubit>()
                              //     .searchMedicines(searchedValue);
                              context
                                  .read<MedicineCubit>()
                                  .searchMedicines(searchedValue);
                            },
                            onSubmitted: (value) {
                              // setState(
                              //   () {
                              //     isSearchExpanded = false;
                              //   },
                              // );
                              setState(() {
                                isSearchExpanded = false;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              verticalSpace(5),
              BlocBuilder<MedicineCubit, MedicineState>(
                builder: (context, state) {
                  if (state is MedicineListState) {
                    final medicineCount =
                        state.medicines.length > 4 ? 4 : state.medicines.length;

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
                          return ListTile(
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
                                  maxLines: 1,
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
                                          color: ColorsProvider.greeting2Color,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is MedicineFilteredState) {
                    // Display the filtered list of medicines
                    final medicineCount =
                        state.medicines.length > 4 ? 4 : state.medicines.length;
                    return Column(
                      children: List.generate(
                        medicineCount,
                        (index) {
                          final medicine = state.medicines[index];
                          return ListTile(
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
                                  maxLines: 1,
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
                                          color: ColorsProvider.greeting2Color,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
      floatingActionButton: isSearchExpanded
          ? null
          : FloatingActionButton(
              elevation: 0,
              onPressed: () {
                context.pushNamed(Routes.chatbotScreen);
              },
              backgroundColor: const Color.fromARGB(255, 228, 197, 208),
              child: const Icon(
                Icons.chat_bubble,
                color: ColorsProvider.primaryBink,
              ),
            ),
    );
  }

  void aboutUsDialog() {
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
                style: TextStyles.font14DarkMediam,
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: ColorsProvider.primaryBink,
              onPrimary: Colors.white,
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
