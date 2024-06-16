import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        title: const Text("Medicine details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
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
                  child: Image.network(
                    widget.medicine.pictureUrl,
                    fit: BoxFit.cover,
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
                    color:
                        isDarkTheme ? Colors.grey[800] : Colors.lightBlue[100],
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
                            ? TextStyle(color: Colors.white, fontSize: 24.sp)
                            : TextStyle(color: Colors.black, fontSize: 24.sp),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        widget.medicine.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: isDarkTheme
                            ? TextStyle(color: Colors.white70, fontSize: 16.sp)
                            : TextStyle(color: Colors.black87, fontSize: 16.sp),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Icon(Icons.attach_money,
                              color: Colors.green, size: 20),
                          Text(
                            '${widget.medicine.price.toStringAsFixed(2)}',
                            style:
                                TextStyle(color: Colors.green, fontSize: 20.sp),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Text(
                            "Quantity",
                            style: TextStyle(
                              color:
                                  isDarkTheme ? Colors.white : Colors.black87,
                              fontSize: 16.sp,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (quantity > 1) quantity--;
                              });
                            },
                            icon: Icon(Icons.remove, color: Colors.white),
                            color: Colors.blue,
                            constraints: BoxConstraints(
                              minWidth: 32,
                              minHeight: 32,
                            ),
                            padding: EdgeInsets.zero,
                            iconSize: 18,
                          ),
                          Container(
                            width: 24,
                            height: 24,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              '$quantity',
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                            icon: Icon(Icons.add, color: Colors.white),
                            color: Colors.blue,
                            constraints: BoxConstraints(
                              minWidth: 32,
                              minHeight: 32,
                            ),
                            padding: EdgeInsets.zero,
                            iconSize: 18,
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
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
                              widget.medicine.quantity = quantity;
                              BlocProvider.of<CartCubit>(context)
                                  .addToMedicineCart(widget.medicine);
                            },
                            child: Text(
                              'Add Cart',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
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
