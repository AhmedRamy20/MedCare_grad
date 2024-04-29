import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_app/core/theming/colors.dart';
import 'package:medical_app/core/widgets/onboarding_button.dart';
import 'package:medical_app/features/onboarding/onboarding_lst_screen.dart';
import 'package:medical_app/features/onboarding/onboarding_sec_screen.dart';
import 'package:medical_app/features/onboarding/onboarding_th_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AllOnboardingScreens extends StatefulWidget {
  const AllOnboardingScreens({super.key});

  @override
  State<AllOnboardingScreens> createState() => _AllOnboardingScreensState();
}

class _AllOnboardingScreensState extends State<AllOnboardingScreens> {
  final PageController _controller = PageController();

  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: const [
              OnBoardingFirstScreen(),
              OnBoardingSecScreen(),
              OnBoardingThirdScreen(), //delete the button
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.73),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //!Button to skip

                onLastPage
                    ? const SizedBox()
                    : SkipButton(controller: _controller),

                //!Dot indicator
                onLastPage
                    ? const SizedBox()
                    : SmoothPageIndicator(
                        controller: _controller,
                        count: 3,
                        effect: WormEffect(
                          activeDotColor: ColorsProvider.primaryBink,
                          dotWidth: 30.w,
                          dotHeight: 10.h,
                        ),
                        onDotClicked: (index) => _controller.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        ),
                      ),

                //!Button for next
                onLastPage
                    ? const SizedBox()
                    : NextButton(
                        controller: _controller,
                        onTap: () {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
