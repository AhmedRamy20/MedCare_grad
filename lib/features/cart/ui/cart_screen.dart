import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medical_app/core/helpers/spacing.dart';
import 'package:medical_app/core/routing/routes.dart';
import 'package:medical_app/core/theming/colors.dart';
import 'package:medical_app/core/theming/styles.dart';
import 'package:medical_app/features/cart/logic/cubit/cart_cubit.dart';
import 'package:medical_app/features/cart/logic/cubit/cart_state.dart';
import 'package:medical_app/features/home/data/medicine_model.dart';
import 'package:medical_app/features/lab-test/data/models/lab_test_model.dart';
import 'package:medical_app/core/cache/cache_helper.dart';
import 'package:geolocator/geolocator.dart';

import 'package:geocoding/geocoding.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Medicine> _medicineCartItems = [];
  List<LabTestModel> _labTestCartItems = [];
  final ChacheHelper _cacheHelper = ChacheHelper();
  bool _isHomeSelected = false; // Track if "Home" radio button
  String? _selectedGender;

  TextEditingController _locationController = TextEditingController();

  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _initializeCart();
    _determinePosition();
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Please enable your location");
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Permission Denied");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
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
                    "We can not detect your location while not enabling your Location...."),
                verticalSpace(10),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsProvider.primaryBink,
                elevation: 2,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Got it',
                style: TextStyles.font13WhiteSemiBold,
              ),
            ),
          ],
        ),
      );

      return;
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = position;
        _locationController.text =
            "${position.latitude}, ${position.longitude}";
      });

      List<Placemark> placemarks = [];
      try {
        placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
      } catch (e) {
        print('Error fetching placemarks: $e');
        return;
      }

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        setState(() {
          _locationController.text =
              "${placemark.locality}, ${placemark.country}";
        });
      } else {
        print('No placemark available for these coordinates');
      }
    }
  }

  Future<void> _initializeCart() async {
    await _cacheHelper.init();
    setState(() {
      _medicineCartItems = _cacheHelper.getMedicineCartItems();
      _labTestCartItems = _cacheHelper.getLabTestCartItems();
    });
  }

  Future<void> _refreshCart() async {
    await _cacheHelper.init();
    setState(() {
      _medicineCartItems = _cacheHelper.getMedicineCartItems();
      _labTestCartItems = _cacheHelper.getLabTestCartItems();
    });
  }

  Widget _buildMiniMap() {
    if (_currentPosition == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Container(
      height: 200,
      width: double.infinity,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target:
              LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: MarkerId("currentLocation"),
            position:
                LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          ),
        },
        zoomControlsEnabled: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshCart,
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartInitial) {
              context.read<CartCubit>().loadCart();
              return const Center(child: CircularProgressIndicator());
            } else if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CartItemsUpdated) {
              _medicineCartItems = state.medicineCartItems;
              _labTestCartItems = state.labTestCartItems;

              // //! Save updated cart items to SharedPref
              // _cacheHelper.saveMedicineCartItems(_medicineCartItems);
              // _cacheHelper.saveLabTestCartItems(_labTestCartItems);
              if (_medicineCartItems.isEmpty && _labTestCartItems.isEmpty) {
                return const Center(child: Text('No items in the cart.'));
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount:
                          _medicineCartItems.length + _labTestCartItems.length,
                      itemBuilder: (context, index) {
                        if (index < _medicineCartItems.length) {
                          final medicine = _medicineCartItems[index];
                          return buildMedicineItem(context, medicine);
                        } else {
                          final labTest = _labTestCartItems[
                              index - _medicineCartItems.length];
                          return buildLabTestItem(context, labTest);
                        }
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                      right: 14,
                      left: 14,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            // spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(2, 5),
                          ),
                        ],
                      ),
                      child: Divider(
                        thickness: 3,
                        // endIndent: 20,
                      ),
                    ),
                  ),

                  verticalSpace(10),

                  // Show location input and mini-map always
                  if (!_isHomeSelected)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _locationController,
                            decoration: const InputDecoration(
                                labelText: 'Enter your location',
                                border: OutlineInputBorder(),
                                prefix: Icon(
                                  Icons.place,
                                  color: ColorsProvider.primaryBink,
                                )),
                          ),
                          const SizedBox(height: 5),
                          _buildMiniMap(),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),

                  // Additional section based on selection
                  if (_labTestCartItems.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Radio(
                                value: false,
                                groupValue: _isHomeSelected,
                                onChanged: (value) {
                                  setState(() {
                                    _isHomeSelected = value as bool;
                                  });
                                },
                                activeColor: ColorsProvider.primaryBink,
                              ),
                              const Text('Home'),
                              Radio(
                                value: true,
                                groupValue: _isHomeSelected,
                                onChanged: (value) {
                                  setState(() {
                                    _isHomeSelected = value as bool;
                                  });
                                },
                                activeColor: ColorsProvider.primaryBink,
                              ),
                              const Text('Site'),
                            ],
                          ),
                        ),
                        if (!_isHomeSelected)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: 'male',
                                  groupValue: _selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender = value;
                                    });
                                  },
                                  activeColor: ColorsProvider.primaryBink,
                                ),
                                const Text('Male'),
                                Radio<String>(
                                  value: 'female',
                                  groupValue: _selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender = value;
                                    });
                                  },
                                  activeColor: ColorsProvider.primaryBink,
                                ),
                                const Text('Female'),
                              ],
                            ),
                          ),
                      ],
                    ),

                  // Checkout button
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                      right: 16.0,
                      left: 16.0,
                      bottom: 10.0,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        // Calculate total price
                        double totalPrice = _medicineCartItems.fold<double>(
                              0.0,
                              (previousValue, element) =>
                                  previousValue +
                                  (element.price * element.quantity),
                            ) +
                            _labTestCartItems.fold<double>(
                              0.0,
                              (previousValue, element) =>
                                  previousValue +
                                  (element.price * element.quantity),
                            );

                        // //! Save updated cart items to SharedPref
                        // _cacheHelper.saveMedicineCartItems(_medicineCartItems);
                        // _cacheHelper.saveLabTestCartItems(_labTestCartItems);
                        Navigator.of(context).pushNamed(
                          Routes.paymentCheckout,
                          arguments: {'totalPrice': totalPrice},
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsProvider.primaryBink,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: const Text(
                        'Checkout',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is CartError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget buildMedicineItem(BuildContext context, Medicine medicine) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: isDarkTheme ? Colors.grey.shade300 : Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Center(
                  child: SizedBox(
                    width: 80.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        medicine.pictureUrl,
                        fit: BoxFit.cover,
                        width: 80.0,
                        height: 90.0,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              color: ColorsProvider.primaryBink,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey[300],
                            child: const Icon(Icons.error, color: Colors.red),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                medicine.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                context
                                    .read<CartCubit>()
                                    .removeFromMedicineCart(medicine);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: ColorsProvider.primaryBink,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Price: \$${medicine.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black54,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.remove,
                                color: ColorsProvider.primaryBink,
                              ),
                              onPressed: () {
                                context
                                    .read<CartCubit>()
                                    .decreaseMedicineQuantity(medicine);
                              },
                            ),
                            Text(
                              '${medicine.quantity}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.add,
                                color: ColorsProvider.primaryBink,
                              ),
                              onPressed: () {
                                context
                                    .read<CartCubit>()
                                    .increaseMedicineQuantity(medicine);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 15,
          child: Transform.rotate(
            angle: 100.0,
            child: Container(
              width: 70,
              height: 20,
              decoration: BoxDecoration(
                color: ColorsProvider.primaryBink,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "Drug",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLabTestItem(BuildContext context, LabTestModel labTest) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: isDarkTheme ? Colors.grey.shade300 : Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Center(
                  child: SizedBox(
                    width: 80.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        labTest.imageUrl ?? '',
                        fit: BoxFit.cover,
                        width: 80.0,
                        height: 90.0,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              color: ColorsProvider.primaryBink,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey[300],
                            child: const Icon(Icons.error, color: Colors.red),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                labTest.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                context
                                    .read<CartCubit>()
                                    .removeFromLabTestCart(labTest);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: ColorsProvider.primaryBink,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Price: \$${labTest.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black54,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.remove,
                                color: ColorsProvider.primaryBink,
                              ),
                              onPressed: () {
                                context
                                    .read<CartCubit>()
                                    .decreaseLabTestQuantity(labTest);
                              },
                            ),
                            Text(
                              '${labTest.quantity}',
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.add,
                                color: ColorsProvider.primaryBink,
                              ),
                              onPressed: () {
                                context
                                    .read<CartCubit>()
                                    .increaseLabTestQuantity(labTest);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 15,
          child: Transform.rotate(
            angle: 100.0,
            child: Container(
              width: 70,
              height: 20,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 71, 172, 235),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "Test",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
