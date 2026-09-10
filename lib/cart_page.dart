import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:demo_app/services/cart_api.dart';

import 'cart_data.dart';
import 'checkout.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  @override
  void initState() {
    super.initState();
    loadCartFromApi();
  }

  Future<void> loadCartFromApi() async {
    try {
      final cartData = await CartApi.getUserCart(1);
      print(cartData);
    } catch (e) {
      print('Cart API Error: $e');
    }
  }

  int getQuantity(Map<String, dynamic> product) {
    final quantity = product['quantity'];
    if (quantity is int) {
      return quantity;
    }
    return int.tryParse(
      quantity?.toString() ?? '1',
    ) ??
        1;
  }


  double getPrice(dynamic price) {
    if (price == null) {
      return 0;
    }

    String priceString = price.toString();

    priceString = priceString.replaceAll(
      RegExp(r'[^0-9.]'),
      '',
    );

    return double.tryParse(priceString) ?? 0;
  }

  String formatPrice(double price) {
    return '₹ ${price.toStringAsFixed(0)}';
  }


  double getTotalPrice() {
    double total = 0;

    for (final product in CartData.cartProducts) {
      final double price = getPrice(product['price']);
      final int quantity = getQuantity(product);

      total += price * quantity;
    }

    return total;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),


      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: Text(
          'My Cart',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),

        iconTheme: const IconThemeData(
          color: Colors.black,
        ),

        actions: [
          ValueListenableBuilder<int>(
            valueListenable: CartData.cartCountNotifier,

            builder: (context, count, child) {
              if (count > 0) {
                return IconButton(
                  onPressed: () {
                    CartData.clearCart();
                  },

                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),



      body: ValueListenableBuilder<int>(
        valueListenable: CartData.cartCountNotifier,

        builder: (context, count, child) {
          final List<Map<String, dynamic>> products =
          List<Map<String, dynamic>>.from(
            CartData.cartProducts,
          );


          if (products.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  const Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'Your cart is empty',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Add products to your cart',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(15),

                  itemCount: products.length,

                  itemBuilder: (context, index) {
                    final product = products[index];

                    final int quantity =
                    getQuantity(product);

                    final double price =
                    getPrice(product['price']);

                    final double productTotal =
                        price * quantity;

                    return Container(
                      margin: const EdgeInsets.only(
                        bottom: 12,
                      ),

                      padding: const EdgeInsets.all(10),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius:
                        BorderRadius.circular(12),

                        boxShadow: [
                          BoxShadow(
                            color:
                            Colors.black.withOpacity(0.08),

                            blurRadius: 5,

                            offset:
                            const Offset(0, 2),
                          ),
                        ],
                      ),

                      child: Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          ClipRRect(
                            borderRadius:
                            BorderRadius.circular(8),

                            child: Image.network(
                              product['image'] ?? '',

                              width: 100,
                              height: 120,

                              fit: BoxFit.cover,

                              errorBuilder:
                                  (context, error, stackTrace) {
                                return Container(
                                  width: 100,
                                  height: 120,

                                  color:
                                  Colors.grey.shade200,

                                  child: const Icon(
                                    Icons.image,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,

                              children: [


                                Text(
                                  product['name'] ?? '',

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

                                const SizedBox(height: 5),



                                Text(
                                  product['description'] ??
                                      product['desc'] ??
                                      '',

                                  maxLines: 2,

                                  overflow:
                                  TextOverflow.ellipsis,

                                  style:
                                  GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),

                                const SizedBox(height: 6),



                                Text(
                                  formatPrice(price),

                                  style:
                                  GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 4),


                                if ((product['discount'] ?? '')
                                    .toString()
                                    .isNotEmpty)
                                  Text(
                                    product['discount']
                                        .toString(),

                                    style:
                                    GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.green,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),

                                const SizedBox(height: 8),



                                Row(
                                  children: [
                                    Text(
                                      'Quantity',
                                      style:
                                      GoogleFonts.poppins(
                                        fontSize: 12,
                                        color:
                                        Colors.grey.shade700,
                                        fontWeight:
                                        FontWeight.w500,
                                      ),
                                    ),

                                    const SizedBox(width: 8),

                                    // MINUS BUTTON
                                    quantityButton(
                                      icon: Icons.remove,
                                      onPressed: () {
                                        CartData
                                            .decreaseQuantity(
                                          index,
                                        );
                                      },
                                    ),

                                    // QUANTITY
                                    Container(
                                      width: 35,
                                      height: 30,

                                      alignment:
                                      Alignment.center,

                                      child: Text(
                                        quantity.toString(),

                                        style:
                                        GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight:
                                          FontWeight.w600,
                                        ),
                                      ),
                                    ),

                                    // PLUS BUTTON
                                    quantityButton(
                                      icon: Icons.add,
                                      onPressed: () {
                                        CartData
                                            .increaseQuantity(
                                          index,
                                        );
                                      },
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 7),


                                Text(
                                  'Total: ${formatPrice(productTotal)}',

                                  style:
                                  GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight:
                                    FontWeight.w600,
                                    color:
                                    const Color(0xff333333),
                                  ),
                                ),

                                const SizedBox(height: 7),



                                GestureDetector(
                                  onTap: () {
                                    CartData.removeFromCart(
                                      index,
                                    );

                                    Fluttertoast.showToast(
                                      msg: "Product removed",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.black87,
                                      textColor: Colors.white,
                                    );
                                  },

                                  child: const Text(
                                    'Remove',

                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),



              Container(
                padding: const EdgeInsets.all(20),

                decoration: const BoxDecoration(
                  color: Colors.white,

                  boxShadow: [
                    BoxShadow(
                      color: Color(0x20000000),
                      blurRadius: 10,
                      offset: Offset(0, -3),
                    ),
                  ],
                ),

                child: Column(
                  children: [


                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                      children: [
                        Text(
                          'Total Items',

                          style:
                          GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight:
                            FontWeight.w500,
                          ),
                        ),

                        Text(
                          '$count',

                          style:
                          GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),



                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                      children: [
                        Text(
                          'Total Price',

                          style:
                          GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight:
                            FontWeight.w500,
                          ),
                        ),

                        Text(
                          formatPrice(
                            getTotalPrice(),
                          ),

                          style:
                          GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),


                    SizedBox(
                      width: double.infinity,
                      height: 55,

                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,

                            MaterialPageRoute(
                              builder: (context) =>
                              const Checkout(),
                            ),
                          );
                        },

                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor:
                          Colors.pink,

                          foregroundColor:
                          Colors.white,

                          elevation: 0,

                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(
                              12,
                            ),
                          ),
                        ),

                        child: Text(
                          'Proceed to Checkout',

                          style:
                          GoogleFonts.poppins(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight:
                            FontWeight.bold,
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


  Widget quantityButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,

      borderRadius: BorderRadius.circular(5),

      child: Container(
        width: 30,
        height: 30,

        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
          ),

          borderRadius:
          BorderRadius.circular(5),
        ),

        child: Icon(
          icon, // icon is of type IconData, which is correct.
          size: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}