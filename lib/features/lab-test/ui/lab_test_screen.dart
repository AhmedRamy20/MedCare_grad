import 'package:badges/badges.dart';
import 'package:dio/dio.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medical_app/core/cache/cache_helper.dart';
import 'package:medical_app/core/helpers/extensions.dart';
import 'package:medical_app/core/helpers/spacing.dart';
import 'package:medical_app/core/networking/endpoints.dart';
import 'package:medical_app/core/routing/routes.dart';
import 'package:medical_app/core/theming/colors.dart';
import 'package:medical_app/core/theming/styles.dart';
import 'package:medical_app/features/cart/logic/cubit/cart_cubit.dart';
import 'package:medical_app/features/cart/logic/cubit/cart_state.dart';
import 'package:medical_app/features/lab-test/data/models/lab_test_model.dart';
import 'package:medical_app/features/lab-test/logic/cubit/lab_test_cubit.dart';
import 'package:medical_app/features/lab-test/logic/cubit/lab_test_state.dart';
import 'package:medical_app/features/lab-test/ui/lab_details_screen.dart';
import 'package:medical_app/features/lab-test/ui/widgets/lab_test_shimmer.dart';
import 'package:badges/badges.dart' as badges;

class LabTest extends StatefulWidget {
  const LabTest({super.key});

  @override
  State<LabTest> createState() => _LabTestState();
}

class _LabTestState extends State<LabTest> {
  final FocusNode _searchFocusNode = FocusNode();
  final searchController = TextEditingController();

  DateTime? selectedDate;
  String userUniqename = '';
  LatLng? selectedLocation;

  @override
  void initState() {
    super.initState();
    context.read<LabTestCubit>().fetchLabTests();
    context.read<CartCubit>().loadCart();
    getUsernameFromCache();
    _determinePosition();
  }

  Future<void> getUsernameFromCache() async {
    final cachedUsername = await ChacheHelper().getDataString(key: ApiKey.name);
    setState(() {
      userUniqename = cachedUsername ?? '';
    });
  }

  //!!!!!!! Determine pos

  Future<void> _determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      selectedLocation = LatLng(position.latitude, position.longitude);
    });
  }

  Future<void> _handleRefresh() async {
    await context.read<LabTestCubit>().fetchLabTests();
  }

  //!!!!!!!!!!!!!!!!!!! Booking!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  Future<void> _selectDate(BuildContext context, LabTestModel labTest) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      _confirmBooking(picked, labTest);
    }
  }

  void _confirmBooking(DateTime date, LabTestModel labTest) {
    final formattedDate = "${date.toLocal()}".split(' ')[0];

    if (selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a location on the map.'),
        ),
      );
      return;
    }
    _makeBookingRequest(formattedDate, labTest, selectedLocation!);
  }

  Future<void> _makeBookingRequest(
      String bookingDate, LabTestModel labTest, LatLng location) async {
    final Dio dio = Dio();

    //! Convert the lat and lang in readable sent
    String? locationName;
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(location.latitude, location.longitude);
      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        locationName =
            "${placemark.name}, ${placemark.locality}, ${placemark.administrativeArea}";
      } else {
        locationName = "Unknown Location";
      }
    } catch (e) {
      locationName = "Unknown Location";
    }

    final bookingDetails = {
      "bookingTime": bookingDate,
      "userName": userUniqename,
      "labId": labTest.lab.id,
      "location": locationName,
      "tests": [
        {"testName": labTest.name}
      ]
    };

    try {
      final response = await dio.post(
          'http://DawayaHealthCare70.somee.com/User/Add-Appointment-User-For-Lab',
          data: bookingDetails);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Booking confirmed for ${labTest.name} on $bookingDate'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to book the lab test. Please try again.'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
        ),
      );
    }
  }

  //!!!!!!!!!!!!!!!!!!! Booking!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  //!!!!!!!!!!!!!!!!!!! Location!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  void _showLocationPickerModal(BuildContext context) async {
    final LatLng? pickedLocation = await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        final theme = Theme.of(context);
        final isDarkTheme = theme.brightness == Brightness.dark;
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Column(
            children: [
              Expanded(
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: selectedLocation ?? LatLng(0, 0),
                    zoom: 3,
                  ),
                  onTap: (LatLng location) {
                    setState(() {
                      selectedLocation = location;
                    });
                  },
                  markers: {
                    if (selectedLocation != null)
                      Marker(
                        markerId: MarkerId('selected_location'),
                        position: selectedLocation!,
                      ),
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, selectedLocation);
                },
                child: Text(
                  'Select Location',
                  style: TextStyle(
                    color: isDarkTheme ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (pickedLocation != null) {
      setState(() {
        selectedLocation = pickedLocation;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lab Tests"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
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
                      badgeStyle: BadgeStyle(
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
                    color: isDarkTheme
                        ? ColorsProvider.feildWhite
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(100),
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
                        child: TextField(
                          controller: searchController,
                          focusNode: _searchFocusNode,
                          onTap: () {
                            _searchFocusNode.requestFocus();
                          },
                          cursorColor:
                              isDarkTheme ? Colors.white : Colors.black,
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
                            context
                                .read<LabTestCubit>()
                                .searchLabTests(searchedValue);
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

                      final labTestCount = state.labTests.length;

                      return RefreshIndicator(
                        color: ColorsProvider.primaryBink,
                        onRefresh: _handleRefresh,
                        child: ListView.builder(
                          itemCount: labTestCount, //state.labTests.length
                          itemBuilder: (context, index) {
                            final labTest = state.labTests[index];

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
                                      imageUrl: labTest.imageUrl ?? '',
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
                                          labTest.description ?? '',
                                          style: isDarkTheme
                                              ? TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.sp)
                                              : TextStyles.font14GrayRegular,
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

                                          //! Lab Add to cart
                                          // ElevatedButton(
                                          //   onPressed: () {
                                          //     context
                                          //         .read<CartCubit>()
                                          //         .addToLabTestCart(labTest);
                                          //     ScaffoldMessenger.of(context)
                                          //         .showSnackBar(
                                          //       SnackBar(
                                          //         content: Text(
                                          //             '${labTest.name} added to cart'),
                                          //       ),
                                          //     );
                                          //   },
                                          //   style: ElevatedButton.styleFrom(
                                          //     backgroundColor:
                                          //         ColorsProvider.primaryBink,
                                          //     foregroundColor: Colors.white,
                                          //     elevation: 0,
                                          //     padding: const EdgeInsets.only(
                                          //         top: 10,
                                          //         bottom: 13,
                                          //         right: 34,
                                          //         left: 34),
                                          //     shape: RoundedRectangleBorder(
                                          //       borderRadius:
                                          //           BorderRadius.circular(15),
                                          //     ),
                                          //   ),
                                          //   child: const Text("Add to Cart"),
                                          // ),

                                          //** cart
                                          // ElevatedButton(
                                          //   onPressed: () {
                                          //     int quantityAdded =
                                          //         labTest.quantity;
                                          //     context
                                          //         .read<CartCubit>()
                                          //         .addToLabTestCart(labTest);
                                          //     ScaffoldMessenger.of(context)
                                          //         .showSnackBar(
                                          //       SnackBar(
                                          //         content: Text(
                                          //             '${labTest.name} added to cart'),
                                          //         duration:
                                          //             Duration(seconds: 1),
                                          //         action: SnackBarAction(
                                          //           label: 'Undo',
                                          //           onPressed: () {
                                          //             context
                                          //                 .read<CartCubit>()
                                          //                 .removeSpecificLabTestQuantity(
                                          //                     labTest,
                                          //                     quantityAdded);
                                          //           },
                                          //         ),
                                          //       ),
                                          //     );
                                          //   },
                                          //   style: ElevatedButton.styleFrom(
                                          //     backgroundColor:
                                          //         ColorsProvider.primaryBink,
                                          //     foregroundColor: Colors.white,
                                          //     elevation: 0,
                                          //     padding: const EdgeInsets.only(
                                          //         top: 10,
                                          //         bottom: 13,
                                          //         right: 34,
                                          //         left: 34),
                                          //     shape: RoundedRectangleBorder(
                                          //       borderRadius:
                                          //           BorderRadius.circular(15),
                                          //     ),
                                          //   ),
                                          //   child: const Text("Add to Cart"),
                                          // ),

                                          //!!!!!! Booking

                                          ElevatedButton(
                                            onPressed: () =>
                                                _selectDate(context, labTest),
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
                                            child: const Text("Book now"),
                                          ),
                                        ],
                                      ),

                                      verticalSpace(5),
                                      if (selectedLocation != null)
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Selected Location:',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            verticalSpace(4),
                                            Text(
                                              'Latitude: ${selectedLocation!.latitude}',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),

                                      verticalSpace(16),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorsProvider.primaryBink,
        onPressed: () {
          _showLocationPickerModal(context);
        },
        child: const Icon(
          Icons.place,
          color: Colors.white,
        ),
      ),
    );
  }
}
