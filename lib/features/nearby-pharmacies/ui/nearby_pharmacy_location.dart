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
      body: Center(
        child: Text("Pharmacy Location : Meet Durag :)"),
      ),
    );
  }
}
