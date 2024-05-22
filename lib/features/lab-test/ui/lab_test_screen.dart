import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_app/core/helpers/extensions.dart';
import 'package:medical_app/core/helpers/spacing.dart';
import 'package:medical_app/core/routing/routes.dart';
import 'package:medical_app/core/theming/colors.dart';
import 'package:medical_app/core/theming/styles.dart';

class LabTest extends StatefulWidget {
  const LabTest({super.key});

  @override
  State<LabTest> createState() => _LabTestState();
}

class _LabTestState extends State<LabTest> {
  final FocusNode _searchFocusNode = FocusNode();
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lab Tests"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
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
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Column(
            children: <Widget>[
              verticalSpace(16),
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(100),
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
                            // _searchFocusNode.requestFocus();

                            // setState(() {
                            //   isSearchExpanded = true;
                            // });
                            // FocusScope.of(context)
                            //     .requestFocus(_searchFocusNode);
                          },
                          child: TextField(
                            controller: searchController,
                            focusNode: _searchFocusNode,
                            onTap: () {
                              _searchFocusNode.requestFocus();
                            },
                            cursorColor: Colors.blue,
                            decoration: InputDecoration(
                              hintText: "Search by Lab Tests",
                              border: InputBorder.none,
                              hintStyle: TextStyles.font14GreyMediam,
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
                              // context
                              //     .read<MedicineCubit>()
                              //     .searchMedicines(searchedValue);
                            },
                            onSubmitted: (value) {
                              // setState(
                              //   () {
                              //     isSearchExpanded = false;
                              //   },
                              // );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //* Labs tests
            ],
          ),
        ),
      ),
    );
  }
}
