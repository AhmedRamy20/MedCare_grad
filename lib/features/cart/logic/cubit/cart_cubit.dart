import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/features/cart/logic/cubit/cart_state.dart';
import 'package:medical_app/features/lab-test/data/models/lab_test_model.dart';

class CartCubit extends Cubit<CartState> {
  List<LabTestModel> cartItems = [];

  CartCubit() : super(CartInitial());

  void loadCart() {
    emit(CartLoading());
    Future.delayed(const Duration(seconds: 1), () {
      emit(CartItemsUpdated(cartItems: cartItems));
    });
  }

  void addToCart(LabTestModel labTest) {
    cartItems.add(labTest);
    emit(CartItemsUpdated(cartItems: cartItems));
  }

  void removeFromCart(LabTestModel labTest) {
    cartItems.remove(labTest);
    emit(CartItemsUpdated(cartItems: cartItems));
  }
}
