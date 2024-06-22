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
