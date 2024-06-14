// import 'package:flutter/material.dart';
// import 'package:medical_app/core/components/styles.dart';
// import 'package:medical_app/core/theming/colors.dart';
// import 'package:medical_app/features/checkout/presentation/views/widget/card_info_widget.dart';
// import 'package:medical_app/features/checkout/presentation/views/widget/payment_info_item.dart';
// import 'package:medical_app/features/checkout/presentation/views/widget/total_price_widget.dart';

// class ThankYouCard extends StatelessWidget {
//   const ThankYouCard({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: ShapeDecoration(
//         color: const Color(0xFFEDEDED),  //const Color(0xFFEDEDED)
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.only(top: 40 + 16, left: 22, right: 22),
//         child: Column(
//           children: [
//             const Text(
//               'Thank you!',
//               textAlign: TextAlign.center,
//               style: Styles.style25,
//             ),
//             Text(
//               'Your transaction was successful',
//               textAlign: TextAlign.center,
//               style: Styles.style20,
//             ),
//             const SizedBox(
//               height: 24, //32
//             ),
//             const PaymentItemInfo(
//               title: 'Date',
//               value: '01/24/2023',
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const PaymentItemInfo(
//               title: 'Time',
//               value: '10:15 AM',
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const PaymentItemInfo(
//               title: 'To',
//               value: 'Sam Louis',
//             ),
//             const Divider(
//               height: 60,
//               thickness: 2,
//             ),
//             const TotalPrice(title: 'Total', value: r'$50.97'),
//             const SizedBox(
//               height: 10,
//             ),
//             const CardInfoWidget(),
//             const Spacer(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Icon(
//                   Icons.payment, //! This was fontawsome.barcode
//                   size: 64,
//                 ),
//                 Container(
//                   width: 113,
//                   height: 58,
//                   decoration: ShapeDecoration(
//                     shape: RoundedRectangleBorder(
//                       side: const BorderSide(
//                           width: 1.50, color: ColorsProvider.primaryBink,), //Color(0xFF34A853)
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                   child: Center(
//                     child: Text(
//                       'PAID',
//                       textAlign: TextAlign.center,
//                       style: Styles.style24
//                           .copyWith(color: ColorsProvider.primaryBink),  //const Color(0xff34A853)
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             //!!!! Sizedbox
//             // SizedBox(
//             //   height: ((MediaQuery.sizeOf(context).height * .2 + 20) / 2) - 29,
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

import 'package:flutter/material.dart';
import 'package:medical_app/core/components/styles.dart';
import 'package:medical_app/core/helpers/extensions.dart';
import 'package:medical_app/core/routing/routes.dart';
import 'package:medical_app/features/checkout/presentation/views/widget/card_info_widget.dart';
import 'package:medical_app/features/checkout/presentation/views/widget/payment_info_item.dart';
import 'package:medical_app/features/checkout/presentation/views/widget/total_price_widget.dart';

class ThankYouCard extends StatelessWidget {
  const ThankYouCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFEDEDED),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40 + 16, horizontal: 22),
        child: Column(
          children: [
            const Text(
              'Thank you!',
              textAlign: TextAlign.center,
              style: Styles.style25,
            ),
            Text(
              'Your transaction was successful',
              textAlign: TextAlign.center,
              style: Styles.style20,
            ),
            const SizedBox(height: 24),
            const PaymentItemInfo(
              title: 'Date',
              value: '01/24/2023',
            ),
            const SizedBox(height: 10),
            const PaymentItemInfo(
              title: 'Time',
              value: '10:15 AM',
            ),
            const SizedBox(height: 10),
            const PaymentItemInfo(
              title: 'To',
              value: 'Sam Louis',
            ),
            const Divider(
              height: 60,
              thickness: 2,
            ),
            const TotalPrice(title: 'Total', value: r'$50.97'),
            const SizedBox(height: 10),
            const CardInfoWidget(),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.payment,
                  size: 64,
                ),
                Container(
                  width: 113,
                  height: 58,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 1.50,
                        color:
                            Colors.green), // Adjust color and width as needed
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      'PAID',
                      textAlign: TextAlign.center,
                      style: Styles.style24.copyWith(color: Colors.green),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Navigate back to the previous screen (home screen)
              },
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
