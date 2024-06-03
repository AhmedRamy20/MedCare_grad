import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/core/networking/endpoints.dart';
import 'package:medical_app/features/home/data/medicine_model.dart';
import 'package:medical_app/features/home/logic/cubit/medicine_state.dart';

class MedicineCubit extends Cubit<MedicineState> {
  MedicineCubit() : super(MedicineInitial());

  final Dio dio = Dio();
  List<Medicine> notFilteredmedicines = [];
  List<Medicine> filteredMedicines = [];

  Future<void> fetchMedicines() async {
    try {
      emit(MedicineListLoadingState());
      final response = await dio.get(EndPoints.wholeGetMedicine);
      if (response.statusCode == 200) {
        final List<dynamic>? data = response.data;
        if (data != null) {
          final List<Medicine> medicines =
              data.map((json) => Medicine.fromJson(json)).toList();
          notFilteredmedicines.addAll(medicines);
          emit(MedicineListState(medicines: medicines));
        } else {
          throw Exception('Failed to load medicines: Response data is null');
          // emit(
          //     MedicineError('Failed to load medicines: Response data is null'));
        }
      } else {
        throw Exception('Failed to load medicines: ${response.statusCode}');
        // emit(MedicineError('Failed to load medicines: ${response.statusCode}'));
      }
    } catch (error) {
      throw Exception('Failed to load medicines: $error');
      // emit(MedicineError('Failed to load medicines: $error'));
    }
  }

  //! Search

  void filterMedicines(String query) {
    final filteredList = notFilteredmedicines
        .where((medicine) =>
            medicine.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    emit(MedicineFilteredState(medicines: filteredList));
  }

  // void searchMedicines(String query) {
  //   if (query.isEmpty) {
  //     emit(MedicineListState(medicines: notFilteredmedicines));
  //   } else {
  //     filterMedicines(query);
  //   }
  // }

  void searchMedicines(String query) {
    print("Searching for: $query");
    if (query.isEmpty) {
      // filteredMedicines = List.from(notFilteredmedicines);
      // emit(MedicineListState(medicines: notFilteredmedicines));
      emit(MedicineListState(medicines: notFilteredmedicines));
    } else {
      filteredMedicines.clear();
      filteredMedicines = notFilteredmedicines
          .where((medicine) =>
              medicine.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    print(
        "Filtered medicines count: ${filteredMedicines.length}"); // Debug statement
    emit(MedicineListState(medicines: filteredMedicines));
  }

  // void clearFilteredList() {
  //   emit(MedicineFilteredState(medicines: []));
  // }
}





//* Search

  // void filterMedicines(String query) {
  //   final currentState = state;
  //   if (currentState is MedicineListState) {
  //     final filteredList = currentState.medicines
  //         .where((medicine) =>
  //             medicine.name.toLowerCase().contains(query.toLowerCase()))
  //         .toList();
  //     emit(MedicineFilteredState(filteredMedicines: filteredList));
  //   }
  // }

  // void searchMedicines(String query) {
  //   if (query.isEmpty) {
  //     emit(MedicineListState(medicines: [])); // Reset to original list
  //   } else {
  //     filterMedicines(query);
  //   }
  // }
