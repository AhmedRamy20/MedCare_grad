import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_app/core/helpers/spacing.dart';
import 'package:medical_app/core/theming/colors.dart';
import 'package:medical_app/core/theming/styles.dart';
import 'package:medical_app/features/lab-test/data/models/lab_test_model.dart';

class LabDetailScreen extends StatefulWidget {
  const LabDetailScreen({super.key, required this.lab});

  final Lab lab;
  @override
  State<LabDetailScreen> createState() => _LabDetailScreenState();
}

class _LabDetailScreenState extends State<LabDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.lab.name} Lab'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image.network(
              //   widget.lab.pictureUrl,
              //   height: 268.h,
              //   // width: 341.w,
              //   fit: BoxFit.cover,
              // ),
              Center(
                child: Container(
                  height: 268.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    // ClipRRect to round the corners of the image
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      widget.lab.pictureUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              verticalSpace(10.h),
              const Center(
                child: Text(
                  "You can contact us with these info hope you get well soon...",
                  textAlign: TextAlign.center,
                ),
              ),
              verticalSpace(25.h),
              // Text(
              //   'Email: ${widget.lab.email}',
              //   style: TextStyles.font16GreyBold,
              // ),
              // RichText(
              //   text: TextSpan(
              //     children: [
              //       TextSpan(
              //         text: 'Email: ',
              //         style: TextStyles.font16GreyBold,
              //       ),
              //       TextSpan(
              //         text: widget.lab.email,
              //         style: const TextStyle(
              //           color: ColorsProvider.gold,
              //           fontWeight: FontWeight.bold,
              //           fontSize: 18,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              ListTile(
                leading: const Icon(Icons.email, color: ColorsProvider.gold),
                title: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Email: ',
                        style: TextStyles.font16GreyBold,
                      ),
                      TextSpan(
                        text: widget.lab.email,
                        style: const TextStyle(
                          color: ColorsProvider.gold,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              verticalSpace(8.h),

              ListTile(
                leading: const Icon(Icons.phone, color: ColorsProvider.gold),
                title: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Phone: ',
                        style: TextStyles.font16GreyBold,
                      ),
                      TextSpan(
                        text: widget.lab.phone,
                        style: const TextStyle(
                          color: ColorsProvider.gold,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              verticalSpace(8.h),

              ListTile(
                leading:
                    const Icon(Icons.location_on, color: ColorsProvider.gold),
                title: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Location: ',
                        style: TextStyles.font16GreyBold,
                      ),
                      TextSpan(
                        text: widget.lab.location,
                        style: const TextStyle(
                          color: ColorsProvider.gold,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
