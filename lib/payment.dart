import 'package:demo_app/home_page.dart';
import 'package:demo_app/cart_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Payment extends StatefulWidget {
  final double totalAmount;

  const Payment({
    super.key,
    required this.totalAmount,
  });

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  int selectedPayment = 0;

  final double shipping = 30;

  @override
  Widget build(BuildContext context) {
    final double totalAmount =
        widget.totalAmount + shipping;

    return Scaffold(
      backgroundColor: Colors.white,


      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: Colors.black,
          ),
        ),

        title: Text(
          "Payment",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),



      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 17,
          ),

          child: Column(
            children: [



              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      const SizedBox(
                        height: 5,
                      ),



                      paymentAmountRow(
                        title: "Order",
                        amount: widget.totalAmount,
                        titleColor:
                        const Color(0xffAAAAAA),
                        amountColor:
                        const Color(0xff999999),
                      ),

                      const SizedBox(
                        height: 12,
                      ),



                      paymentAmountRow(
                        title: "Shipping",
                        amount: shipping,
                        titleColor:
                        const Color(0xffAAAAAA),
                        amountColor:
                        const Color(0xff999999),
                      ),

                      const SizedBox(
                        height: 14,
                      ),



                      paymentAmountRow(
                        title: "Total",
                        amount: totalAmount,
                        titleColor:
                        const Color(0xff444444),
                        amountColor:
                        const Color(0xff444444),
                        isTotal: true,
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      Container(
                        height: 1,
                        color:
                        const Color(0xffD0D0D0),
                      ),

                      const SizedBox(
                        height: 20,
                      ),



                      Text(
                        "Payment Method",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight:
                          FontWeight.w500,
                          color:
                          const Color(0xff333333),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),



                      paymentCard(
                        index: 0,
                        child: Row(
                          children: [

                            Text(
                              "VISA",
                              style:
                              GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight:
                                FontWeight.w700,
                                color:
                                const Color(
                                  0xff172B75,
                                ),
                              ),
                            ),

                            const Spacer(),

                            Text(
                              "********2109",
                              style:
                              GoogleFonts.poppins(
                                fontSize: 8,
                                color:
                                const Color(
                                  0xff777777,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),



                      paymentCard(
                        index: 1,
                        child: Row(
                          children: [

                            Text(
                              "PayPal",
                              style:
                              GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight:
                                FontWeight.w700,
                                color:
                                const Color(
                                  0xff003087,
                                ),
                              ),
                            ),

                            const Spacer(),

                            Text(
                              "********2109",
                              style:
                              GoogleFonts.poppins(
                                fontSize: 8,
                                color:
                                const Color(
                                  0xff777777,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),



                      paymentCard(
                        index: 2,
                        child: Row(
                          children: [

                            Container(
                              width: 20,
                              height: 20,

                              decoration:
                              const BoxDecoration(
                                shape:
                                BoxShape.circle,
                                color:
                                Color(
                                  0xffE00000,
                                ),
                              ),

                              child: const Center(
                                child: Text(
                                  "MC",
                                  style:
                                  TextStyle(
                                    fontSize: 8,
                                    fontWeight:
                                    FontWeight.bold,
                                    color:
                                    Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(
                              width: 8,
                            ),

                            Text(
                              "Mastercard",
                              style:
                              GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight:
                                FontWeight.w600,
                                color:
                                Colors.black,
                              ),
                            ),

                            const Spacer(),

                            Text(
                              "********2109",
                              style:
                              GoogleFonts.poppins(
                                fontSize: 8,
                                color:
                                const Color(
                                  0xff777777,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),



                      paymentCard(
                        index: 3,
                        child: Row(
                          children: [

                            const Icon(
                              Icons.apple,
                              size: 22,
                              color: Colors.black,
                            ),

                            const SizedBox(
                              width: 8,
                            ),

                            Text(
                              "Apple Pay",
                              style:
                              GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight:
                                FontWeight.w600,
                                color:
                                Colors.black,
                              ),
                            ),

                            const Spacer(),

                            Text(
                              "********2109",
                              style:
                              GoogleFonts.poppins(
                                fontSize: 8,
                                color:
                                const Color(
                                  0xff777777,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),


              SizedBox(
                width: double.infinity,
                height: 45,

                child: ElevatedButton(
                  onPressed: () {
                    showPaymentSuccess();
                  },

                  style:
                  ElevatedButton.styleFrom(
                    backgroundColor:
                    const Color(0xffFF3558),

                    foregroundColor:
                    Colors.white,

                    elevation: 0,

                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(5),
                    ),
                  ),

                  child: Text(
                    "Continue",
                    style:
                    GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight:
                      FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }



  Widget paymentAmountRow({
    required String title,
    required double amount,
    required Color titleColor,
    required Color amountColor,
    bool isTotal = false,
  }) {
    return Row(
      children: [

        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: isTotal
                ? FontWeight.w600
                : FontWeight.w400,
            color: titleColor,
          ),
        ),

        const Spacer(),

        Text(
          "₹ ${amount.toStringAsFixed(0)}",
          style: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: isTotal
                ? FontWeight.w600
                : FontWeight.w400,
            color: amountColor,
          ),
        ),
      ],
    );
  }



  Widget paymentCard({
    required int index,
    required Widget child,
  }) {
    final bool selected =
        selectedPayment == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPayment = index;
        });
      },

      child: Container(
        width: double.infinity,
        height: 60,

        padding:
        const EdgeInsets.symmetric(
          horizontal: 12,
        ),

        decoration: BoxDecoration(
          color: selected
              ? Colors.white
              : const Color(0xffF5F5F5),

          borderRadius:
          BorderRadius.circular(5),

          border: Border.all(
            color: selected
                ? const Color(0xffFF3558)
                : Colors.transparent,
            width: 1,
          ),
        ),

        child: child,
      ),
    );
  }



  void showPaymentSuccess() {
    showDialog(
      context: context,

      barrierDismissible: false,

      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.white,

          shape:
          RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(15),
          ),

          child: Padding(
            padding:
            const EdgeInsets.all(20),

            child: Column(
              mainAxisSize:
              MainAxisSize.min,

              children: [



                SizedBox(
                  width: 150,
                  height: 150,

                  child: Lottie.asset(
                    'assets/DONE.json',
                    repeat: false,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),



                Text(
                  "Payment Successful!",
                  textAlign:
                  TextAlign.center,

                  style:
                  GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight:
                    FontWeight.w600,
                    color:
                    const Color(
                      0xff333333,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                Text(
                  "Your order has been placed successfully.",
                  textAlign:
                  TextAlign.center,

                  style:
                  GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight:
                    FontWeight.w400,
                    color:
                    const Color(
                      0xff888888,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );



    Future.delayed(
      const Duration(seconds: 2),
          () {
        if (!mounted) return;

        // Clear cart
        CartData.clearCart();

        // Go to Home
        Navigator.pushAndRemoveUntil(
          context,

          MaterialPageRoute(
            builder: (context) =>
            const HomePage(),
          ),

              (route) => false,
        );
      },
    );
  }
}