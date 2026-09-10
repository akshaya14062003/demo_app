import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'cart_data.dart';
import 'profile.dart';
import 'payment.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  String personalAddress = '';
  String businessAddress = '';

  String selectedAddressType = 'personal';

  @override
  void initState() {
    super.initState();
    loadAddresses();
  }



  Future<void> loadAddresses() async {
    final prefs = await SharedPreferences.getInstance();


    final personalName = prefs.getString('name') ?? '';
    final address = prefs.getString('address') ?? '';
    final city = prefs.getString('city') ?? '';
    final zip = prefs.getString('zip') ?? '';
    final country = prefs.getString('country') ?? '';


    final businessName = prefs.getString('businessName') ?? '';
    final businessAddressValue =
        prefs.getString('businessAddress') ?? '';
    final businessCity =
        prefs.getString('businessCity') ?? '';
    final businessZip =
        prefs.getString('businessZip') ?? '';
    final businessCountry =
        prefs.getString('businessCountry') ?? '';

    if (!mounted) return;

    setState(() {
      personalAddress = buildAddress(
        personalName,
        address,
        city,
        zip,
        country,
      );

      businessAddress = buildAddress(
        businessName,
        businessAddressValue,
        businessCity,
        businessZip,
        businessCountry,
      );
    });
  }



  String buildAddress(
      String name,
      String address,
      String city,
      String zip,
      String country,
      ) {
    final parts = <String>[];

    if (name.trim().isNotEmpty) {
      parts.add(name.trim());
    }

    if (address.trim().isNotEmpty) {
      parts.add(address.trim());
    }

    if (city.trim().isNotEmpty) {
      parts.add(city.trim());
    }

    if (zip.trim().isNotEmpty) {
      parts.add(zip.trim());
    }

    if (country.trim().isNotEmpty) {
      parts.add(country.trim());
    }

    return parts.join(', ');
  }



  Widget addressCard({
    required String title,
    required String address,
    required String value,
  }) {
    final bool isSelected =
        selectedAddressType == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAddressType = value;
        });
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? Colors.pink
                : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [


            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    address.isEmpty
                        ? 'No address added'
                        : address,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),



            IconButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    const ProfilePage(
                      fromCheckout: true,
                    ),
                  ),
                );

                // Reload address after saving
                if (result == true) {
                  await loadAddresses();
                }
              },
              icon: const Icon(
                Icons.edit_outlined,
                size: 20,
                color: Colors.black,
              ),
            ),



            Radio<String>(
              value: value,
              groupValue: selectedAddressType,
              activeColor: Colors.pink,
              onChanged: (newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedAddressType =
                        newValue;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }



  Widget productCard(
      Map<String, dynamic> product,
      ) {
    final String image =
        product['image']?.toString() ?? '';

    final String name =
        product['name']?.toString() ?? '';

    final String price =
        product['price']?.toString() ?? '';

    final String discount =
        product['discount']?.toString() ??
            'up to 35% off';

    final String oldPrice =
        product['oldPrice']?.toString() ?? '';

    final int quantity =
    CartData.getQuantity(product);

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [


              ClipRRect(
                borderRadius:
                BorderRadius.circular(8),
                child: Image.asset(
                  image,
                  width: 140,
                  height: 145,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) {
                    return Container(
                      width: 140,
                      height: 145,
                      color: Colors.grey.shade200,
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
                      name,
                      maxLines: 2,
                      overflow:
                      TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight:
                        FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Variations :',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                      ),
                    ),

                    const SizedBox(height: 7),

                    Row(
                      children: [
                        variationBox('Black'),
                        const SizedBox(width: 6),
                        variationBox('Red'),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 16,
                          color: Colors.orange,
                        ),
                        Text(
                          ' 4.8',
                          style:
                          GoogleFonts.poppins(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // PRICE
                    Row(
                      children: [
                        Container(
                          padding:
                          const EdgeInsets
                              .symmetric(
                            horizontal: 12,
                            vertical: 7,
                          ),
                          decoration:
                          BoxDecoration(
                            border: Border.all(
                              color: Colors
                                  .grey.shade300,
                            ),
                            borderRadius:
                            BorderRadius
                                .circular(5),
                          ),
                          child: Text(
                            price,
                            style:
                            GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [
                              Text(
                                discount,
                                style: GoogleFonts
                                    .poppins(
                                  fontSize: 9,
                                  color:
                                  Colors.red,
                                ),
                              ),

                              Text(
                                oldPrice,
                                style: GoogleFonts
                                    .poppins(
                                  fontSize: 12,
                                  color:
                                  Colors.grey,
                                  decoration:
                                  TextDecoration
                                      .lineThrough,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // QUANTITY
                    Text(
                      'Quantity: $quantity',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        fontWeight:
                        FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Divider(
            color: Colors.grey.shade300,
          ),

          const SizedBox(height: 5),

          // TOTAL ORDER
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Order ($quantity) :',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                ),
              ),

              Text(
                getProductTotal(product),
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }



  String getProductTotal(
      Map<String, dynamic> product,
      ) {
    final dynamic priceValue =
    product['price'];

    String priceString =
        priceValue?.toString() ?? '0';

    priceString = priceString.replaceAll(
      RegExp(r'[^0-9.]'),
      '',
    );

    final double price =
        double.tryParse(priceString) ?? 0;

    final int quantity =
    CartData.getQuantity(product);

    final double total =
        price * quantity;

    return '₹ ${total.toStringAsFixed(0)}';
  }



  Widget variationBox(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade400,
        ),
        borderRadius:
        BorderRadius.circular(3),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 10,
        ),
      ),
    );
  }


  double getTotalAmount() {
    double total = 0;

    for (final product
    in CartData.cartProducts) {
      final dynamic priceValue =
      product['price'];

      String priceString =
          priceValue?.toString() ?? '0';

      priceString = priceString.replaceAll(
        RegExp(r'[^0-9.]'),
        '',
      );

      final double price =
          double.tryParse(priceString) ?? 0;

      final int quantity =
      CartData.getQuantity(product);

      total += price * quantity;
    }

    return total;
  }



  void openPaymentPage() {
    final double totalAmount =
    getTotalAmount();

    if (selectedAddressType == 'personal' && personalAddress.isEmpty ||
        selectedAddressType == 'business' && businessAddress.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please add a valid address first",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Payment(
          totalAmount: totalAmount,
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xfff8f8f8),



      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        centerTitle: true,

        title: Text(
          'Checkout',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),



      body: ValueListenableBuilder<int>(
        valueListenable:
        CartData.cartCountNotifier,

        builder:
            (context, count, child) {
          final List<Map<String, dynamic>>
          products =
          List<Map<String, dynamic>>.from(
            CartData.cartProducts,
          );

          return SingleChildScrollView(
            padding:
            const EdgeInsets.all(14),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [


                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 22,
                    ),

                    const SizedBox(width: 6),

                    Text(
                      'Delivery Address',
                      style:
                      GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight:
                        FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),



                addressCard(
                  title: 'Personal Address',
                  address: personalAddress,
                  value: 'personal',
                ),



                addressCard(
                  title: 'Business Address',
                  address: businessAddress,
                  value: 'business',
                ),

                const SizedBox(height: 25),



                Text(
                  'Shopping List',
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight:
                    FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 12),

                if (products.isEmpty)
                  Center(
                    child: Padding(
                      padding:
                      const EdgeInsets.all(30),
                      child: Text(
                        'Your cart is empty',
                        style:
                        GoogleFonts.poppins(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
                else
                  ...products.map(
                        (product) =>
                        productCard(product),
                  ),

                const SizedBox(height: 20),



                if (products.isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding:
                    const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        // TOTAL ITEMS
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                          children: [
                            Text(
                              'Total Items',
                              style: GoogleFonts
                                  .poppins(
                                fontSize: 14,
                                fontWeight:
                                FontWeight.w500,
                              ),
                            ),

                            Text(
                              '$count',
                              style: GoogleFonts
                                  .poppins(
                                fontSize: 15,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        // TOTAL PRICE
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                          children: [
                            Text(
                              'Total Price',
                              style: GoogleFonts
                                  .poppins(
                                fontSize: 14,
                                fontWeight:
                                FontWeight.w500,
                              ),
                            ),

                            Text(
                              '₹ ${getTotalAmount().toStringAsFixed(0)}',
                              style: GoogleFonts
                                  .poppins(
                                fontSize: 17,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        // --------------------------------
                        // PLACE ORDER BUTTON
                        // --------------------------------

                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed:
                            openPaymentPage,

                            style: ElevatedButton
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
                                    .circular(8),
                              ),
                            ),

                            child: Text(
                              'Place Order',
                              style:
                              GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }
}