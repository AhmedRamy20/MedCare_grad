// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:medical_app/features/cart/logic/cubit/cart_cubit.dart';
// import 'package:medical_app/features/cart/logic/cubit/cart_state.dart';

// class CartScreen extends StatelessWidget {
//   const CartScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Cart'),
//       ),
//       body: BlocBuilder<CartCubit, CartState>(
//         builder: (context, state) {
//           print("Cart State: $state");
//           if (state.cartItems.isEmpty) {
//             return const Center(child: Text('No items in cart'));
//           } else {
//             return ListView.builder(
//               itemCount: state.cartItems.length,
//               itemBuilder: (context, index) {
//                 final labTest = state.cartItems[index];
//                 return ListTile(
//                   title: Text(labTest.name),
//                   subtitle: Text(labTest.description),
//                   leading: Container(
//                     width: 50,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       image: DecorationImage(
//                         image: NetworkImage(
//                           labTest.imageUrl ??
//                               'https://www.google.com/imgres?q=image%20not%20found&imgurl=https%3A%2F%2Fih1.redbubble.net%2Fimage.1893341687.8294%2Ffposter%2Csmall%2Cwall_texture%2Cproduct%2C750x1000.jpg&imgrefurl=https%3A%2F%2Fwww.redbubble.com%2Fi%2Fposter%2FImage-Not-Found-Black-by-MarcGodsiff%2F63888294.LVTDI&docid=2-GVFr3a24kppM&tbnid=J-SEUou7K5gClM&vet=12ahUKEwiktenus8CGAxW-_rsIHWFzDX0QM3oECBQQAA..i&w=750&h=1000&hcb=2&ved=2ahUKEwiktenus8CGAxW-_rsIHWFzDX0QM3oECBQQAA',
//                         ),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.remove_shopping_cart),
//                     onPressed: () {
//                       context.read<CartCubit>().removeFromCart(labTest);
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('${labTest.name} removed from cart'),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
//********************** */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
        title: const Text('Cart'),
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
            _cartItems = state.cartItems; // Store cart items locally
            if (_cartItems.isEmpty) {
              return const Center(child: Text('No items in the cart.'));
            }

            return ListView.builder(
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                final labTest = _cartItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Dismissible(
                    key: Key(labTest.id.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20.0),
                      color: Colors.red,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (direction) {
                      context.read<CartCubit>().removeFromCart(labTest);
                    },
                    child: Row(
                      children: [
                        // Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: CachedNetworkImage(
                            imageUrl: labTest.imageUrl,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
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
                              const SizedBox(height: 4.0),
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
                              //! Price
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
                                            color:
                                                ColorsProvider.greeting2Color,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
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
            );
          } else if (state is CartError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Calculate total price
          double totalPrice = _cartItems.fold<double>(
              0.0, (previousValue, element) => previousValue + element.price);

          Navigator.of(context).pushNamed(
            Routes.paymentCheckout,
            arguments: {'totalPrice': totalPrice},
          );
        },
        label: const Text(
          'Checkout',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        icon: const Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
        backgroundColor: ColorsProvider.primaryBink,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
