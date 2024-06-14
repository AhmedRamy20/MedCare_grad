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
//     target: LatLng(37.42796133580664,
//         -122.085749655962),
//     zoom: 14.0,
//   );

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

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

import 'package:flutter/material.dart';

class NearbyPharmacies extends StatefulWidget {
  const NearbyPharmacies({super.key});

  @override
  State<NearbyPharmacies> createState() => _NearbyPharmaciesState();
}

class _NearbyPharmaciesState extends State<NearbyPharmacies> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Hope next try it will work :(")),
      // floatingActionButton: FloatingActionButton.extended(
      //   heroTag: "619",
      //   onPressed: _goToTheLake,
      //   label: const Text('To the lake!'),
      //   icon: const Icon(Icons.directions_boat),
      // ),
    );
  }
}
