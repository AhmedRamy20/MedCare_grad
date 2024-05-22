import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/features/lab-test/data/models/lab_test_model.dart';
import 'package:medical_app/features/lab-test/logic/cubit/lab_test_state.dart';

class LabTestCubit extends Cubit<LabTestState> {
  LabTestCubit(this.dio) : super(LabTestInitial());

  final Dio dio;
  Future<void> fetchLabTests() async {
    emit(LabTestLoading());
    try {
      final response =
          await dio.get('http://DawayahealthCare1.somee.com/Test/GetTests');
      final data = response.data as List;
      final labTests = data.map((json) => LabTestModel.fromJson(json)).toList();
      emit(LabTestLoaded(labTests));
    } catch (e) {
      emit(LabTestError(e.toString()));
    }
  }
}
