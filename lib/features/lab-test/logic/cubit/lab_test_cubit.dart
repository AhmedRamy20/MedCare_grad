import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/features/lab-test/data/models/lab_test_model.dart';
import 'package:medical_app/features/lab-test/logic/cubit/lab_test_state.dart';

class LabTestCubit extends Cubit<LabTestState> {
  LabTestCubit(this.dio) : super(LabTestInitial());

  final Dio dio;
  List<LabTestModel> cachedLabTests = [];
  List<LabTestModel> filteredLabTests = []; // Add filtered list for search

  Future<void> fetchLabTests() async {
    emit(LabTestLoading());
    try {
      final response =
          await dio.get('http://DawayaHealthCare777.somee.com/Test/GetTests');
      final data = response.data as List;
      final labTests = data.map((json) => LabTestModel.fromJson(json)).toList();
      // emit(LabTestLoaded(labTests));
      cachedLabTests = labTests;
      filteredLabTests = cachedLabTests;
      emit(LabTestLoaded(filteredLabTests));

      if (isClosed) return; // Check again before emitting
      emit(LabTestLoaded(labTests));
    } on DioError catch (e) {
      if (isClosed) return;
      if (e.error is SocketException) {
        // User is offline, emit cached lab tests if available
        if (cachedLabTests.isNotEmpty) {
          emit(LabTestLoaded(cachedLabTests, isOffline: true));
        } else {
          emit(LabTestError("Please check your connection...."));
        }
      } else {
        emit(LabTestError(e.message.toString()));
      }
    } catch (e) {
      if (isClosed) return;
      emit(LabTestError(e.toString()));
    }
  }

  void searchLabTests(String query) {
    if (query.isEmpty) {
      filteredLabTests = cachedLabTests;
    } else {
      filteredLabTests = cachedLabTests
          .where((labTest) =>
              labTest.name.toLowerCase().contains(query.toLowerCase()) ||
              labTest.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    emit(LabTestLoaded(filteredLabTests));
  }
}
