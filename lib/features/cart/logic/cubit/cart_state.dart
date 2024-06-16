import 'package:medical_app/features/lab-test/data/models/lab_test_model.dart';
import 'package:medical_app/features/home/data/medicine_model.dart';

class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartItemsUpdated extends CartState {
  final List<Medicine> medicineCartItems;
  final List<LabTestModel> labTestCartItems;

  CartItemsUpdated(
      {required this.medicineCartItems, required this.labTestCartItems});

  @override
  List<Object?> get props => [medicineCartItems, labTestCartItems];
}

class CartError extends CartState {
  final String message;

  CartError(this.message);
}
