import 'package:medical_app/features/home/data/medicine_model.dart';

class MedicineState {}

class MedicineInitial extends MedicineState {}

class MedicineListLoadingState extends MedicineState {}

class MedicineListState extends MedicineState {
  final List<Medicine> medicines;
  MedicineListState({
    required this.medicines,
  });
}

class MedicineFilteredState extends MedicineState {
  final List<Medicine> medicines;

  MedicineFilteredState({required this.medicines});

  // @override
  // List<Object?> get props => [filteredMedicines];
}
