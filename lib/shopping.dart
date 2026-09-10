import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cart_data.dart';
import 'payment.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {

  double getPrice(dynamic price) {
    if (price == null) {
      return 0;
    }

    String priceString = price.toString();

    priceString =
        priceString.replaceAll(RegExp(r'[^0-9.]'), '');

    return double.tryParse(priceString) ?? 0;
  }

  String formatPrice(double amount) {
    return '₹ ${amount.toStringAsFixed(2)}';
  }

  double getTotalAmount(
      List<Map<String, dynamic>> products,
      ) {
    double total = 0;

    for (final product in products) {

      // Get product price
      final double price =
      getPrice(product['price']);

      // Get product quantity
      int quantity = 1;

      if (product['quantity'] != null) {
        quantity =
            int.tryParse(
              product['quantity'].toString(),
            ) ??
                1;
      }

      // Price × Quantity
      total += price * quantity;
    }

    return total;
  }

  int getTotalQuantity(
      List<Map<String, dynamic>> products,
      ) {
    int totalQuantity = 0;

    for (final product in products) {

      int quantity = 1;

      if (product['quantity'] != null) {
        quantity =
            int.tryParse(
              product['quantity'].toString(),
            ) ??
                1;
      }

      totalQuantity += quantity;
    }

    return totalQuantity;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        centerTitle: true,

        title: Text(
          'Shopping Bag',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.black,
              size: 24,
            ),
          ),
        ],
      ),

      body: ValueListenableBuilder<int>(
        valueListenable: CartData.cartCountNotifier,

        builder: (context, count, child) {

          // Get ALL products from CartData
          final List<Map<String, dynamic>> products =
          List<Map<String, dynamic>>.from(
            CartData.cartProducts,
          );



          if (products.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,

                children: [

                  const Icon(
                    Icons.shopping_bag_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),

                  const SizedBox(height: 15),

                  Text(
                    'Your shopping bag is empty',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight:
                      FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Add products to your bag',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }



          final double totalAmount =
          getTotalAmount(products);

          final int totalQuantity =
          getTotalQuantity(products);



          return Column(
            children: [

              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),

                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        const SizedBox(
                          height: 20,
                        ),



                        Text(
                          '$totalQuantity Items',
                          style:
                          GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight:
                            FontWeight.w600,
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),



                        ...products.map(
                              (product) =>
                              productCard(product),
                        ),

                        const SizedBox(
                          height: 25,
                        ),



                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,

                          children: [

                            Row(
                              children: [

                                const Icon(
                                  Icons
                                      .local_offer_outlined,
                                  size: 28,
                                  color:
                                  Colors.black,
                                ),

                                const SizedBox(
                                  width: 10,
                                ),

                                Text(
                                  'Apply Coupons',
                                  style:
                                  GoogleFonts
                                      .poppins(
                                    fontSize: 16,
                                    fontWeight:
                                    FontWeight
                                        .w500,
                                  ),
                                ),
                              ],
                            ),

                            GestureDetector(
                              onTap: () {},

                              child: Text(
                                'Select',
                                style:
                                GoogleFonts
                                    .poppins(
                                  fontSize: 13,
                                  color: Colors.red,
                                  fontWeight:
                                  FontWeight
                                      .w500,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        Divider(
                          color:
                          Colors.grey.shade300,
                        ),

                        const SizedBox(
                          height: 35,
                        ),



                        Text(
                          'Order Payment Details',
                          style:
                          GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight:
                            FontWeight.w500,
                          ),
                        ),

                        const SizedBox(
                          height: 25,
                        ),



                        paymentRow(
                          'Order Amounts',
                          formatPrice(totalAmount),
                        ),

                        const SizedBox(
                          height: 15,
                        ),



                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,

                          children: [

                            Text(
                              'Convenience',
                              style:
                              GoogleFonts
                                  .poppins(
                                fontSize: 14,
                              ),
                            ),

                            Row(
                              children: [

                                Text(
                                  'Know More',
                                  style:
                                  GoogleFonts
                                      .poppins(
                                    fontSize: 12,
                                    color:
                                    Colors.red,
                                  ),
                                ),

                                const SizedBox(
                                  width: 30,
                                ),

                                Text(
                                  'Apply Coupon',
                                  style:
                                  GoogleFonts
                                      .poppins(
                                    fontSize: 12,
                                    color:
                                    Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 15,
                        ),



                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,

                          children: [

                            Text(
                              'Delivery Fee',
                              style:
                              GoogleFonts
                                  .poppins(
                                fontSize: 14,
                              ),
                            ),

                            Text(
                              'Free',
                              style:
                              GoogleFonts
                                  .poppins(
                                fontSize: 13,
                                color:
                                Colors.red,
                                fontWeight:
                                FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 40,
                        ),

                        Divider(
                          color:
                          Colors.grey.shade300,
                        ),

                        const SizedBox(
                          height: 30,
                        ),



                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,

                          children: [

                            Text(
                              'Order Total',
                              style:
                              GoogleFonts
                                  .poppins(
                                fontSize: 16,
                              ),
                            ),

                            Text(
                              formatPrice(
                                totalAmount,
                              ),
                              style:
                              GoogleFonts
                                  .poppins(
                                fontSize: 16,
                                fontWeight:
                                FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 12,
                        ),



                        Row(
                          children: [

                            Text(
                              'EMI Available',
                              style:
                              GoogleFonts
                                  .poppins(
                                fontSize: 14,
                              ),
                            ),

                            const SizedBox(
                              width: 35,
                            ),

                            Text(
                              'Details',
                              style:
                              GoogleFonts
                                  .poppins(
                                fontSize: 12,
                                color:
                                Colors.red,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ),
              ),



              Container(
                width: double.infinity,

                padding:
                const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 15,
                ),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                  const BorderRadius.only(
                    topLeft:
                    Radius.circular(20),
                    topRight:
                    Radius.circular(20),
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(0.08),
                      blurRadius: 10,
                      offset:
                      const Offset(0, -3),
                    ),
                  ],
                ),

                child: Row(
                  children: [



                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                        children: [

                          Text(
                            formatPrice(
                              totalAmount,
                            ),
                            style:
                            GoogleFonts
                                .poppins(
                              fontSize: 16,
                              fontWeight:
                              FontWeight.w600,
                            ),
                          ),

                          const SizedBox(
                            height: 2,
                          ),

                          GestureDetector(
                            onTap: () {},

                            child: Text(
                              'View Details',
                              style:
                              GoogleFonts
                                  .poppins(
                                fontSize: 12,
                                color:
                                Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),



                    SizedBox(
                      width: 215,
                      height: 48,

                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Payment(
                                    totalAmount: totalAmount,
                                  ),
                            ),
                          );
                        },

                        style:
                        ElevatedButton
                            .styleFrom(
                          backgroundColor:
                          Colors.pink,

                          foregroundColor:
                          Colors.white,

                          elevation: 0,

                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius
                                .circular(6),
                          ),
                        ),

                        child: Text(
                          'Proceed to Payment',
                          style:
                          GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight:
                            FontWeight.w600,
                            color:
                            Colors.white,
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
    );
  }



  Widget productCard(
      Map<String, dynamic> product,
      ) {



    int quantity = 1;

    if (product['quantity'] != null) {
      quantity =
          int.tryParse(
            product['quantity'].toString(),
          ) ??
              1;
    }

    final double price =
    getPrice(product['price']);



    final double productTotal =
        price * quantity;

    return Container(
      width: double.infinity,

      margin:
      const EdgeInsets.only(
        bottom: 25,
      ),

      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [



          ClipRRect(
            borderRadius:
            BorderRadius.circular(5),

            child: Image.asset(
              product['image'] ?? '',

              width: 122,
              height: 150,

              fit: BoxFit.cover,

              errorBuilder:
                  (context, error, stackTrace) {

                return Container(
                  width: 122,
                  height: 150,

                  color:
                  Colors.grey.shade200,

                  child: const Icon(
                    Icons.image_outlined,
                    size: 40,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),

          const SizedBox(
            width: 20,
          ),



          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  product['name'] ??
                      'Women’s Casual Wear',

                  maxLines: 2,

                  overflow:
                  TextOverflow.ellipsis,

                  style:
                  GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight:
                    FontWeight.w600,
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                Text(
                  product['description'] ??
                      product['desc'] ??
                      'Checked Single-Breasted Blazer',

                  maxLines: 2,

                  overflow:
                  TextOverflow.ellipsis,

                  style:
                  GoogleFonts.poppins(
                    fontSize: 12,
                    color:
                    Colors.black87,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                Row(
                  children: [

                    sizeBox(
                      'Size',
                      product['size'] ?? '42',
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    sizeBox(
                      'Qty',
                      quantity,
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),

                Row(
                  children: [

                    Text(
                      'Delivery by',
                      style:
                      GoogleFonts.poppins(
                        fontSize: 12,
                      ),
                    ),

                    const SizedBox(
                      width: 6,
                    ),

                    Text(
                      '10 May 2XXX',
                      style:
                      GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight:
                        FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),

                Text(
                  formatPrice(
                    productTotal,
                  ),
                  style:
                  GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight:
                    FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget sizeBox(
      String title,
      dynamic value,
      ) {
    return Container(
      height: 26,

      padding:
      const EdgeInsets.symmetric(
        horizontal: 10,
      ),

      decoration: BoxDecoration(
        color:
        Colors.grey.shade100,

        borderRadius:
        BorderRadius.circular(4),
      ),

      child: Row(
        children: [

          Text(
            title,
            style:
            GoogleFonts.poppins(
              fontSize: 11,
              color: Colors.black,
            ),
          ),

          const SizedBox(
            width: 10,
          ),

          Text(
            value.toString(),
            style:
            GoogleFonts.poppins(
              fontSize: 11,
              fontWeight:
              FontWeight.w500,
            ),
          ),

          const SizedBox(
            width: 5,
          ),

          const Icon(
            Icons.keyboard_arrow_down,
            size: 15,
          ),
        ],
      ),
    );
  }



  Widget paymentRow(
      String title,
      String amount,
      ) {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,

      children: [

        Text(
          title,
          style:
          GoogleFonts.poppins(
            fontSize: 14,
          ),
        ),

        Text(
          amount,
          style:
          GoogleFonts.poppins(
            fontSize: 15,
            fontWeight:
            FontWeight.w600,
          ),
        ),
      ],
    );
  }
}