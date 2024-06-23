import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/core/cache/cache_helper.dart';
import 'package:medical_app/core/networking/endpoints.dart';
import 'package:medical_app/core/theming/colors.dart';

class LabTestResultScreen extends StatefulWidget {
  const LabTestResultScreen({super.key});

  @override
  State<LabTestResultScreen> createState() => _LabTestResultScreenState();
}

class _LabTestResultScreenState extends State<LabTestResultScreen> {
  late Future<String?> _imageURLFuture;
  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    _imageURLFuture = _fetchTestResultImage();
  }

  Future<String?> _fetchTestResultImage() async {
    String apiUrl = 'http://DawayaHealthCare70.somee.com/User/Get-Test-Result';

    final cachedUsername = await ChacheHelper().getDataString(key: ApiKey.name);
    String patientName = cachedUsername.toString();

    try {
      Response response = await _dio.get('$apiUrl/$patientName');

      if (response.statusCode == 200) {
        return response.data.toString();
      } else {
        print('Failed to load image: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching image: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Result"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder<String?>(
        future: _imageURLFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: ColorsProvider.primaryBink,
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data != null) {
            return Center(
              child: Image.network(
                snapshot.data!,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                      child: CircularProgressIndicator(
                    color: ColorsProvider.primaryBink,
                  ));
                },
                errorBuilder: (context, error, stackTrace) {
                  return Text('Failed to load image');
                },
              ),
            );
          } else {
            return const Center(child: Text('No image available'));
          }
        },
      ),
    );
  }
}
