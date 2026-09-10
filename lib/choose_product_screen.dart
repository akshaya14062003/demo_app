import 'package:flutter/material.dart';
import 'package:demo_app/welcome_back.dart';

class ChooseProductScreen extends StatefulWidget {
  const ChooseProductScreen({super.key});

  @override
  State<ChooseProductScreen> createState() =>
      _ChooseProductScreenState();
}

class _ChooseProductScreenState extends State<ChooseProductScreen> {
  final PageController pageController = PageController();

  final List<String> images = [
    'assets/image2.png',
    'assets/image3.png',
    'assets/image4.png',
  ];

  final List<String> headings = [
    'Choose Products',
    'Make Payments',
    'Get Your Order',
  ];

  final List<String> paragraph = [
    'To style a dress for content creation or daily wear, focus on versatility, fabric details, and color harmony. Transform a single piece into multiple looks by switching',
    'A content style guide is a set of rules for writing and formatting. It keeps your brand voice clear and the same everywhere',
    'Great fashion content balances visual appeal with clear styling value. To build an engaging feed or portfolio, mix quick outfit transitions, detailed fit checks',
  ];

  int currentPage = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView.builder(
          controller: pageController,
          itemCount: images.length,

          onPageChanged: (index) {
            setState(() {
              currentPage = index;
            });
          },

          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${index + 1}/3",
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                     GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WelcomeBackScreen(),
                          ),
                        );
                      },
                      child: const Text(
                          "Skip",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                    ),
                    child: Image.asset(
                      images[index],
                      height: 350,
                      width: 350,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Text(
                  headings[index],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 50),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Text(
                    paragraph[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                ),

                const Spacer(),


                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [

                      // =====================
                      // PREVIOUS - LEFT
                      // =====================

                      SizedBox(
                        width: 60,
                        child: index > 0
                            ? GestureDetector(
                          onTap: () {
                            pageController.previousPage(
                              duration:
                              const Duration(
                                milliseconds: 300,
                              ),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: const Text(
                            "Prev",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.red,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        )
                            : null,
                      ),


                      Expanded(
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [

                            // PAGE 1
                            Container(
                              width: 50,
                              height: 10,
                              decoration: BoxDecoration(
                                color: currentPage == 0
                                    ? Colors.black87
                                    : Colors.grey,
                                borderRadius:
                                BorderRadius.circular(10),
                              ),
                            ),

                            const SizedBox(width: 15),

                            // PAGE 2
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: currentPage == 1
                                    ? Colors.black87
                                    : Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),

                            const SizedBox(width: 15),

                            // PAGE 3
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: currentPage == 2
                                    ? Colors.black87
                                    : Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // =====================
                      // NEXT / GET STARTED
                      // =====================

                      SizedBox(
                        width: 120,
                        child: GestureDetector(
                          onTap: () {

                            // PAGE 1 AND PAGE 2
                            if (index <
                                images.length - 1) {
                              pageController.nextPage(
                                duration:
                                const Duration(
                                  milliseconds: 300,
                                ),
                                curve: Curves.easeInOut,
                              );
                            }

                            // PAGE 3
                            else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                  const WelcomeBackScreen(),
                                ),
                              );
                            }
                          },

                          child: Text(
                            index == images.length - 1
                                ? "Get Started"
                                : "Next",
                            maxLines: 1,
                            softWrap: false,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}