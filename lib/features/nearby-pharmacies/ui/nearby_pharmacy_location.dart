// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:permission_handler/permission_handler.dart';

// class NearbyPharmacies extends StatefulWidget {
//   const NearbyPharmacies({super.key});

//   @override
//   State<NearbyPharmacies> createState() => _NearbyPharmaciesState();
// }

// class _NearbyPharmaciesState extends State<NearbyPharmacies> {
//   final Completer<GoogleMapController> _controller =
//   Completer<GoogleMapController>();

//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 8,
//   );

//   static const CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(37.43296265331129, -122.08832357078792),
//       tilt: 59.440717697143555,
//       zoom: 5);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         mapType: MapType.normal,
//         initialCameraPosition: _kGooglePlex,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         heroTag: "619",
//         onPressed: _goToTheLake,
//         label: const Text('To the lake!'),
//         icon: const Icon(Icons.directions_boat),
//       ),
//     );
//   }

//   Future<void> _goToTheLake() async {
//     final GoogleMapController controller = await _controller.future;
//     await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   }
// }

//!!!!!!!!!!!!!!!!!!!!!

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class NearbyPharmacies extends StatefulWidget {
//   const NearbyPharmacies({super.key});
//   @override
//   State<NearbyPharmacies> createState() => _NearbyPharmaciesState();
// }

// class _NearbyPharmaciesState extends State<NearbyPharmacies> {
//   Completer<GoogleMapController> _controller = Completer();

//   static final CameraPosition _initialPosition = CameraPosition(
//       target: LatLng(37.42796133580664, -122.085749655962), zoom: 14.4746);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Nearby Pharmacies'),
//       ),
//       body: GoogleMap(
//         mapType: MapType.normal,
//         initialCameraPosition: _initialPosition,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//     );
//   }
// }

//* to check Api Key => https://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=AIzaSyCuTilAfnGfkZtIx0T3qf-eOmWZ_N2LpoY

//* key: "AIzaSyCuTilAfnGfkZtIx0T3qf-eOmWZ_N2LpoY",
//* AIzaSyAdps_rCUe-0ZItkn2DEV_TGYnLpHio9XY
//! AIzaSyCuTilAfnGfkZtIx0T3qf-eOmWZ_N2LpoY
//* AIzaSyAzSSxYEnHx3TL963hnYFftU8zPcXW9x5s
//* AIzaSyCOkTjXIbM_HWzMUd5OdEv2H3dq5BnGXJU
//? AIzaSyCTaCXHs7ZwIckaS61IrdpYj08fz5p4oos

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

//????????????????????

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'dart:async';
// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';

// class NearbyPharmacies extends StatefulWidget {
//   const NearbyPharmacies({super.key});

//   @override
//   State<NearbyPharmacies> createState() => _NearbyPharmaciesState();
// }

// class _NearbyPharmaciesState extends State<NearbyPharmacies> {
//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();

//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );

//   late Position _currentPosition;
//   late CameraPosition _currentCameraPosition;

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   Future<void> _getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled, don't continue
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, next time you could try requesting permissions again
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     // When we reach here, permissions are granted and we can continue accessing the position of the device
//     Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//         .then((Position position) {
//       setState(() {
//         _currentPosition = position;
//         _currentCameraPosition = CameraPosition(
//           target: LatLng(position.latitude, position.longitude),
//           zoom: 14.4746,
//         );
//         _goToCurrentLocation();
//       });
//     }).catchError((e) {
//       print(e);
//     });
//   }

//   Future<void> _goToCurrentLocation() async {
//     final GoogleMapController controller = await _controller.future;
//     controller
//         .animateCamera(CameraUpdate.newCameraPosition(_currentCameraPosition));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         mapType: MapType.normal,
//         initialCameraPosition: _kGooglePlex,
//         myLocationEnabled: true,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: _getCurrentLocation,
//         label: const Text('Current Location'),
//         icon: const Icon(Icons.my_location),
//       ),
//     );
//   }
// }

//***************** */

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:medical_app/core/helpers/location_helper.dart';
import 'package:medical_app/core/theming/colors.dart';

class NearbyPharmacies extends StatefulWidget {
  const NearbyPharmacies({super.key});

  @override
  State<NearbyPharmacies> createState() => _NearbyPharmaciesState();
}

class _NearbyPharmaciesState extends State<NearbyPharmacies> {
  static Position? position;
  Completer<GoogleMapController> _mapController = Completer();

  static final CameraPosition _myCurrentLocationCameraPosition = CameraPosition(
    bearing: 0.0,
    target: LatLng(position!.latitude, position!.longitude),
    tilt: 0.0,
    zoom: 17,
  );

  Future<void> getMyCurrentLocation() async {
    position = await LocationHelper.getCurrentLocation().whenComplete(() {
      setState(() {});
    });
  }

  @override
  initState() {
    super.initState();
    getMyCurrentLocation();
  }

  Widget buildMap() {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      initialCameraPosition: _myCurrentLocationCameraPosition,
      onMapCreated: (GoogleMapController controller) {
        _mapController.complete(controller);
      },
    );
  }

  Future<void> _goToMyCurrentLocation() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(_myCurrentLocationCameraPosition));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          position != null
              ? buildMap()
              : Center(
                  child: Container(
                    child: CircularProgressIndicator(
                      color: ColorsProvider.primaryBink,
                    ),
                  ),
                ),
        ],
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 8, 30),
        child: FloatingActionButton(
          backgroundColor: ColorsProvider.primaryBink,
          onPressed: _goToMyCurrentLocation,
          child: const Icon(
            Icons.place,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
