import 'package:medical_app/features/lab-test/data/models/lab_test_model.dart';

class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartItemsUpdated extends CartState {
  final List<LabTestModel> cartItems;

  CartItemsUpdated({required this.cartItems});
}

class CartError extends CartState {
  final String message;

  CartError(this.message);
}
