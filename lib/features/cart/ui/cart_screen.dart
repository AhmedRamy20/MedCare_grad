//************************************************************************************************* */

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:cached_network_image/cached_network_image.dart';
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
//             _cartItems = state.cartItems; // Store cart items locally
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
//                                     Text(
//                                       labTest.name,
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                       style: const TextStyle(
//                                         color: Colors.black,
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 4.0),
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
//                                     //! Price
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
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               IconButton(
//                                   onPressed: () {
//                                     context
//                                         .read<CartCubit>()
//                                         .removeFromCart(labTest);
//                                   },
//                                   icon: Icon(
//                                     Icons.delete,
//                                   )),
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
//                           0.0,
//                           (previousValue, element) =>
//                               previousValue + element.price);

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

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:medical_app/core/helpers/spacing.dart';
import 'package:medical_app/core/routing/routes.dart';
import 'package:medical_app/core/theming/colors.dart';
import 'package:medical_app/features/cart/logic/cubit/cart_cubit.dart';
import 'package:medical_app/features/cart/logic/cubit/cart_state.dart';
import 'package:medical_app/features/lab-test/data/models/lab_test_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<LabTestModel> _cartItems = [];

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
            _cartItems = state.cartItems;
            if (_cartItems.isEmpty) {
              return const Center(child: Text('No items in the cart.'));
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _cartItems.length,
                    itemBuilder: (context, index) {
                      final labTest = _cartItems[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 10, right: 10, left: 10),
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
                            children: [
                              // Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: CachedNetworkImage(
                                  imageUrl: labTest.imageUrl,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(
                                    color: ColorsProvider.primaryBink,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  height: 80,
                                  width: 80,
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //! Name
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          labTest.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            context
                                                .read<CartCubit>()
                                                .removeFromCart(labTest);
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: ColorsProvider.primaryBink,
                                          ),
                                        ),
                                      ],
                                    ),
                                    // const SizedBox(height: 4.0),
                                    //! Description
                                    Text(
                                      labTest.description,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    //! Price and Quantity
                                    Row(
                                      children: [
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              const TextSpan(
                                                text: '\$ ',
                                                style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    '${labTest.price.toStringAsFixed(2)}',
                                                style: const TextStyle(
                                                  color: ColorsProvider
                                                      .greeting2Color,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // const SizedBox(width: 7.0),

                                        horizontalSpace(25),

                                        //! Quantity
                                        Row(
                                          // mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.remove),
                                              onPressed: () {
                                                context
                                                    .read<CartCubit>()
                                                    .decreaseQuantity(labTest);
                                              },
                                            ),
                                            Text('${labTest.quantity}'),
                                            IconButton(
                                              icon: const Icon(Icons.add),
                                              onPressed: () {
                                                context
                                                    .read<CartCubit>()
                                                    .increaseQuantity(labTest);
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Calculate total price
                      double totalPrice = _cartItems.fold<double>(
                        0.0,
                        (previousValue, element) =>
                            previousValue + (element.price * element.quantity),
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
}
