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
//     final existingItemIndex =
//         cartItems.indexWhere((item) => item.id == labTest.id);
//     if (existingItemIndex != -1) {
//       cartItems[existingItemIndex].quantity++;
//     } else {
//       labTest.quantity = 1;
//       cartItems.add(labTest);
//     }
//     emit(CartItemsUpdated(cartItems: cartItems));
//   }

//   void removeFromCart(LabTestModel labTest) {
//     cartItems.removeWhere((item) => item.id == labTest.id);
//     emit(CartItemsUpdated(cartItems: cartItems));
//   }

//   void increaseQuantity(LabTestModel labTest) {
//     final existingItemIndex =
//         cartItems.indexWhere((item) => item.id == labTest.id);
//     if (existingItemIndex != -1) {
//       cartItems[existingItemIndex].quantity++;
//       emit(CartItemsUpdated(cartItems: cartItems));
//     }
//   }

//   void decreaseQuantity(LabTestModel labTest) {
//     final existingItemIndex =
//         cartItems.indexWhere((item) => item.id == labTest.id);
//     if (existingItemIndex != -1) {
//       if (cartItems[existingItemIndex].quantity > 1) {
//         cartItems[existingItemIndex].quantity--;
//       } else {
//         cartItems.removeAt(existingItemIndex);
//       }
//       emit(CartItemsUpdated(cartItems: cartItems));
//     }
//   }
// }

// ************************* above work

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:medical_app/features/cart/logic/cubit/cart_state.dart';
// import 'package:medical_app/features/lab-test/data/models/lab_test_model.dart';
// import 'package:medical_app/features/home/data/medicine_model.dart';

// class CartCubit extends Cubit<CartState> {
//   List<Medicine> medicineCartItems = [];
//   List<LabTestModel> labTestCartItems = [];

//   CartCubit() : super(CartInitial());

//   void loadCart() {
//     emit(CartLoading());
//     Future.delayed(const Duration(seconds: 1), () {
//       emit(CartItemsUpdated(
//           medicineCartItems: medicineCartItems,
//           labTestCartItems: labTestCartItems));
//     });
//   }

//   // Medicine related functions
//   void addToMedicineCart(Medicine medicine) {
//     final existingItemIndex =
//         medicineCartItems.indexWhere((item) => item.id == medicine.id);
//     if (existingItemIndex != -1) {
//       medicineCartItems[existingItemIndex].quantity++;
//     } else {
//       medicine.quantity = 1;
//       medicineCartItems.add(medicine);
//     }
//     emit(CartItemsUpdated(
//         medicineCartItems: medicineCartItems,
//         labTestCartItems: labTestCartItems));
//   }

//   void removeFromMedicineCart(Medicine medicine) {
//     medicineCartItems.removeWhere((item) => item.id == medicine.id);
//     emit(CartItemsUpdated(
//         medicineCartItems: medicineCartItems,
//         labTestCartItems: labTestCartItems));
//   }

//   void increaseMedicineQuantity(Medicine medicine) {
//     final existingItemIndex =
//         medicineCartItems.indexWhere((item) => item.id == medicine.id);
//     if (existingItemIndex != -1) {
//       medicineCartItems[existingItemIndex].quantity++;
//       emit(CartItemsUpdated(
//           medicineCartItems: medicineCartItems,
//           labTestCartItems: labTestCartItems));
//     }
//   }

//   void decreaseMedicineQuantity(Medicine medicine) {
//     final existingItemIndex =
//         medicineCartItems.indexWhere((item) => item.id == medicine.id);
//     if (existingItemIndex != -1) {
//       if (medicineCartItems[existingItemIndex].quantity > 1) {
//         medicineCartItems[existingItemIndex].quantity--;
//       } else {
//         medicineCartItems.removeAt(existingItemIndex);
//       }
//       emit(CartItemsUpdated(
//           medicineCartItems: medicineCartItems,
//           labTestCartItems: labTestCartItems));
//     }
//   }

//   // LabTestModel related functions
//   void addToLabTestCart(LabTestModel labTest) {
//     final existingItemIndex =
//         labTestCartItems.indexWhere((item) => item.id == labTest.id);
//     if (existingItemIndex != -1) {
//       labTestCartItems[existingItemIndex].quantity++;
//     } else {
//       labTest.quantity = 1;
//       labTestCartItems.add(labTest);
//     }
//     emit(CartItemsUpdated(
//         medicineCartItems: medicineCartItems,
//         labTestCartItems: labTestCartItems));
//   }

//   void removeFromLabTestCart(LabTestModel labTest) {
//     labTestCartItems.removeWhere((item) => item.id == labTest.id);
//     emit(CartItemsUpdated(
//         medicineCartItems: medicineCartItems,
//         labTestCartItems: labTestCartItems));
//   }

//   void increaseLabTestQuantity(LabTestModel labTest) {
//     final existingItemIndex =
//         labTestCartItems.indexWhere((item) => item.id == labTest.id);
//     if (existingItemIndex != -1) {
//       labTestCartItems[existingItemIndex].quantity++;
//       emit(CartItemsUpdated(
//           medicineCartItems: medicineCartItems,
//           labTestCartItems: labTestCartItems));
//     }
//   }

//   void decreaseLabTestQuantity(LabTestModel labTest) {
//     final existingItemIndex =
//         labTestCartItems.indexWhere((item) => item.id == labTest.id);
//     if (existingItemIndex != -1) {
//       if (labTestCartItems[existingItemIndex].quantity > 1) {
//         labTestCartItems[existingItemIndex].quantity--;
//       } else {
//         labTestCartItems.removeAt(existingItemIndex);
//       }
//       emit(CartItemsUpdated(
//           medicineCartItems: medicineCartItems,
//           labTestCartItems: labTestCartItems));
//     }
//   }
// }

//! try 1

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/features/cart/logic/cubit/cart_state.dart';
import 'package:medical_app/features/lab-test/data/models/lab_test_model.dart';
import 'package:medical_app/features/home/data/medicine_model.dart';
import 'package:medical_app/core/cache/cache_helper.dart';

class CartCubit extends Cubit<CartState> {
  List<Medicine> medicineCartItems = [];
  List<LabTestModel> labTestCartItems = [];
  final ChacheHelper _cacheHelper = ChacheHelper();

  CartCubit() : super(CartInitial());

  void loadCart() {
    emit(CartLoading());
    Future.delayed(const Duration(seconds: 1), () {
      medicineCartItems = _cacheHelper.getMedicineCartItems();
      labTestCartItems = _cacheHelper.getLabTestCartItems();
      emit(CartItemsUpdated(
          medicineCartItems: medicineCartItems,
          labTestCartItems: labTestCartItems));
    });
  }

  void _saveCartItems() {
    _cacheHelper.saveMedicineCartItems(medicineCartItems);
    _cacheHelper.saveLabTestCartItems(labTestCartItems);
  }

  //! for clear the cart items when logout
  Future<void> clearCart() async {
    medicineCartItems.clear();
    labTestCartItems.clear();
    _saveCartItems();
    emit(CartItemsUpdated(
        medicineCartItems: medicineCartItems,
        labTestCartItems: labTestCartItems));
  }

  // //! Medicine related functions (comment for the quantity undo)
  void addToMedicineCart(Medicine medicine) {
    final existingItemIndex =
        medicineCartItems.indexWhere((item) => item.id == medicine.id);
    if (existingItemIndex != -1) {
      medicineCartItems[existingItemIndex].quantity++;
    } else {
      medicine.quantity = 1;
      medicineCartItems.add(medicine);
    }
    _saveCartItems();
    emit(CartItemsUpdated(
        medicineCartItems: medicineCartItems,
        labTestCartItems: labTestCartItems));
  }

  void removeFromMedicineCart(Medicine medicine) {
    medicineCartItems.removeWhere((item) => item.id == medicine.id);
    _saveCartItems();
    emit(CartItemsUpdated(
        medicineCartItems: medicineCartItems,
        labTestCartItems: labTestCartItems));
  }

  void increaseMedicineQuantity(Medicine medicine) {
    final existingItemIndex =
        medicineCartItems.indexWhere((item) => item.id == medicine.id);
    if (existingItemIndex != -1) {
      medicineCartItems[existingItemIndex].quantity++;
      _saveCartItems();
      emit(CartItemsUpdated(
          medicineCartItems: medicineCartItems,
          labTestCartItems: labTestCartItems));
    }
  }

  void decreaseMedicineQuantity(Medicine medicine) {
    final existingItemIndex =
        medicineCartItems.indexWhere((item) => item.id == medicine.id);
    if (existingItemIndex != -1) {
      if (medicineCartItems[existingItemIndex].quantity > 1) {
        medicineCartItems[existingItemIndex].quantity--;
      } else {
        medicineCartItems.removeAt(existingItemIndex);
      }
      _saveCartItems();
      emit(CartItemsUpdated(
          medicineCartItems: medicineCartItems,
          labTestCartItems: labTestCartItems));
    }
  }

  void removeFromLabTestCart(LabTestModel labTest) {
    labTestCartItems.removeWhere((item) => item.id == labTest.id);
    _saveCartItems();
    emit(CartItemsUpdated(
        medicineCartItems: medicineCartItems,
        labTestCartItems: labTestCartItems));
  }

  void increaseLabTestQuantity(LabTestModel labTest) {
    final existingItemIndex =
        labTestCartItems.indexWhere((item) => item.id == labTest.id);
    if (existingItemIndex != -1) {
      labTestCartItems[existingItemIndex].quantity++;
      _saveCartItems();
      emit(CartItemsUpdated(
          medicineCartItems: medicineCartItems,
          labTestCartItems: labTestCartItems));
    }
  }

  void decreaseLabTestQuantity(LabTestModel labTest) {
    final existingItemIndex =
        labTestCartItems.indexWhere((item) => item.id == labTest.id);
    if (existingItemIndex != -1) {
      if (labTestCartItems[existingItemIndex].quantity > 1) {
        labTestCartItems[existingItemIndex].quantity--;
      } else {
        labTestCartItems.removeAt(existingItemIndex);
      }
      _saveCartItems();
      emit(CartItemsUpdated(
          medicineCartItems: medicineCartItems,
          labTestCartItems: labTestCartItems));
    }
  }

  //!!!!! doing changes here to undo the specific item quentity
  //* LabTestModel related functions
  // void addToLabTestCart(LabTestModel labTest) {
  //   final existingItemIndex =
  //       labTestCartItems.indexWhere((item) => item.id == labTest.id);
  //   if (existingItemIndex != -1) {
  //     labTestCartItems[existingItemIndex].quantity++;
  //   } else {
  //     labTest.quantity = 1;
  //     labTestCartItems.add(labTest);
  //   }
  //   _saveCartItems();
  //   emit(CartItemsUpdated(
  //       medicineCartItems: medicineCartItems,
  //       labTestCartItems: labTestCartItems));
  // }

  void removeSpecificLabTestQuantity(LabTestModel labTest, int quantity) {
    final existingItemIndex =
        labTestCartItems.indexWhere((item) => item.id == labTest.id);
    if (existingItemIndex != -1) {
      if (labTestCartItems[existingItemIndex].quantity > quantity) {
        labTestCartItems[existingItemIndex].quantity -= quantity;
      } else {
        labTestCartItems.removeAt(existingItemIndex);
      }
      _saveCartItems();
      emit(CartItemsUpdated(
          medicineCartItems: medicineCartItems,
          labTestCartItems: labTestCartItems));
    }
  }

  void addToLabTestCart(LabTestModel labTest) {
    final existingItemIndex =
        labTestCartItems.indexWhere((item) => item.id == labTest.id);
    if (existingItemIndex != -1) {
      labTestCartItems[existingItemIndex].quantity++;
    } else {
      labTest.quantity = 1;
      labTestCartItems.add(labTest);
    }
    _saveCartItems();
    emit(CartItemsUpdated(
        medicineCartItems: medicineCartItems,
        labTestCartItems: labTestCartItems));
  }
}
