import 'package:flutter/material.dart';
import 'package:medical_app/core/helpers/extensions.dart';
import 'package:medical_app/core/helpers/spacing.dart';
import 'package:medical_app/core/routing/routes.dart';
import 'package:medical_app/core/theming/colors.dart';
import 'package:medical_app/core/theming/styles.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool isSearchExpanded = false;
  final searchController = TextEditingController();

  @override
  void dispose() {
    _searchFocusNode.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              child: const Icon(
                Icons.shopping_cart,
                color: ColorsProvider.greeting1Color,
                size: 33,
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        width: 300,
        child: ListView(
          padding: EdgeInsets.zero,
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
                      'MedCare Settings',
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
            // verticalSpace(150),
            ListTile(
              leading: const Icon(
                Icons.logout_outlined,
                color: Color(0xffE99987),
                size: 24,
              ),
              title: Text(
                "Logout",
                style: TextStyles.font14RedRegular,
              ),
              onTap: () {
                context.pushNamedAndRemoveUntil(
                  Routes.loginScreen,
                  predicate: (route) => false,
                );
              },
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
              Text(
                "Hi, Ramy",
                style: TextStyles.font24BinkBold2,
              ),
              Text(
                "Hope you doing well..",
                style: TextStyles.font11GrayRegular,
              ),
              // verticalSpace(20),

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
                        margin: EdgeInsets.symmetric(horizontal: 5),
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
                      autoPlayInterval: Duration(seconds: 2),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                    ),
                  ),
                ),
              SizedBox(height: 10),
              AnimatedSize(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Container(
                  height: isSearchExpanded ? null : 56,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.search),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // _searchFocusNode.requestFocus();
                            setState(() {
                              isSearchExpanded = true;
                            });
                            FocusScope.of(context)
                                .requestFocus(_searchFocusNode);
                          },
                          child: TextField(
                            controller: searchController,
                            focusNode: _searchFocusNode,
                            onTap: () {
                              setState(() {
                                isSearchExpanded = true;
                              });
                            },
                            cursorColor: Colors.blue,
                            decoration: InputDecoration(
                              hintText: "Search a Drug",
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 19,
                            ),
                            onChanged: (searchedValue) {
                              // searchedItemInList(searchedValue);
                            },
                            onSubmitted: (value) {
                              setState(() {
                                isSearchExpanded = false;
                              });
                              // Perform search or any other action
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //! New Search

              // Positioned(
              //   top: _isSearchExpanded ? 20 : 120,
              //   left: 0,
              //   right: 0,
              //   child: AnimatedContainer(
              //     duration: Duration(milliseconds: 300),
              //     curve: Curves.easeInOut,
              //     child: Container(
              //       height: _isSearchExpanded ? 56 : 0,
              //       decoration: BoxDecoration(
              //         color: Colors.grey[200],
              //         borderRadius: BorderRadius.circular(20),
              //       ),
              //       child: Row(
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Icon(Icons.search),
              //           ),
              //           Expanded(
              //             child: TextField(
              //               controller: _searchController,
              //               focusNode: _searchFocusNode,
              //               onTap: () {
              //                 setState(() {
              //                   _isSearchExpanded = true;
              //                 });
              //               },
              //               decoration: InputDecoration(
              //                 border: InputBorder.none,
              //                 hintText: 'Search...',
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: isSearchExpanded
          ? null
          : FloatingActionButton(
              onPressed: () {
                context.pushNamed(Routes.chatbotScreen);
              },
              backgroundColor: Color.fromARGB(255, 228, 197, 208),
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

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!