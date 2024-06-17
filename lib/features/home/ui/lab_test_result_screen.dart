import 'package:flutter/material.dart';

class LabTestResultScreen extends StatefulWidget {
  const LabTestResultScreen({super.key});

  @override
  State<LabTestResultScreen> createState() => _LabTestResultScreenState();
}

class _LabTestResultScreenState extends State<LabTestResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Result"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: const Center(
        child: Text("This is lab test for now .."),
      ),
    );
  }
}
