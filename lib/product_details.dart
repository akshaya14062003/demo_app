import 'package:demo_app/cart_data.dart';
import 'package:demo_app/cart_page.dart';
import 'package:demo_app/services/product_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState
    extends State<ProductDetailScreen> {
  String selectedSize = '';

  // Dynamic similar products
  List<Map<String, dynamic>> similarProducts = [];

  bool isLoadingSimilarProducts = true;

  // ============================================================
  // GET PRODUCT DATA
  // ============================================================

  String get productName {
    return widget.product['name']?.toString() ??
        widget.product['title']?.toString() ??
        '';
  }

  String get productDescription {
    return widget.product['description']?.toString() ?? '';
  }

  String get productImage {
    return widget.product['image']?.toString() ?? '';
  }

  String get productCategory {
    return widget.product['category']?.toString() ?? '';
  }

  double get productPrice {
    final dynamic price = widget.product['price'];

    if (price is num) {
      return price.toDouble();
    }

    return double.tryParse(
      price?.toString().replaceAll('₹', '') ?? '0',
    ) ??
        0;
  }

  // ============================================================
  // OLD PRICE
  // ============================================================

  double get productOldPrice {
    final dynamic oldPrice =
    widget.product['oldPrice'];

    if (oldPrice is num) {
      return oldPrice.toDouble();
    }

    return double.tryParse(
      oldPrice?.toString().replaceAll('₹', '') ?? '0',
    ) ??
        0;
  }

  // ============================================================
  // DISCOUNT
  // ============================================================

  double get productDiscount {
    final dynamic discount =
    widget.product['discount'];

    if (discount is num) {
      return discount.toDouble();
    }

    return double.tryParse(
      discount?.toString() ?? '0',
    ) ??
        0;
  }

  // ============================================================
  // RATING
  // ============================================================

  String get productRating {
    final dynamic rating =
    widget.product['rating'];

    if (rating is Map) {
      return rating['rate']?.toString() ?? '0';
    }

    return rating?.toString() ?? '0';
  }

  // ============================================================
  // REVIEW COUNT
  // ============================================================

  String get productReviewCount {
    final dynamic reviewCount =
    widget.product['reviewCount'];

    if (reviewCount != null) {
      return reviewCount.toString();
    }

    final dynamic rating =
    widget.product['rating'];

    if (rating is Map) {
      return rating['count']?.toString() ?? '0';
    }

    return '0';
  }

  // ============================================================
  // PRODUCT ID
  // ============================================================

  int get productId {
    return int.tryParse(
      widget.product['id']?.toString() ?? '0',
    ) ??
        0;
  }

  // ============================================================
  // INIT
  // ============================================================

  @override
  void initState() {
    super.initState();

    final sizes = getAvailableSizes();

    if (sizes.isNotEmpty) {
      selectedSize = sizes.first;
    }

    loadSimilarProducts();
  }

  // ============================================================
  // GET AVAILABLE SIZES
  // ============================================================

  List<String> getAvailableSizes() {
    final String name =
    productName.toLowerCase();

    final String category =
    productCategory.toLowerCase();

    // SHOES
    if (category == "men's shoes" ||
        name.contains('shoe') ||
        name.contains('sneaker') ||
        name.contains('nike')) {
      return [
        '6 UK',
        '7 UK',
        '8 UK',
        '9 UK',
        '10 UK',
      ];
    }

    // CLOTHES
    if (category == "women's clothing" ||
        category == "men's clothing" ||
        name.contains('dress') ||
        name.contains('shirt') ||
        name.contains('jacket') ||
        name.contains('clothing')) {
      return [
        'S',
        'M',
        'L',
        'XL',
        'XXL',
      ];
    }

    // DEFAULT
    return [
      'S',
      'M',
      'L',
      'XL',
    ];
  }

  // ============================================================
  // LOAD SIMILAR PRODUCTS
  // ============================================================

  Future<void> loadSimilarProducts() async {
    try {
      final List<Map<String, dynamic>> products =
      await ProductApi.getProducts();

      final String currentCategory =
      productCategory.toLowerCase();

      final int currentProductId =
          productId;

      final List<Map<String, dynamic>> filteredProducts =
      products.where((product) {
        final String category =
            product['category']
                ?.toString()
                .toLowerCase() ??
                '';

        final int id =
            int.tryParse(
              product['id']?.toString() ??
                  '0',
            ) ??
                0;

        // Same category + exclude current product
        return category == currentCategory &&
            id != currentProductId;
      }).toList();

      if (!mounted) {
        return;
      }

      setState(() {
        similarProducts =
            filteredProducts;
        isLoadingSimilarProducts = false;
      });
    } catch (e) {
      debugPrint(
        'Similar Products Error: $e',
      );

      if (!mounted) {
        return;
      }

      setState(() {
        similarProducts = [];
        isLoadingSimilarProducts = false;
      });
    }
  }

  // ============================================================
  // ADD TO CART
  // ============================================================

  void addToCart() {
    if (selectedSize.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Please select a size',
          ),
        ),
      );

      return;
    }

    final Map<String, dynamic>
    productWithDetails =
    Map<String, dynamic>.from(
      widget.product,
    );

    productWithDetails['size'] =
        selectedSize;

    CartData.addToCart(
      productWithDetails,
    );

    setState(() {});

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          '$productName ($selectedSize) added to cart',
        ),
        duration:
        const Duration(seconds: 1),
      ),
    );
  }

  // ============================================================
  // BUY NOW
  // ============================================================

  void buyNow() {
    if (selectedSize.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Please select a size',
          ),
        ),
      );

      return;
    }

    addToCart();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
        const CartPage(),
      ),
    );
  }

  // ============================================================
  // GO TO CART
  // ============================================================

  void goToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
        const CartPage(),
      ),
    ).then((value) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  // ============================================================
  // CART ICON
  // ============================================================

  Widget cartIcon() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          onPressed: goToCart,
          icon: const Icon(
            Icons.shopping_cart_outlined,
            size: 28,
            color: Colors.black,
          ),
        ),

        if (CartData.itemCount > 0)
          Positioned(
            right: 3,
            top: 0,
            child: Container(
              width: 20,
              height: 20,
              alignment:
              Alignment.center,
              decoration:
              const BoxDecoration(
                color: Colors.red,
                shape:
                BoxShape.circle,
              ),
              child: Text(
                '${CartData.itemCount}',
                style:
                const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  // ============================================================
  // SIZE BUTTON
  // ============================================================

  Widget sizeButton(String size) {
    final bool isSelected =
        selectedSize == size;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSize = size;
        });
      },

      child: Container(
        width: 55,
        height: 45,
        padding:
        const EdgeInsets.all(10),
        alignment:
        Alignment.center,

        decoration:
        BoxDecoration(
          color: isSelected
              ? Colors.pink
              : Colors.white,

          borderRadius:
          BorderRadius.circular(8),

          border: Border.all(
            color: Colors.pink,
            width: 1,
          ),
        ),

        child: Text(
          size,
          textAlign:
          TextAlign.center,

          style:
          GoogleFonts.poppins(
            fontSize: 13,
            fontWeight:
            FontWeight.w600,

            color: isSelected
                ? Colors.white
                : Colors.pink,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SIZE OPTIONS
  // ============================================================

  Widget buildSizeOptions() {
    final List<String> sizes =
    getAvailableSizes();

    return Padding(
      padding:
      const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 5,
        bottom: 5,
      ),

      child: Wrap(
        spacing: 16,
        runSpacing: 16,

        children: sizes
            .map(
              (size) =>
              sizeButton(size),
        )
            .toList(),
      ),
    );
  }

  // ============================================================
  // STORE INFO TAG
  // ============================================================

  Widget storeInfoTag(
      String text,
      IconData icon,
      ) {
    return Container(
      padding:
      const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),

      decoration:
      BoxDecoration(
        border: Border.all(
          color:
          Colors.grey.shade300,
        ),

        borderRadius:
        BorderRadius.circular(4),
      ),

      child: Row(
        mainAxisSize:
        MainAxisSize.min,

        children: [
          Icon(
            icon,
            size: 14,
            color: Colors.grey,
          ),

          const SizedBox(width: 4),

          Text(
            text,
            style:
            const TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CUSTOM CART BUTTON
  // ============================================================

  Widget customCartButton({
    required String text,
    required IconData icon,
    required List<Color> colors,
    required Color iconBgColor,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,

      child: SizedBox(
        height: 45,

        child: Stack(
          children: [
            Align(
              alignment:
              Alignment.centerRight,

              child: Container(
                height: 38,

                margin:
                const EdgeInsets.only(
                  left: 15,
                ),

                decoration:
                BoxDecoration(
                  gradient:
                  LinearGradient(
                    colors: colors,
                    begin:
                    Alignment.topCenter,
                    end:
                    Alignment.bottomCenter,
                  ),

                  borderRadius:
                  BorderRadius.circular(
                    5,
                  ),
                ),

                alignment:
                Alignment.center,

                padding:
                const EdgeInsets.only(
                  left: 20,
                ),

                child: Text(
                  text,
                  style:
                  const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),
            ),

            Container(
              width: 42,
              height: 42,

              decoration:
              BoxDecoration(
                color: iconBgColor,
                shape:
                BoxShape.circle,
              ),

              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SIMILAR PRODUCT CARD
  // ============================================================

  Widget similarProductCard(
      Map<String, dynamic> product,
      ) {
    final String image =
        product['image']
            ?.toString() ??
            '';

    final String name =
        product['title']
            ?.toString() ??
            '';

    final String description =
        product['description']
            ?.toString() ??
            '';

    final dynamic price =
    product['price'];

    final String rating =
    product['rating'] is Map
        ? product['rating']['rate']
        ?.toString() ??
        '0'
        : product['rating']
        ?.toString() ??
        '0';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProductDetailScreen(
                  product:
                  Map<String, dynamic>.from(
                    product,
                  ),
                ),
          ),
        );
      },

      child: Container(
        decoration:
        BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(8),
        ),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [
            // ==================================================
            // IMAGE
            // ==================================================

            ClipRRect(
              borderRadius:
              BorderRadius.circular(
                8,
              ),

              child: Image.network(
                image,

                width:
                double.infinity,

                height: 150,

                fit: BoxFit.contain,

                errorBuilder:
                    (
                    context,
                    error,
                    stackTrace,
                    ) {
                  return const SizedBox(
                    height: 150,
                    child: Center(
                      child: Icon(
                        Icons
                            .image_not_supported_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),

            // ==================================================
            // PRODUCT INFORMATION
            // ==================================================

            Padding(
              padding:
              const EdgeInsets.all(
                8,
              ),

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [
                  Text(
                    name,

                    maxLines: 1,

                    overflow:
                    TextOverflow
                        .ellipsis,

                    style:
                    const TextStyle(
                      fontWeight:
                      FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(
                    height: 3,
                  ),

                  Text(
                    description,

                    maxLines: 2,

                    overflow:
                    TextOverflow
                        .ellipsis,

                    style:
                    const TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),

                  const SizedBox(
                    height: 5,
                  ),

                  // ==================================================
                  // PRICE
                  // ==================================================

                  Text(
                    '₹${double.tryParse(price?.toString() ?? '0')?.toStringAsFixed(0) ?? '0'}',

                    style:
                    const TextStyle(
                      fontWeight:
                      FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(
                    height: 5,
                  ),

                  // ==================================================
                  // RATING
                  // ==================================================

                  Row(
                    children: [
                      ...List.generate(
                        4,
                            (index) =>
                        const Icon(
                          Icons.star,
                          size: 12,
                          color:
                          Colors.amber,
                        ),
                      ),

                      const Icon(
                        Icons.star_half,
                        size: 12,
                        color:
                        Colors.amber,
                      ),

                      const SizedBox(
                        width: 4,
                      ),

                      Text(
                        rating,

                        style:
                        const TextStyle(
                          color:
                          Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SIMILAR PRODUCTS SECTION
  // ============================================================

  Widget buildSimilarProducts() {
    if (isLoadingSimilarProducts) {
      return const Padding(
        padding:
        EdgeInsets.symmetric(
          vertical: 30,
        ),

        child: Center(
          child:
          CircularProgressIndicator(),
        ),
      );
    }

    if (similarProducts.isEmpty) {
      return Padding(
        padding:
        const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20,
        ),

        child: Text(
          'No similar products found',
          style:
          GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      );
    }

    return Padding(
      padding:
      const EdgeInsets.symmetric(
        horizontal: 10,
      ),

      child:
      MasonryGridView.count(
        shrinkWrap: true,

        physics:
        const NeverScrollableScrollPhysics(),

        crossAxisCount: 2,

        mainAxisSpacing: 10,

        crossAxisSpacing: 10,

        itemCount:
        similarProducts.length,

        itemBuilder:
            (context, index) {
          return similarProductCard(
            similarProducts[index],
          );
        },
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xFFF9F9F9),



      appBar: AppBar(
        backgroundColor:
        Colors.white,

        elevation: 0,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },

          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),

        title: Text(
          'Product Details',

          style:
          GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight:
            FontWeight.w600,
          ),
        ),

        actions: [
          cartIcon(),

          const SizedBox(
            width: 8,
          ),
        ],
      ),



      body:
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [


            SizedBox(
              height: 300,

              child: Image.network(
                productImage,

                width:
                double.infinity,

                fit: BoxFit.contain,

                loadingBuilder:
                    (
                    context,
                    child,
                    loadingProgress,
                    ) {
                  if (loadingProgress ==
                      null) {
                    return child;
                  }

                  return const Center(
                    child:
                    CircularProgressIndicator(),
                  );
                },

                errorBuilder:
                    (
                    context,
                    error,
                    stackTrace,
                    ) {
                  return const Center(
                    child: Icon(
                      Icons
                          .image_not_supported_outlined,
                      size: 50,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(
              height: 15,
            ),



            Padding(
              padding:
              const EdgeInsets
                  .symmetric(
                horizontal: 15,
              ),

              child: Text(
                selectedSize.isEmpty
                    ? 'Select Size'
                    : 'Select Size: $selectedSize',

                style:
                const TextStyle(
                  fontWeight:
                  FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            buildSizeOptions(),

            const SizedBox(
              height: 20,
            ),



            Padding(
              padding:
              const EdgeInsets
                  .symmetric(
                horizontal: 15,
              ),

              child: Text(
                productName,

                style:
                const TextStyle(
                  fontSize: 22,
                  fontWeight:
                  FontWeight.w900,
                ),
              ),
            ),



            Padding(
              padding:
              const EdgeInsets
                  .symmetric(
                horizontal: 15,
              ),

              child: Text(
                productCategory,

                style:
                const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
            ),

            const SizedBox(
              height: 5,
            ),



            Padding(
              padding:
              const EdgeInsets
                  .symmetric(
                horizontal: 15,
              ),

              child: Text(
                productDescription,

                style:
                const TextStyle(
                  fontSize: 14,
                  color:
                  Colors.black87,
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),



            Padding(
              padding:
              const EdgeInsets
                  .symmetric(
                horizontal: 15,
              ),

              child: Row(
                children: [
                  ...List.generate(
                    4,
                        (index) =>
                    const Icon(
                      Icons.star,
                      color:
                      Colors.amber,
                      size: 20,
                    ),
                  ),

                  const Icon(
                    Icons.star_half,
                    color:
                    Colors.amber,
                    size: 20,
                  ),

                  const SizedBox(
                    width: 5,
                  ),

                  Text(
                    productRating,

                    style:
                    const TextStyle(
                      color:
                      Colors.grey,
                    ),
                  ),

                  const SizedBox(
                    width: 5,
                  ),

                  Text(
                    '($productReviewCount)',

                    style:
                    const TextStyle(
                      color:
                      Colors.grey,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 10,
            ),


            Padding(
              padding:
              const EdgeInsets
                  .symmetric(
                horizontal: 15,
              ),

              child: Row(
                children: [
                  Text(
                    '₹${productPrice.toStringAsFixed(0)}',

                    style:
                    const TextStyle(
                      fontSize: 20,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    width: 8,
                  ),

                  if (productOldPrice >
                      0)
                    Text(
                      '₹${productOldPrice.toStringAsFixed(0)}',

                      style:
                      const TextStyle(
                        fontSize: 13,
                        color:
                        Colors.grey,
                        decoration:
                        TextDecoration
                            .lineThrough,
                      ),
                    ),

                  const SizedBox(
                    width: 8,
                  ),

                  if (productDiscount >
                      0)
                    Text(
                      '${productDiscount.toStringAsFixed(0)}% OFF',

                      style:
                      const TextStyle(
                        fontSize: 12,
                        fontWeight:
                        FontWeight.bold,
                        color:
                        Colors.green,
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(
              height: 15,
            ),




            const SizedBox(
              height: 15,
            ),



            Padding(
              padding:
              const EdgeInsets
                  .symmetric(
                horizontal: 15,
              ),

              child: Wrap(
                spacing: 10,

                children: [
                  storeInfoTag(
                    'Nearest Store',
                    Icons
                        .location_on_outlined,
                  ),

                  storeInfoTag(
                    'VIP',
                    Icons.lock_outline,
                  ),

                  storeInfoTag(
                    'Return policy',
                    Icons.refresh,
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),



            Padding(
              padding:
              const EdgeInsets
                  .symmetric(
                horizontal: 15,
              ),

              child: Row(
                children: [
                  Expanded(
                    child:
                    customCartButton(
                      text:
                      'Add cart',

                      icon: Icons
                          .shopping_cart_outlined,

                      colors:
                      const [
                        Color(0xFF4A90E2),
                        Color(0xFF1B5EBD),
                      ],

                      iconBgColor:
                      const Color(
                        0xFF1565C0,
                      ),

                      onPressed:
                      addToCart,
                    ),
                  ),

                  const SizedBox(
                    width: 15,
                  ),

                  Expanded(
                    child:
                    customCartButton(
                      text:
                      'Buy Now',

                      icon: Icons
                          .touch_app_outlined,

                      colors:
                      const [
                        Color(0xFF52D38A),
                        Color(0xFF38B473),
                      ],

                      iconBgColor:
                      const Color(
                        0xFF2E8B57,
                      ),

                      onPressed:
                      buyNow,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),



            Container(
              width:
              double.infinity,

              margin:
              const EdgeInsets
                  .symmetric(
                horizontal: 15,
              ),

              padding:
              const EdgeInsets.all(
                15,
              ),

              decoration:
              BoxDecoration(
                color:
                const Color(
                  0xFFFFDDE3,
                ),

                borderRadius:
                BorderRadius.circular(
                  8,
                ),
              ),

              child:
              const Column(
                crossAxisAlignment:
                CrossAxisAlignment
                    .start,

                children: [
                  Text(
                    'Delivery in',

                    style:
                    TextStyle(
                      fontSize: 14,
                    ),
                  ),

                  Text(
                    '1 within Hour',

                    style:
                    TextStyle(
                      fontSize: 22,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),



            Padding(
              padding:
              const EdgeInsets
                  .symmetric(
                horizontal: 15,
              ),

              child: Row(
                children: [
                  Expanded(
                    child:
                    OutlinedButton.icon(
                      onPressed: () {
                        // Scrolls to Similar To section
                      },

                      icon:
                      const Icon(
                        Icons
                            .visibility_outlined,
                        color:
                        Colors.black,
                        size: 18,
                      ),

                      label:
                      const Text(
                        'View Similar',

                        style:
                        TextStyle(
                          color:
                          Colors.black,
                        ),
                      ),

                      style:
                      OutlinedButton
                          .styleFrom(
                        backgroundColor:
                        Colors.white,

                        side:
                        const BorderSide(
                          color: Colors
                              .transparent,
                        ),

                        padding:
                        const EdgeInsets
                            .symmetric(
                          vertical: 15,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  Expanded(
                    child:
                    OutlinedButton.icon(
                      onPressed: () {},

                      icon:
                      const Icon(
                        Icons
                            .compare_arrows,
                        color:
                        Colors.black,
                        size: 18,
                      ),

                      label:
                      const Text(
                        'Add to Compare',

                        style:
                        TextStyle(
                          color:
                          Colors.black,
                        ),
                      ),

                      style:
                      OutlinedButton
                          .styleFrom(
                        backgroundColor:
                        Colors.white,

                        side:
                        const BorderSide(
                          color: Colors
                              .transparent,
                        ),

                        padding:
                        const EdgeInsets
                            .symmetric(
                          vertical: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 30,
            ),



            const Padding(
              padding:
              EdgeInsets.symmetric(
                horizontal: 15,
              ),

              child: Text(
                'Similar To',

                style:
                TextStyle(
                  fontSize: 20,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(
              height: 8,
            ),



            Padding(
              padding:
              const EdgeInsets
                  .symmetric(
                horizontal: 15,
              ),

              child: Row(
                mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,

                children: [
                  Text(
                    '${similarProducts.length}+ Items',

                    style:
                    const TextStyle(
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  Row(
                    children: [
                      _smallTag(
                        'Sort',
                        Icons.swap_vert,
                      ),

                      const SizedBox(
                        width: 10,
                      ),

                      _smallTag(
                        'Filter',
                        Icons
                            .filter_alt_outlined,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 15,
            ),



            buildSimilarProducts(),

            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }


  Widget _smallTag(
      String text,
      IconData icon,
      ) {
    return Container(
      padding:
      const EdgeInsets
          .symmetric(
        horizontal: 8,
        vertical: 5,
      ),

      decoration:
      BoxDecoration(
        color: Colors.white,

        borderRadius:
        BorderRadius.circular(5),
      ),

      child: Row(
        children: [
          Text(
            text,

            style:
            const TextStyle(
              fontSize: 12,
            ),
          ),

          const SizedBox(
            width: 4,
          ),

          Icon(
            icon,
            size: 14,
          ),
        ],
      ),
    );
  }
}