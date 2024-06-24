import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:medical_app/core/helpers/location_helper.dart';
import 'package:medical_app/core/theming/colors.dart';

class NearbyPharmacies extends StatefulWidget {
  const NearbyPharmacies({Key? key}) : super(key: key);

  @override
  State<NearbyPharmacies> createState() => _NearbyPharmaciesState();
}

class _NearbyPharmaciesState extends State<NearbyPharmacies> {
  Position? _currentPosition;
  Completer<GoogleMapController> _mapController = Completer();
  List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      _currentPosition = await LocationHelper.getCurrentLocation();
      _updateMarkers();
    } catch (e) {
      print('Error getting current location: $e');
    }
  }

  void _updateMarkers() {
    setState(() {
      _markers.clear();
      if (_currentPosition != null) {
        // Add user's current location marker
        _markers.add(Marker(
          markerId: const MarkerId('currentLocation'),
          position:
              LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          infoWindow: const InfoWindow(
            title: 'Current Location',
            snippet: 'This is your current location',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ));

        List<Pharmacy> nearbyPharmacies = [
          Pharmacy(
              name: 'Pharmacy A', location: const LatLng(30.550223, 31.257712)),
          Pharmacy(
              name: 'Pharmacy B', location: const LatLng(30.553468, 31.252693)),
          Pharmacy(
              name: 'Pharmacy C', location: const LatLng(30.553978, 31.256765)),
        ];

        nearbyPharmacies.forEach((pharmacy) {
          _markers.add(Marker(
            markerId: MarkerId(pharmacy.name),
            position: pharmacy.location,
            infoWindow: InfoWindow(
              title: pharmacy.name,
              snippet: 'Tap to view details',
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure),
          ));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _currentPosition != null
              ? GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(_currentPosition!.latitude,
                        _currentPosition!.longitude),
                    zoom: 15,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _mapController.complete(controller);
                  },
                  markers: Set<Marker>.from(_markers),
                )
              : const Center(
                  child: CircularProgressIndicator(
                    color: ColorsProvider.primaryBink,
                  ),
                ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _markers.length,
                itemBuilder: (context, index) {
                  Marker marker = _markers[index];
                  if (marker.markerId.value == 'currentLocation') {
                    return const SizedBox
                        .shrink(); // Skip rendering for current location marker
                  }
                  return _buildPharmacyContainer(marker);
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "Salam alykom",
        backgroundColor: ColorsProvider.primaryBink,
        onPressed: _goToMyCurrentLocation,
        child: const Icon(
          Icons.place,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildPharmacyContainer(Marker marker) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    final textColor = isDarkTheme ? Colors.white : Colors.black;

    return GestureDetector(
      onTap: () {
        _goToPharmacyLocation(marker.position);
      },
      child: Container(
        width: 200,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isDarkTheme ? Colors.grey[850] : Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                marker.infoWindow.title!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(marker.infoWindow.snippet!),
              const SizedBox(height: 4),
              FutureBuilder<String>(
                future: _getDistance(marker.position),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text('Distance: ${snapshot.data}',
                        style: TextStyle(color: textColor));
                  } else if (snapshot.hasError) {
                    return Text('Error calculating distance',
                        style: TextStyle(color: textColor));
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              const SizedBox(height: 4),
              ElevatedButton(
                onPressed: () {
                  _showPharmacyDetails(
                      marker.infoWindow.title!, marker.position);
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
                child: const Text('View Details'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> _getDistance(LatLng destination) async {
    if (_currentPosition != null) {
      double distanceInMeters = await Geolocator.distanceBetween(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        destination.latitude,
        destination.longitude,
      );
      double distanceInKm = distanceInMeters / 1000;
      return '${distanceInKm.toStringAsFixed(2)} km';
    } else {
      return 'Unknown';
    }
  }

  void _goToMyCurrentLocation() {
    _mapController.future.then((controller) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target:
                LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
            zoom: 17,
          ),
        ),
      );
    });
  }

  void _goToPharmacyLocation(LatLng location) {
    _mapController.future.then((controller) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: location,
            zoom: 17,
          ),
        ),
      );
    });
  }

  void _showPharmacyDetails(String pharmacyName, LatLng pharmacyLocation) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Pharmacy Details'),
        content: FutureBuilder<String>(
          future: _getDistance(pharmacyLocation),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Name: $pharmacyName'),
                  const SizedBox(height: 8),
                  Text('Distance: ${snapshot.data}'),
                ],
              );
            } else if (snapshot.hasError) {
              return const Text('Error calculating distance');
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class Pharmacy {
  final String name;
  final LatLng location;

  Pharmacy({required this.name, required this.location});
}
