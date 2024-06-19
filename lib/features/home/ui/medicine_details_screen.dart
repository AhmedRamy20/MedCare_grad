import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_app/core/theming/colors.dart';
import 'package:medical_app/features/cart/logic/cubit/cart_cubit.dart';
import 'package:medical_app/features/home/data/medicine_model.dart';

class MedicineDetailsScreen extends StatefulWidget {
  final Medicine medicine;

  const MedicineDetailsScreen({Key? key, required this.medicine})
      : super(key: key);

  @override
  State<MedicineDetailsScreen> createState() => _MedicineDetailsScreenState();
}

class _MedicineDetailsScreenState extends State<MedicineDetailsScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.medicine.name} details",
          style: TextStyle(
            color: isDarkTheme ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 5,
          right: 5,
          left: 5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 200.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Hero(
                    // tag: widget.medicine.id,
                    tag: widget.medicine.id,
                    child: AspectRatio(
                      aspectRatio: 2.0,
                      child: Image.network(
                        widget.medicine.pictureUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDarkTheme
                        ? const Color.fromARGB(255, 118, 151, 166)
                        : Colors.lightBlue[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.medicine.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: isDarkTheme
                            ? TextStyle(
                                color: Colors.white,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.bold,
                              )
                            : TextStyle(
                                color: Colors.white,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.bold,
                              ),
                      ),
                      SizedBox(height: 10.h),
                      // Row(
                      //   children: [
                      //     Text(
                      //       "Description: ",
                      //       style: TextStyle(
                      //         color: ColorsProvider.primaryBink,
                      //         fontSize: 17,
                      //       ),
                      //     ),
                      //     Text(
                      //       "widget.medicine.description",
                      //       maxLines: 3,
                      //       overflow: TextOverflow.ellipsis,
                      //       style: isDarkTheme
                      //           ? TextStyle(
                      //               color: Colors.white70, fontSize: 16.sp)
                      //           : TextStyle(
                      //               color: Colors.black87, fontSize: 16.sp),
                      //     ),
                      //   ],
                      // ),
                      //!!
                      // Text(
                      //   "Description: ${widget.medicine.description}",
                      //   maxLines: 3,
                      //   overflow: TextOverflow.ellipsis,
                      //   style: isDarkTheme
                      //       ? TextStyle(color: Colors.white70, fontSize: 16.sp)
                      //       : TextStyle(color: Colors.black87, fontSize: 16.sp),
                      // ),

                      RichText(
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          style: isDarkTheme
                              ? TextStyle(
                                  color: Colors.white70, fontSize: 16.sp)
                              : TextStyle(
                                  color: Colors.black87, fontSize: 16.sp),
                          children: [
                            TextSpan(
                              text: "Description: ",
                              style: TextStyle(
                                  color: isDarkTheme
                                      ? Colors.white
                                      : ColorsProvider
                                          .rusasy, //ColorsProvider.rusasy
                                  fontSize: 18.sp),
                            ),
                            TextSpan(
                              text: "${widget.medicine.description}",
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 16.sp),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 10.h),
                      RichText(
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          style: isDarkTheme
                              ? TextStyle(
                                  color: Colors.white70, fontSize: 16.sp)
                              : TextStyle(
                                  color: Colors.black87, fontSize: 16.sp),
                          children: [
                            TextSpan(
                              text: "SideEffects: ",
                              style: TextStyle(
                                  color: isDarkTheme
                                      ? Colors.white
                                      : ColorsProvider.rusasy,
                                  fontSize: 18.sp),
                            ),
                            TextSpan(
                              text: "${widget.medicine.sideEffects}",
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 16.sp),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      // Row(
                      //   children: [
                      // Icon(Icons.attach_money,
                      //     color: Colors.green, size: 20),
                      // Text(
                      //   '${widget.medicine.price.toStringAsFixed(2)}',
                      //   style:
                      //       TextStyle(color: Colors.green, fontSize: 20.sp),
                      // ),
                      //   ],
                      // ),
                      RichText(
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          style: isDarkTheme
                              ? TextStyle(
                                  color: Colors.white70, fontSize: 16.sp)
                              : TextStyle(
                                  color: Colors.black87, fontSize: 16.sp),
                          children: [
                            TextSpan(
                              text: "Price: ",
                              style: TextStyle(
                                  color: isDarkTheme
                                      ? Colors.white
                                      : ColorsProvider.rusasy,
                                  fontSize: 18.sp),
                            ),
                            TextSpan(
                              text:
                                  "${widget.medicine.price.toStringAsFixed(2)} ",
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 16.sp),
                            ),
                            TextSpan(
                              text: "\$",
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 0, 255, 8),
                                  fontSize: 18.sp),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      // Row(
                      //   children: [
                      //     Text(
                      //       "Quantity",
                      //       style: TextStyle(
                      //         color: isDarkTheme
                      //             ? Colors.white
                      //             : ColorsProvider.rusasy,
                      //         fontSize: 17.sp,
                      //       ),
                      //     ),
                      //     Spacer(),
                      //     IconButton(
                      //       onPressed: () {
                      //         setState(() {
                      //           if (quantity > 1) quantity--;
                      //         });
                      //       },
                      //       icon: Icon(Icons.remove, color: Colors.white),
                      //       color: Colors.blue,
                      //       constraints: BoxConstraints(
                      //         minWidth: 32,
                      //         minHeight: 32,
                      //       ),
                      //       padding: EdgeInsets.zero,
                      //       iconSize: 18,
                      //     ),
                      //     Container(
                      //       width: 24,
                      //       height: 24,
                      //       alignment: Alignment.center,
                      //       decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         borderRadius: BorderRadius.circular(5),
                      //       ),
                      //       child: Text(
                      //         '$quantity',
                      //         style: TextStyle(fontSize: 16.sp),
                      //       ),
                      //     ),
                      //     IconButton(
                      //       onPressed: () {
                      //         setState(() {
                      //           quantity++;
                      //         });
                      //       },
                      //       icon: Icon(Icons.add, color: Colors.white),
                      //       color: Colors.blue,
                      //       constraints: BoxConstraints(
                      //         minWidth: 32,
                      //         minHeight: 32,
                      //       ),
                      //       padding: EdgeInsets.zero,
                      //       iconSize: 18,
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: 20.h),
                      // Expanded(
                      //   child: Center(
                      //     child: ElevatedButton(
                      //       style: ElevatedButton.styleFrom(
                      //         primary: Colors.blue,
                      //         padding: EdgeInsets.symmetric(
                      //             horizontal: 32, vertical: 12),
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(10),
                      //         ),
                      //       ),
                      //       onPressed: () {
                      //         int quantityAdded = widget.medicine.quantity;
                      //         BlocProvider.of<CartCubit>(context)
                      //             .addToMedicineCart(widget.medicine);

                      //         ScaffoldMessenger.of(context).showSnackBar(
                      //           SnackBar(
                      //             content: Text(
                      //                 '${widget.medicine.name} added to cart'),
                      //             duration: Duration(seconds: 2),
                      //             action: SnackBarAction(
                      //               label: 'Undo',
                      //               onPressed: () {
                      //                 BlocProvider.of<CartCubit>(context)
                      //                     .removeSpecificMedicineQuantity(
                      //                         widget.medicine, quantityAdded);
                      //               },
                      //             ),
                      //           ),
                      //         );
                      //       },
                      //       child: Text(
                      //         'Add Cart',
                      //         style: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 18.sp,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Expanded(
                        child: Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              int quantityAdded = widget.medicine.quantity;

                              BlocProvider.of<CartCubit>(context)
                                  .addToMedicineCart(widget.medicine);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      '${widget.medicine.name} added to cart'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            },
                            // child: Text(
                            //   'Add to Cart',
                            //   style: TextStyle(
                            //     color: Colors.white,
                            //     fontSize: 18,
                            //   ),
                            // ),
                            child: const SizedBox(
                              width: 120,
                              height: 30,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Add to Cart',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Icon(
                                    Icons.shopping_cart,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
