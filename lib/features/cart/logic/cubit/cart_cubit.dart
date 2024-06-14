// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:medical_app/features/cart/logic/cubit/cart_state.dart';
// import 'package:medical_app/features/lab-test/data/models/lab_test_model.dart';

// class CartCubit extends Cubit<CartState> {
//   List<LabTestModel> cartItems = [];

//   CartCubit() : super(CartInitial());

//   void loadCart() {
//     emit(CartLoading());
//     Future.delayed(const Duration(seconds: 1), () {
//       emit(CartItemsUpdated(cartItems: cartItems));
//     });
//   }

//   void addToCart(LabTestModel labTest) {
//     cartItems.add(labTest);
//     emit(CartItemsUpdated(cartItems: cartItems));
//   }

//   void removeFromCart(LabTestModel labTest) {
//     cartItems.remove(labTest);
//     emit(CartItemsUpdated(cartItems: cartItems));
//   }
// }

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

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
    final existingItemIndex =
        cartItems.indexWhere((item) => item.id == labTest.id);
    if (existingItemIndex != -1) {
      cartItems[existingItemIndex].quantity++;
    } else {
      labTest.quantity = 1;
      cartItems.add(labTest);
    }
    emit(CartItemsUpdated(cartItems: cartItems));
  }

  void removeFromCart(LabTestModel labTest) {
    cartItems.removeWhere((item) => item.id == labTest.id);
    emit(CartItemsUpdated(cartItems: cartItems));
  }

  void increaseQuantity(LabTestModel labTest) {
    final existingItemIndex =
        cartItems.indexWhere((item) => item.id == labTest.id);
    if (existingItemIndex != -1) {
      cartItems[existingItemIndex].quantity++;
      emit(CartItemsUpdated(cartItems: cartItems));
    }
  }

  void decreaseQuantity(LabTestModel labTest) {
    final existingItemIndex =
        cartItems.indexWhere((item) => item.id == labTest.id);
    if (existingItemIndex != -1) {
      if (cartItems[existingItemIndex].quantity > 1) {
        cartItems[existingItemIndex].quantity--;
      } else {
        cartItems.removeAt(existingItemIndex);
      }
      emit(CartItemsUpdated(cartItems: cartItems));
    }
  }
}
