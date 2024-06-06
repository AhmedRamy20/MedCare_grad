import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_app/core/helpers/spacing.dart';
import 'package:shimmer/shimmer.dart';

class HomePageShimmer extends StatelessWidget {
  const HomePageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    // bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      // loop: 3,
      // period: const Duration(milliseconds: 500),
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListView.builder(
        itemCount: 10,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Center(
                  child: Container(
                    height: 268,
                    width: 300,
                    decoration: BoxDecoration(
                      color: isDarkTheme ? Colors.white12 : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 12.h,
                        bottom: 12,
                      ),
                      child: Container(
                        height: 13,
                        width: 100,
                        decoration: BoxDecoration(
                          color: isDarkTheme ? Colors.white12 : Colors.white,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    // verticalSpace(5),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Container(
                        height: 38,
                        width: 280,
                        decoration: BoxDecoration(
                          color: isDarkTheme ? Colors.white12 : Colors.white,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                    verticalSpace(5),
                    Container(
                      height: 15,
                      width: 88,
                      decoration: BoxDecoration(
                        color: isDarkTheme ? Colors.white12 : Colors.white,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    verticalSpace(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Lab info
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: isDarkTheme ? Colors.white12 : Colors.white,
                          ),
                          height: 50,
                          width: 50,
                        ),
                        Container(
                          height: 49,
                          width: 142,
                          decoration: BoxDecoration(
                            color: isDarkTheme ? Colors.white12 : Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ],
                    ),

                    verticalSpace(5),
                  ],
                ),
              ),
              const Divider(
                color: Color.fromARGB(255, 220, 219, 219),
              ),
            ],
          );
        },
      ),
    );
  }
}
