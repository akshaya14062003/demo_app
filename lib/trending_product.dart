import 'package:demo_app/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:demo_app/cart_data.dart';
import 'package:demo_app/cart_page.dart';
import 'package:demo_app/product_details.dart';
import 'package:demo_app/services/product_api.dart';

class TrendingProduct extends StatefulWidget {
  final bool showDiscount;
  final bool showPrice;
  final bool showDescription;
  final bool showOldPrice;

  const TrendingProduct({
    super.key,
    this.showDiscount = false,
    this.showPrice = false,
    this.showDescription = false,
    this.showOldPrice = false,
  });

  @override
  State<TrendingProduct> createState() =>
      _TrendingProductState();
}

class _TrendingProductState extends State<TrendingProduct> {
  List<Map<String, dynamic>> products = [];
  List<Map<String, dynamic>> displayedProducts = [];

  bool isLoading = true;

  final TextEditingController searchController =
  TextEditingController();

  String selectedSort = 'Sort';

  double minPrice = 0;
  double maxPrice = 2000;

  @override
  void initState() {
    super.initState();
    loadProducts();

    searchController.addListener(() {
      filterProducts();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> loadProducts() async {
    try {
      final data = await ProductApi.getProducts();

      final List<Map<String, dynamic>> convertedProducts =
      data.map<Map<String, dynamic>>((product) {
        return convertApiProduct(product);
      }).toList();

      if (!mounted) return;

      setState(() {
        products = convertedProducts;
        displayedProducts =
        List<Map<String, dynamic>>.from(
          convertedProducts,
        );

        isLoading = false;
      });
    } catch (e) {
      debugPrint('Product API Error: $e');

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Unable to load products',
            style: GoogleFonts.poppins(),
          ),
        ),
      );
    }
  }


  Map<String, dynamic> convertApiProduct(
      Map<String, dynamic> product,
      ) {
    final double price =
        double.tryParse(
          product['price']?.toString() ?? '0',
        ) ??
            0;

    // Discount value
    const double discount = 20;

    // Calculate old price from discount
    final double oldPrice =
        price / (1 - discount / 100);

    final dynamic ratingData = product['rating'];

    String rating = '4.5';
    String reviewCount = '120';

    if (ratingData is Map) {
      rating =
          ratingData['rate']?.toString() ?? '4.5';

      reviewCount =
          ratingData['count']?.toString() ?? '120';
    }

    return {
      'id': product['id'],
      'image':
      product['image']?.toString() ?? '',
      'name':
      product['title']?.toString() ??
          'Product',
      'description':
      product['description']?.toString() ?? '',
      'category':
      product['category']?.toString() ?? '',

      // Selling price
      'price': price,

      // Old price
      'oldPrice': oldPrice,

      // Discount
      'discount': discount,

      // Rating
      'rating': rating,

      // Reviews
      'reviewCount': reviewCount,
    };
  }


  double getPrice(
      Map<String, dynamic> product,
      ) {
    final dynamic price = product['price'];

    if (price is num) {
      return price.toDouble();
    }

    return double.tryParse(
      price?.toString() ?? '0',
    ) ??
        0;
  }



  double getOldPrice(
      Map<String, dynamic> product,
      ) {
    final dynamic oldPrice =
    product['oldPrice'];

    if (oldPrice is num) {
      return oldPrice.toDouble();
    }

    return double.tryParse(
      oldPrice?.toString() ?? '0',
    ) ??
        0;
  }



  double getDiscount(
      Map<String, dynamic> product,
      ) {
    final dynamic discount =
    product['discount'];

    if (discount is num) {
      return discount.toDouble();
    }

    return double.tryParse(
      discount?.toString() ?? '0',
    ) ??
        0;
  }



  void filterProducts() {
    final String query =
    searchController.text
        .toLowerCase()
        .trim();

    List<Map<String, dynamic>> filtered =
    List<Map<String, dynamic>>.from(
      products,
    );

    // SEARCH
    if (query.isNotEmpty) {
      filtered = filtered.where((product) {
        final String name =
            product['name']
                ?.toString()
                .toLowerCase() ??
                '';

        final String category =
            product['category']
                ?.toString()
                .toLowerCase() ??
                '';

        return name.contains(query) ||
            category.contains(query);
      }).toList();
    }

    // PRICE FILTER
    filtered = filtered.where((product) {
      final double price = getPrice(product);

      return price >= minPrice &&
          price <= maxPrice;
    }).toList();

    // SORT
    if (selectedSort == 'A-Z') {
      filtered.sort(
            (a, b) => a['name']
            .toString()
            .toLowerCase()
            .compareTo(
          b['name']
              .toString()
              .toLowerCase(),
        ),
      );
    }

    if (selectedSort == 'Z-A') {
      filtered.sort(
            (a, b) => b['name']
            .toString()
            .toLowerCase()
            .compareTo(
          a['name']
              .toString()
              .toLowerCase(),
        ),
      );
    }

    if (selectedSort == 'Low-High') {
      filtered.sort(
            (a, b) =>
            getPrice(a).compareTo(
              getPrice(b),
            ),
      );
    }

    if (selectedSort == 'High-Low') {
      filtered.sort(
            (a, b) =>
            getPrice(b).compareTo(
              getPrice(a),
            ),
      );
    }

    setState(() {
      displayedProducts = filtered;
    });
  }



  void clearFilter() {
    setState(() {
      selectedSort = 'Sort';
      minPrice = 0;
      maxPrice = 2000;

      displayedProducts =
      List<Map<String, dynamic>>.from(
        products,
      );
    });
  }



  Widget productCard(
      Map<String, dynamic> product,
      ) {
    final String image =
        product['image']?.toString() ?? '';

    final String name =
        product['name']?.toString() ??
            'Product';

    final String description =
        product['description']
            ?.toString() ??
            '';

    final double price =
    getPrice(product);

    final double oldPrice =
    getOldPrice(product);

    final double discount =
    getDiscount(product);

    final String rating =
        product['rating']?.toString() ??
            '4.5';

    final String reviewCount =
        product['reviewCount']
            ?.toString() ??
            '120';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProductDetailScreen(
                  product: product,
                ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withValues(alpha: 0.06),
              blurRadius: 5,
              offset:
              const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [


            ClipRRect(
              borderRadius:
              const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              child: AspectRatio(
                aspectRatio: 0.92,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: image.isNotEmpty
                          ? Image.network(
                        image,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (
                            context,
                            error,
                            stackTrace,
                            ) {
                          return Container(
                            color:
                            Colors.grey.shade200,
                            child: const Icon(
                              Icons
                                  .image_not_supported,
                              color:
                              Colors.grey,
                              size: 35,
                            ),
                          );
                        },
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

                          return Container(
                            color:
                            Colors.grey.shade100,
                            child:
                            const Center(
                              child:
                              CircularProgressIndicator(
                                strokeWidth:
                                2,
                              ),
                            ),
                          );
                        },
                      )
                          : Container(
                        color:
                        Colors.grey.shade200,
                        child: const Icon(
                          Icons.image,
                          color:
                          Colors.grey,
                          size: 35,
                        ),
                      ),
                    ),


                  ],
                ),
              ),
            ),



            Padding(
              padding:
              const EdgeInsets.fromLTRB(
                8,
                7,
                8,
                8,
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  // NAME
                  Text(
                    name,
                    maxLines: 1,
                    overflow:
                    TextOverflow.ellipsis,
                    style:
                    GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight:
                      FontWeight.w600,
                      color:
                      const Color(0xff222222),
                    ),
                  ),

                  const SizedBox(height: 3),

                  // DESCRIPTION
                  Text(
                    description,
                    maxLines: 2,
                    overflow:
                    TextOverflow.ellipsis,
                    style:
                    GoogleFonts.poppins(
                      fontSize: 8.5,
                      height: 1.3,
                      color:
                      Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 5),

                  // PRICE ROW
                  Row(
                    children: [
                      Text(
                        '₹${price.toStringAsFixed(0)}',
                        style:
                        GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight:
                          FontWeight.w700,
                        ),
                      ),

                      const SizedBox(width: 5),

                      Text(
                        '₹${oldPrice.toStringAsFixed(0)}',
                        style:
                        GoogleFonts.poppins(
                          fontSize: 8,
                          color:
                          Colors.grey.shade500,
                          decoration:
                          TextDecoration
                              .lineThrough,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 3),

                  // DISCOUNT TEXT
                  Text(
                    '${discount.toStringAsFixed(0)}% OFF',
                    style:
                    GoogleFonts.poppins(
                      fontSize: 8,
                      fontWeight:
                      FontWeight.w600,
                      color:
                      Colors.green.shade600,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // RATING
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 12,
                        color:
                        Color(0xffffc107),
                      ),

                      const SizedBox(width: 2),

                      Text(
                        rating,
                        style:
                        GoogleFonts.poppins(
                          fontSize: 8,
                          fontWeight:
                          FontWeight.w600,
                        ),
                      ),

                      const SizedBox(width: 3),

                      Text(
                        '($reviewCount reviews)',
                        style:
                        GoogleFonts.poppins(
                          fontSize: 7,
                          color:
                          Colors.grey.shade500,
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



  Widget sortButton() {
    return PopupMenuButton<String>(
      offset: const Offset(0, 40),
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(8),
      ),
      onSelected: (value) {
        setState(() {
          selectedSort = value;
        });

        filterProducts();
      },
      itemBuilder: (context) {
        return const [
          PopupMenuItem(
            value: 'A-Z',
            child: Text('A - Z'),
          ),
          PopupMenuItem(
            value: 'Z-A',
            child: Text('Z - A'),
          ),
          PopupMenuItem(
            value: 'Low-High',
            child: Text(
              'Price Low - High',
            ),
          ),
          PopupMenuItem(
            value: 'High-Low',
            child: Text(
              'Price High - Low',
            ),
          ),
        ];
      },
      child: Container(
        height: 30,
        padding:
        const EdgeInsets.symmetric(
          horizontal: 9,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(7),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
        child: Row(
          children: [
            Text(
              selectedSort == 'Sort'
                  ? 'Sort'
                  : selectedSort,
              style:
              GoogleFonts.poppins(
                fontSize: 9,
                fontWeight:
                FontWeight.w500,
              ),
            ),
            const SizedBox(width: 3),
            const Icon(
              Icons.swap_vert,
              size: 13,
            ),
          ],
        ),
      ),
    );
  }


  Widget filterButton() {
    return GestureDetector(
      onTap: showFilterSheet,
      child: Container(
        height: 30,
        padding:
        const EdgeInsets.symmetric(
          horizontal: 9,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(7),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
        child: Row(
          children: [
            Text(
              'Filter',
              style:
              GoogleFonts.poppins(
                fontSize: 9,
                fontWeight:
                FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.filter_alt_outlined,
              size: 13,
            ),
          ],
        ),
      ),
    );
  }



  void showFilterSheet() {
    double tempMin = minPrice;
    double tempMax = maxPrice;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape:
      const RoundedRectangleBorder(
        borderRadius:
        BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (
              context,
              setModalState,
              ) {
            return Padding(
              padding:
              const EdgeInsets.all(20),
              child: Column(
                mainAxisSize:
                MainAxisSize.min,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    'Filter Products',
                    style:
                    GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight:
                      FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    '₹${tempMin.toStringAsFixed(0)} - ₹${tempMax.toStringAsFixed(0)}',
                    style:
                    GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight:
                      FontWeight.w600,
                    ),
                  ),

                  RangeSlider(
                    min: 0,
                    max: 2000,
                    divisions: 20,
                    values: RangeValues(
                      tempMin,
                      tempMax,
                    ),
                    onChanged: (values) {
                      setModalState(() {
                        tempMin =
                            values.start;
                        tempMax =
                            values.end;
                      });
                    },
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width:
                    double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          minPrice = tempMin;
                          maxPrice = tempMax;
                        });

                        filterProducts();

                        Navigator.pop(
                          context,
                        );
                      },
                      style:
                      ElevatedButton.styleFrom(
                        backgroundColor:
                        const Color(
                          0xff222222,
                        ),
                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(
                            10,
                          ),
                        ),
                      ),
                      child: Text(
                        'Apply Filter',
                        style:
                        GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight:
                          FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xfff8f8f8),
appBar:const CustomAppBar(),
      body: SafeArea(
        child: Column(
          children: [

            Padding(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 18,
              ),
              child: Container(
                height: 40,
                decoration:
                BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(
                    7,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withValues(
                        alpha: 0.04,
                      ),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: TextField(
                  controller:
                  searchController,
                  style:
                  GoogleFonts.poppins(
                    fontSize: 10,
                  ),
                  decoration:
                  InputDecoration(
                    hintText:
                    'Search any Product...',
                    hintStyle:
                    GoogleFonts.poppins(
                      fontSize: 9,
                      color:
                      Colors.grey.shade400,
                    ),
                    prefixIcon:
                    const Icon(
                      Icons.search,
                      size: 17,
                      color:
                      Colors.grey,
                    ),
                    suffixIcon:
                    const Icon(
                      Icons.mic_none,
                      size: 17,
                      color:
                      Colors.grey,
                    ),
                    border:
                    InputBorder.none,
                    contentPadding:
                    const EdgeInsets
                        .symmetric(
                      vertical: 11,
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding:
              const EdgeInsets.fromLTRB(
                18,
                12,
                18,
                9,
              ),
              child: Row(
                children: [
                  Text(
                    '${displayedProducts.length} Items',
                    style:
                    GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight:
                      FontWeight.w700,
                    ),
                  ),

                  const Spacer(),

                  sortButton(),

                  const SizedBox(width: 6),

                  filterButton(),
                ],
              ),
            ),



            Expanded(
              child: isLoading
                  ? const Center(
                child:
                CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
                  : displayedProducts
                  .isEmpty
                  ? Center(
                child: Text(
                  'No products found',
                  style:
                  GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight:
                    FontWeight.w500,
                  ),
                ),
              )
                  : Padding(
                padding:
                const EdgeInsets
                    .symmetric(
                  horizontal: 18,
                ),
                child:
                MasonryGridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  itemCount:
                  displayedProducts
                      .length,
                  itemBuilder:
                      (
                      context,
                      index,
                      ) {
                    return productCard(
                      displayedProducts[
                      index],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),



    );
  }
}