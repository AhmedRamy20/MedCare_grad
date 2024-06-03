import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_app/core/helpers/extensions.dart';
import 'package:medical_app/core/helpers/spacing.dart';
import 'package:medical_app/core/routing/routes.dart';
import 'package:medical_app/core/theming/colors.dart';
import 'package:medical_app/core/theming/styles.dart';
import 'package:medical_app/features/lab-test/data/models/lab_test_model.dart';
import 'package:medical_app/features/lab-test/logic/cubit/lab_test_cubit.dart';
import 'package:medical_app/features/lab-test/logic/cubit/lab_test_state.dart';
import 'package:medical_app/features/lab-test/ui/lab_details_screen.dart';
import 'package:medical_app/features/lab-test/ui/widgets/lab_test_shimmer.dart';

class LabTest extends StatefulWidget {
  const LabTest({super.key});

  @override
  State<LabTest> createState() => _LabTestState();
}

class _LabTestState extends State<LabTest> {
  final FocusNode _searchFocusNode = FocusNode();
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<LabTestCubit>().fetchLabTests();
  }

  Future<void> _handleRefresh() async {
    await context.read<LabTestCubit>().fetchLabTests();
  }

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
              verticalSpace(10),

              Expanded(
                child: BlocBuilder<LabTestCubit, LabTestState>(
                  builder: (context, state) {
                    if (state is LabTestLoading) {
                      return const HomePageShimmer();
                    } else if (state is LabTestLoaded) {
                      if (state.labTests.isEmpty) {
                        return const Center(
                          child: Text(
                            'No lab tests available.',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        );
                      }
                      final labTestCount =
                          state.labTests.length > 3 ? 3 : state.labTests.length;

                      return RefreshIndicator(
                        onRefresh: _handleRefresh,
                        child: ListView.builder(
                          itemCount: labTestCount, //state.labTests.length
                          itemBuilder: (context, index) {
                            final labTest = state.labTests[index];
                            // return ListTile(
                            //   leading: CircleAvatar(
                            //     backgroundImage: NetworkImage(
                            //         labTest.imageUrl), //labTest.lab.pictureUrl
                            //   ),
                            //   title: Text(labTest.name),
                            //   subtitle: Text(labTest.description),
                            //   trailing: Text('\$${labTest.price.toString()}'),
                            //   onTap: () {
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) =>
                            //             LabDetailScreen(lab: labTest.lab),
                            //       ),
                            //     );
                            //   },
                            // );
                            //!!!
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Center(
                                    //*old
                                    // child: Image.network(
                                    //   labTest.imageUrl,
                                    //   height: 268.h,
                                    //   // width: 341.w,
                                    //   fit: BoxFit.cover,
                                    // ),
                                    //* fancy
                                    child: FancyShimmerImage(
                                      imageUrl: labTest.imageUrl,
                                      height: 268.h,
                                      boxFit: BoxFit.cover,
                                      errorWidget: Container(
                                        color: Colors.grey[200],
                                        child: const Icon(
                                          Icons.error,
                                          color: Colors.red,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 12.h,
                                          bottom: 12,
                                        ),
                                        child: Text(
                                          labTest.name,
                                          style: TextStyles.font14GoldBold,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      // verticalSpace(5),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Text(
                                          labTest.description,
                                          style: TextStyles.font14GrayRegular,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      verticalSpace(5),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Price: ',
                                              style: TextStyles.font16GreyBold,
                                            ),
                                            TextSpan(
                                              text:
                                                  '\$${labTest.price.toString()}',
                                              style: const TextStyle(
                                                color: ColorsProvider.gold,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      verticalSpace(10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LabDetailScreen(
                                                    lab: labTest.lab,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                labTest.lab.pictureUrl,
                                              ), //labTest.lab.pictureUrl
                                            ),
                                          ),

                                          // Lab info
                                          ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  ColorsProvider.primaryBink,
                                              foregroundColor: Colors.white,
                                              elevation: 0,
                                              padding: const EdgeInsets.only(
                                                  top: 10,
                                                  bottom: 13,
                                                  right: 34,
                                                  left: 34),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                            child: const Text("Add to Cart"),
                                          ),
                                        ],
                                      ),

                                      verticalSpace(5),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: Color.fromARGB(255, 220, 219, 219),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    } else if (state is LabTestError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(state.message),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: _handleRefresh,
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
                              child: const Text("Reload"),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
