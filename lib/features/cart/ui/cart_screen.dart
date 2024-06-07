import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/features/cart/logic/cubit/cart_cubit.dart';
import 'package:medical_app/features/cart/logic/cubit/cart_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          print("Cart State: $state");
          if (state.cartItems.isEmpty) {
            return const Center(child: Text('No items in cart'));
          } else {
            return ListView.builder(
              itemCount: state.cartItems.length,
              itemBuilder: (context, index) {
                final labTest = state.cartItems[index];
                return ListTile(
                  title: Text(labTest.name),
                  subtitle: Text(labTest.description),
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          labTest.imageUrl ??
                              'https://www.google.com/imgres?q=image%20not%20found&imgurl=https%3A%2F%2Fih1.redbubble.net%2Fimage.1893341687.8294%2Ffposter%2Csmall%2Cwall_texture%2Cproduct%2C750x1000.jpg&imgrefurl=https%3A%2F%2Fwww.redbubble.com%2Fi%2Fposter%2FImage-Not-Found-Black-by-MarcGodsiff%2F63888294.LVTDI&docid=2-GVFr3a24kppM&tbnid=J-SEUou7K5gClM&vet=12ahUKEwiktenus8CGAxW-_rsIHWFzDX0QM3oECBQQAA..i&w=750&h=1000&hcb=2&ved=2ahUKEwiktenus8CGAxW-_rsIHWFzDX0QM3oECBQQAA',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_shopping_cart),
                    onPressed: () {
                      context.read<CartCubit>().removeFromCart(labTest);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${labTest.name} removed from cart'),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
