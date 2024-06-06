// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:medical_app/features/cart/logic/cubit/cart_state.dart';
// import 'package:medical_app/features/lab-test/data/models/lab_test_model.dart';

// class CartCubit extends Cubit<CartState> {
//   CartCubit() : super(CartState([]));

//   void addToCart(LabTestModel labTest) {
//     final updatedCart = List<LabTestModel>.from(state.cartItems)..add(labTest);
//     emit(CartState(updatedCart));
//   }

//   void removeFromCart(LabTestModel labTest) {
//     final updatedCart = List<LabTestModel>.from(state.cartItems)
//       ..removeWhere((item) => item.id == labTest.id);
//     emit(CartState(updatedCart));
//   }
// }

//!!!!
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/features/cart/logic/cubit/cart_state.dart';
import 'package:medical_app/features/lab-test/data/models/lab_test_model.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState([]));

  void addToCart(LabTestModel labTest) {
    final updatedCart = List<LabTestModel>.from(state.cartItems);
    updatedCart.add(labTest);
    emit(CartState(updatedCart));
  }

  void removeFromCart(LabTestModel labTest) {
    final updatedCart = List<LabTestModel>.from(state.cartItems)
      ..removeWhere((item) => item.id == labTest.id);
    emit(CartState(updatedCart));
  }
}
