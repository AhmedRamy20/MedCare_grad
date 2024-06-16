// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:medical_app/core/helpers/spacing.dart';
// import 'package:medical_app/core/routing/routes.dart';
// import 'package:medical_app/core/theming/colors.dart';
// import 'package:medical_app/features/cart/logic/cubit/cart_cubit.dart';
// import 'package:medical_app/features/cart/logic/cubit/cart_state.dart';
// import 'package:medical_app/features/lab-test/data/models/lab_test_model.dart';

// class CartScreen extends StatefulWidget {
//   const CartScreen({Key? key}) : super(key: key);

//   @override
//   _CartScreenState createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   List<LabTestModel> _cartItems = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Cart'),
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//       ),
//       body: BlocBuilder<CartCubit, CartState>(
//         builder: (context, state) {
//           if (state is CartInitial) {
//             context.read<CartCubit>().loadCart();
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is CartLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is CartItemsUpdated) {
//             _cartItems = state.cartItems;
//             if (_cartItems.isEmpty) {
//               return const Center(child: Text('No items in the cart.'));
//             }

//             return Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: _cartItems.length,
//                     itemBuilder: (context, index) {
//                       final labTest = _cartItems[index];
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16.0, vertical: 8.0),
//                         child: Container(
//                           padding: const EdgeInsets.only(
//                               top: 10, right: 10, left: 10),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(8.0),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.1),
//                                 spreadRadius: 2,
//                                 blurRadius: 5,
//                                 offset: Offset(0, 3),
//                               ),
//                             ],
//                           ),
//                           child: Row(
//                             children: [
//                               // Image
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(8.0),
//                                 child: CachedNetworkImage(
//                                   imageUrl: labTest.imageUrl,
//                                   placeholder: (context, url) =>
//                                       const CircularProgressIndicator(
//                                     color: ColorsProvider.primaryBink,
//                                   ),
//                                   errorWidget: (context, url, error) =>
//                                       const Icon(Icons.error),
//                                   height: 80,
//                                   width: 80,
//                                 ),
//                               ),
//                               const SizedBox(width: 16.0),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     //! Name
// Row(
//   mainAxisAlignment:
//       MainAxisAlignment.spaceBetween,
//   children: [
//     Text(
//       labTest.name,
//       maxLines: 1,
//       overflow: TextOverflow.ellipsis,
//       style: const TextStyle(
//         color: Colors.black,
//         fontSize: 16,
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//     IconButton(
//       onPressed: () {
//         context
//             .read<CartCubit>()
//             .removeFromCart(labTest);
//       },
//       icon: const Icon(
//         Icons.delete,
//         color: ColorsProvider.primaryBink,
//       ),
//     ),
//   ],
// ),
//                                     // const SizedBox(height: 4.0),
//                                     //! Description
//                                     Text(
//                                       labTest.description,
//                                       maxLines: 2,
//                                       overflow: TextOverflow.ellipsis,
//                                       style: const TextStyle(
//                                         color: Colors.black54,
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 4.0),
//                                     //! Price and Quantity
//                                     Row(
//                                       children: [
//                                         Text.rich(
//                                           TextSpan(
//                                             children: [
//                                               const TextSpan(
//                                                 text: '\$ ',
//                                                 style: TextStyle(
//                                                   color: Colors.green,
//                                                   fontSize: 16,
//                                                 ),
//                                               ),
//                                               TextSpan(
//                                                 text:
//                                                     '${labTest.price.toStringAsFixed(2)}',
//                                                 style: const TextStyle(
//                                                   color: ColorsProvider
//                                                       .greeting2Color,
//                                                   fontSize: 16,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         // const SizedBox(width: 7.0),

//                                         horizontalSpace(25),

//                                         //! Quantity
//                                         Row(
//                                           // mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             IconButton(
//                                               icon: const Icon(Icons.remove),
//                                               onPressed: () {
//                                                 context
//                                                     .read<CartCubit>()
//                                                     .decreaseQuantity(labTest);
//                                               },
//                                             ),
//                                             Text('${labTest.quantity}'),
//                                             IconButton(
//                                               icon: const Icon(Icons.add),
//                                               onPressed: () {
//                                                 context
//                                                     .read<CartCubit>()
//                                                     .increaseQuantity(labTest);
//                                               },
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Calculate total price
//                       double totalPrice = _cartItems.fold<double>(
//                         0.0,
//                         (previousValue, element) =>
//                             previousValue + (element.price * element.quantity),
//                       );

//                       Navigator.of(context).pushNamed(
//                         Routes.paymentCheckout,
//                         arguments: {'totalPrice': totalPrice},
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: ColorsProvider.primaryBink,
//                       foregroundColor: Colors.white,
//                       minimumSize: const Size.fromHeight(50),
//                     ),
//                     child: const Text(
//                       'Checkout',
//                       style: TextStyle(
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           } else if (state is CartError) {
//             return Center(child: Text(state.message));
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }

//******************************************************* */
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/core/helpers/spacing.dart';
import 'package:medical_app/core/routing/routes.dart';
import 'package:medical_app/core/theming/colors.dart';
import 'package:medical_app/features/cart/logic/cubit/cart_cubit.dart';
import 'package:medical_app/features/cart/logic/cubit/cart_state.dart';
import 'package:medical_app/features/home/data/medicine_model.dart';
import 'package:medical_app/features/lab-test/data/models/lab_test_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Medicine> _medicineCartItems = [];
  List<LabTestModel> _labTestCartItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartInitial) {
            context.read<CartCubit>().loadCart();
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartItemsUpdated) {
            _medicineCartItems = state.medicineCartItems;
            _labTestCartItems = state.labTestCartItems;
            if (_medicineCartItems.isEmpty && _labTestCartItems.isEmpty) {
              return const Center(child: Text('No items in the cart.'));
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount:
                        _medicineCartItems.length + _labTestCartItems.length,
                    itemBuilder: (context, index) {
                      if (index < _medicineCartItems.length) {
                        final medicine = _medicineCartItems[index];
                        return buildMedicineItem(context, medicine);
                      } else {
                        final labTest = _labTestCartItems[
                            index - _medicineCartItems.length];
                        return buildLabTestItem(context, labTest);
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Calculate total price
                      double totalPrice = _medicineCartItems.fold<double>(
                            0.0,
                            (previousValue, element) =>
                                previousValue +
                                (element.price * element.quantity),
                          ) +
                          _labTestCartItems.fold<double>(
                            0.0,
                            (previousValue, element) =>
                                previousValue +
                                (element.price * element.quantity),
                          );

                      Navigator.of(context).pushNamed(
                        Routes.paymentCheckout,
                        arguments: {'totalPrice': totalPrice},
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsProvider.primaryBink,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(50),
                    ),
                    child: const Text(
                      'Checkout',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is CartError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget buildMedicineItem(BuildContext context, Medicine medicine) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(
            //   width: 80.0,
            //   child: Image.network(
            //     medicine.pictureUrl,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            Center(
              child: SizedBox(
                width: 80.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    medicine.pictureUrl,
                    fit: BoxFit.cover,
                    width: 80.0,
                    height: 90.0,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            medicine.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            context
                                .read<CartCubit>()
                                .removeFromMedicineCart(medicine);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: ColorsProvider.primaryBink,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Price: \$${medicine.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black54,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            context
                                .read<CartCubit>()
                                .decreaseMedicineQuantity(medicine);
                          },
                        ),
                        Text(
                          '${medicine.quantity}',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            context
                                .read<CartCubit>()
                                .increaseMedicineQuantity(medicine);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLabTestItem(BuildContext context, LabTestModel labTest) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: isDarkTheme ? Colors.grey.shade300 : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(
            //   width: 80.0,
            //   child: Image.network(
            //     medicine.pictureUrl,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            Center(
              child: SizedBox(
                width: 80.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    labTest.imageUrl,
                    fit: BoxFit.cover,
                    width: 80.0,
                    height: 90.0,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            labTest.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            context
                                .read<CartCubit>()
                                .removeFromLabTestCart(labTest);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: ColorsProvider.primaryBink,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Price: \$${labTest.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black54,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.remove,
                            color: ColorsProvider.primaryBink,
                          ),
                          onPressed: () {
                            context
                                .read<CartCubit>()
                                .decreaseLabTestQuantity(labTest);
                          },
                        ),
                        Text(
                          '${labTest.quantity}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.add,
                            color: ColorsProvider.primaryBink,
                          ),
                          onPressed: () {
                            context
                                .read<CartCubit>()
                                .increaseLabTestQuantity(labTest);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    // return Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    //   child: Container(
    //     decoration: BoxDecoration(
    //       color: Colors.white,
    //       borderRadius: BorderRadius.circular(8.0),
    //       boxShadow: [
    //         BoxShadow(
    //           color: Colors.black.withOpacity(0.1),
    //           spreadRadius: 2,
    //           blurRadius: 5,
    //           offset: Offset(0, 3),
    //         ),
    //       ],
    //     ),
    //     child: ListTile(
    //       contentPadding:
    //           EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    //       leading: SizedBox(
    //         width: 80.0,
    //         child: Image.network(
    //           labTest.imageUrl,
    //           fit: BoxFit.cover,
    //         ),
    //       ),
    //       title: Text(
    //         labTest.name,
    //         style: TextStyle(
    //           fontWeight: FontWeight.bold,
    //           fontSize: 16.0,
    //         ),
    //       ),
    //       subtitle: Text(
    //         'Price: \$${labTest.price.toStringAsFixed(2)}', //${labTest.quantity} x \$
    //         style: TextStyle(
    //           fontSize: 14.0,
    //           color: Colors.black54,
    //         ),
    //       ),
    //       trailing: Row(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           IconButton(
    //             icon: const Icon(Icons.remove),
    //             onPressed: () {
    //               context.read<CartCubit>().decreaseLabTestQuantity(labTest);
    //             },
    //           ),
    //           Text(
    //             '${labTest.quantity}',
    //             style: TextStyle(
    //               fontSize: 16.0,
    //             ),
    //           ),
    //           IconButton(
    //             icon: const Icon(Icons.add),
    //             onPressed: () {
    //               context.read<CartCubit>().increaseLabTestQuantity(labTest);
    //             },
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    // return ListTile(
    //   leading: CircleAvatar(
    //     backgroundImage: NetworkImage(labTest.imageUrl),
    //   ),
    //   title: Text(labTest.name),
    //   subtitle:
    //       Text('${labTest.quantity} x \$${labTest.price.toStringAsFixed(2)}'),
    //   trailing: Row(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       IconButton(
    //         icon: const Icon(Icons.remove),
    //         onPressed: () {
    //           context.read<CartCubit>().decreaseLabTestQuantity(labTest);
    //         },
    //       ),
    //       Text('${labTest.quantity}'),
    //       IconButton(
    //         icon: const Icon(Icons.add),
    //         onPressed: () {
    //           context.read<CartCubit>().increaseLabTestQuantity(labTest);
    //         },
    //       ),
    //     ],
    //   ),
    // );
  }
}
