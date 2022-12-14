import 'package:flutter/material.dart';
import 'package:introduction_screens/home_page.dart';
import 'package:introduction_screens/intro_screen/intro_page_1.dart';
import 'package:introduction_screens/intro_screen/intro_page_2.dart';
import 'package:introduction_screens/intro_screen/intro_page_3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // page view
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = index == 2;
              });
            },
            children: const [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),

          // dot indicators
          Container(
            alignment: const Alignment(0, 0.85),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(2);
                  },
                  child: const Text("Skip")
                ),
                SmoothPageIndicator(
                    controller: _controller,
                    count: 3
                ),
                onLastPage
                    ? GestureDetector(
                      onTap: () {
                        Navigator.push(context, 
                            MaterialPageRoute(builder: (context) {
                              return const HomePage();
                            }));
                      },
                      child: const Text("Done")
                    )
                    : GestureDetector(
                      onTap: () {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 500,),
                          curve: Curves.easeIn,
                        );
                      },
                      child: const Text("Next"),
                    ),

              ],
            ),
          )
        ],
      )
    );
  }
}
