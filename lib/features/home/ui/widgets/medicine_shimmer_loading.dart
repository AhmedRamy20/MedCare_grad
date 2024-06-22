import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class MedicineShimmerLoading extends StatelessWidget {
  const MedicineShimmerLoading({Key? key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SizedBox(
        height: 200,
        child: ListView.builder(
          itemCount: 10,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                      color: isDarkTheme ? Colors.white12 : Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Container(
                      height: 13,
                      width: 20,
                      decoration: BoxDecoration(
                        color: isDarkTheme ? Colors.white12 : Colors.white,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Container(
                          height: 13,
                          width: 170,
                          decoration: BoxDecoration(
                            color: isDarkTheme ? Colors.white12 : Colors.white,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      Container(
                        height: 13,
                        width: 65,
                        decoration: BoxDecoration(
                          color: isDarkTheme ? Colors.white12 : Colors.white,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
