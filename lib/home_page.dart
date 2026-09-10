import 'package:demo_app/custom_appbar.dart';
import 'package:demo_app/dash.dart';
import 'package:demo_app/product_details.dart';
import 'package:demo_app/trending_product.dart';
import 'package:demo_app/favorite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'favorite_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> displayedDress = [];



  final List<Map<String, String>> categories = [
    {
      "image": "assets/image10.png",
      "name": "Beauty",
    },
    {
      "image": "assets/image11.png",
      "name": "Fashion",
    },
    {
      "image": "assets/image12.png",
      "name": "Kids",
    },
    {
      "image": "assets/image13.png",
      "name": "Mens",
    },
    {
      "image": "assets/image14.png",
      "name": "Womens",
    },
  ];



  final List<Map<String, String>> dress = [
    {
      "image": "assets/image15.png",
      "name": "shoe",
      "description":
      "Neque porro quisquam est qui dolorem ipsum quia",
      "price": "₹1500",
      "oldPrice": "₹2499",
      "discount": "40%Off",
      "rating": "56890",
    },
    {
      "image": "assets/image16.png",
      "name": "kurti",
      "description":
      "Neque porro quisquam est qui dolorem ipsum quia",
      "price": "₹2499",
      "oldPrice": "₹4999",
      "discount": "50%Off",
      "rating": "344567",
    },
    {
      "image": "assets/image17.png",
      "name": "Stylish Saree",
      "description":
      "Stylish saree for your everyday walk",
      "price": "₹5500",
      "oldPrice": "₹7500",
      "discount": "60%Off",
      "rating": "45678",
    },
    {
      "image": "assets/image18.png",
      "name": "Lehanga",
      "description":
      "Latest fashion dress at affordable price",
      "price": "₹1500",
      "oldPrice": "₹2499",
      "discount": "40%Off",
      "rating": "25690",
    },
  ];



  final List<Map<String, String>> smallProducts = [
    {
      "image": "assets/image17.png",
      "name": "saree",
      "price": "₹2499",
    },
    {
      "image": "assets/image18.png",
      "name": "Leghanga",
      "price": "₹1999",
    },
    {
      "image": "assets/image15.png",
      "name": "Kurta",
      "price": "₹3500",
    },
    {
      "image": "assets/image16.png",
      "name": "Saree",
      "price": "₹5500",
    },
  ];



  @override
  void initState() {
    super.initState();
    displayedDress = List.from(dress);
  }


  Widget _buildFavoriteIcon(Map<String, String> product) {
    final productName = product["name"] ?? "";

    // Pre-calculate to avoid redundant calls in the build path
    final bool isFavorite = FavoriteData.isFavorite(productName);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isFavorite) {
            FavoriteData.removeFavorite(productName);
            Fluttertoast.showToast(
              msg: "$productName removed from favorites",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black87,
              textColor: Colors.white,
            );
          } else {
            FavoriteData.addFavorite(product);
            Fluttertoast.showToast(
              msg: "$productName added to favorites",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black87,
              textColor: Colors.white,
            );
          }
        });
      },
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 5,
            ),
          ],
        ),
        child: Icon(
          isFavorite
              ? Icons.favorite
              : Icons.favorite_border,
          color: isFavorite
              ? Colors.red
              : Colors.grey,
          size: 21,
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        drawer: const dash(),
        backgroundColor: const Color(0xfff8f8f8),
        appBar: const CustomAppBar(),

        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Search any Product",
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      suffixIcon: const Icon(
                        Icons.mic,
                        color: Colors.grey,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                      const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),


                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Row(
                    children: [

                      const Expanded(
                        child: Text(
                          "All Featured",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // SORT
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Column(
                                mainAxisSize:
                                MainAxisSize.min,
                                children: [

                                  const Padding(
                                    padding:
                                    EdgeInsets.all(15),
                                    child: Text(
                                      "Sort By",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight:
                                        FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  ListTile(
                                    title:
                                    const Text("A - Z"),
                                    onTap: () {
                                      setState(() {
                                        displayedDress.sort(
                                              (a, b) =>
                                              a["name"]!
                                                  .compareTo(
                                                b["name"]!,
                                              ),
                                        );
                                      });

                                      Navigator.pop(
                                          context);
                                    },
                                  ),

                                  ListTile(
                                    title:
                                    const Text("Z - A"),
                                    onTap: () {
                                      setState(() {
                                        displayedDress.sort(
                                              (a, b) =>
                                              b["name"]!
                                                  .compareTo(
                                                a["name"]!,
                                              ),
                                        );
                                      });

                                      Navigator.pop(
                                          context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          padding:
                          const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.circular(8),
                          ),
                          child: const Row(
                            children: [
                              Text("Sort"),
                              SizedBox(width: 4),
                              Icon(
                                Icons.swap_vert,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      // FILTER
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Column(
                                mainAxisSize:
                                MainAxisSize.min,
                                children: [

                                  const Padding(
                                    padding:
                                    EdgeInsets.all(15),
                                    child: Text(
                                      "Filter",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight:
                                        FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  ListTile(
                                    title: const Text(
                                      "₹100 - ₹2000",
                                    ),
                                    onTap: () {
                                      setState(() {
                                        displayedDress =
                                            dress.where(
                                                  (item) {
                                                int price =
                                                int.parse(
                                                  item["price"]!
                                                      .replaceAll(
                                                    RegExp(
                                                        r"[^0-9]"),
                                                    "",
                                                  ),
                                                );

                                                return price >=
                                                    100 &&
                                                    price <=
                                                        2000;
                                              },
                                            ).toList();
                                      });

                                      Navigator.pop(
                                          context);
                                    },
                                  ),

                                  ListTile(
                                    title: const Text(
                                      "Clear Filter",
                                    ),
                                    onTap: () {
                                      setState(() {
                                        displayedDress =
                                            List.from(dress);
                                      });

                                      Navigator.pop(
                                          context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          padding:
                          const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.circular(8),
                          ),
                          child: const Row(
                            children: [
                              Text("Filter"),
                              SizedBox(width: 4),
                              Icon(
                                Icons.filter_alt_outlined,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  height: 105,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final item = categories[index];

                      return Container(
                        width: 75,
                        margin:
                        const EdgeInsets.symmetric(
                          horizontal: 7,
                        ),
                        child: Column(
                          children: [

                            CircleAvatar(
                              radius: 30,
                              backgroundImage:
                              AssetImage(
                                item["image"]!,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              item["name"]!,
                              textAlign:
                              TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),



                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child:GestureDetector(
                       onTap: () {
                   Navigator.push(
                   context,
                      MaterialPageRoute(
                     builder: (context) =>const TrendingProduct(
                       showDiscount: true,
                       showPrice: true,
                       showOldPrice: true,
                     ),
                   ),
                   );
                   },
                    child:
                  ClipRRect(
                    borderRadius:
                    BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/Banner1image.png",
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                ),

                const SizedBox(height: 15),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius:
                      BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [

                        const Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [

                            Text(
                              "Deal of the Day",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 3),

                            Text(
                              "50% OFF",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),

                        Container(
                          padding:
                          const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.circular(5),
                          ),
                          child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const TrendingProduct(showDescription: true,
                                  showOldPrice: true,
                                  showPrice:true,

                                ),


                              ),
                            );
                          },
                          child:
                          const Text(
                            "View All",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),



                SizedBox(
                  height: 390,
                  child: ListView.builder(
                    scrollDirection:
                    Axis.horizontal,
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    itemCount:
                    displayedDress.length,
                    itemBuilder: (context, index) {

                      final item =
                      displayedDress[index];

                      final productName =
                      item["name"]!;

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                product: item,
                              ),
                            ),
                          ).then((value) {
                            setState(() {});
                          });
                        },
                        child: Container(
                          width: 220,
                          margin:
                          const EdgeInsets.only(
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color:
                              Colors.grey.shade300,
                            ),
                            borderRadius:
                            BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [

                              // IMAGE + HEART
                              Stack(
                                children: [

                                  ClipRRect(
                                    borderRadius:
                                    const BorderRadius
                                        .only(
                                      topLeft:
                                      Radius.circular(8),
                                      topRight:
                                      Radius.circular(8),
                                    ),
                                    child: Image.asset(
                                      item["image"]!,
                                      width:
                                      double.infinity,
                                      height: 220,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  // ❤️ TOP RIGHT
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child:
                                    _buildFavoriteIcon(
                                      item,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 7),

                              Padding(
                                padding:
                                const EdgeInsets
                                    .symmetric(
                                  horizontal: 8,
                                ),
                                child: Text(
                                  productName,
                                  maxLines: 1,
                                  overflow:
                                  TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight:
                                    FontWeight.w500,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 4),

                              Padding(
                                padding:
                                const EdgeInsets
                                    .symmetric(
                                  horizontal: 8,
                                ),
                                child: Text(
                                  item["description"]!,
                                  maxLines: 2,
                                  overflow:
                                  TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 4),

                              Padding(
                                padding:
                                const EdgeInsets
                                    .symmetric(
                                  horizontal: 8,
                                ),
                                child: Text(
                                  item["price"]!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight:
                                    FontWeight.w500,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 2),

                              Padding(
                                padding:
                                const EdgeInsets
                                    .symmetric(
                                  horizontal: 8,
                                ),
                                child: Row(
                                  children: [

                                    Text(
                                      item["oldPrice"]!,
                                      style:
                                      const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        decoration:
                                        TextDecoration
                                            .lineThrough,
                                      ),
                                    ),

                                    const SizedBox(width: 7),

                                    Text(
                                      item["discount"]!,
                                      style:
                                      const TextStyle(
                                        fontSize: 12,
                                        color:
                                        Colors.redAccent,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 3),

                              Padding(
                                padding:
                                const EdgeInsets
                                    .symmetric(
                                  horizontal: 8,
                                ),
                                child: Row(
                                  children: [

                                    ...List.generate(
                                      5,
                                          (index) =>
                                      const Icon(
                                        Icons.star,
                                        color:
                                        Colors.amber,
                                        size: 16,
                                      ),
                                    ),

                                    const SizedBox(width: 4),

                                    Text(
                                      item["rating"]!,
                                      style:
                                      const TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 15),



                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Row(
                    children: [

                      SizedBox(
                        width: 95,
                        height: 75,
                        child: Image.asset(
                          "assets/image23.png",
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(width: 28),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [

                            Row(
                              children: [

                                const Text(
                                  "Special Offers",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight:
                                    FontWeight.w500,
                                  ),
                                ),

                                const SizedBox(width: 8),

                                Container(
                                  width: 25,
                                  height: 25,
                                  decoration:
                                  BoxDecoration(
                                    shape:
                                    BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "😎",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 5),

                            const Text(
                              "We make sure you get the\n"
                                  "offer you need at best prices",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 5),



                Center(
                  child: Image.asset(
                    "assets/image25.png",
                    width: 400,
                    height: 150,
                    fit: BoxFit.cover,

                  ),
                ),

                const SizedBox(height: 15),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius:
                      BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [

                        const Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [

                            Text(
                              "Trending products",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 3),

                            Text(
                              "Last date 22/08/2026",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),


                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const TrendingProduct(showDescription: true,
                                  showPrice: true,
                                  showOldPrice:true,

                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding:
                            const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.pinkAccent,
                              borderRadius:
                              BorderRadius.circular(5),
                            ),
                            child: const Text(
                              "View All",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.circular(8),
                    ),
                    child: SizedBox(
                      height: 220,
                      child: ListView.builder(
                        scrollDirection:
                        Axis.horizontal,
                        itemCount:
                        smallProducts.length,
                        itemBuilder: (context, index) {

                          final item =
                          smallProducts[index];

                          final productName =
                          item["name"]!;

                          return Container(
                            width: 120,
                            margin:
                            const EdgeInsets.only(
                              right: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                Colors.grey.shade300,
                              ),
                              borderRadius:
                              BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [

                                // IMAGE + HEART
                                Stack(
                                  children: [

                                    ClipRRect(
                                      borderRadius:
                                      const BorderRadius
                                          .only(
                                        topLeft:
                                        Radius.circular(
                                            8),
                                        topRight:
                                        Radius.circular(
                                            8),
                                      ),
                                      child: Image.asset(
                                        item["image"]!,
                                        height: 155,
                                        width:
                                        double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),

                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child:
                                      _buildFavoriteIcon(
                                        item,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 5),

                                Padding(
                                  padding:
                                  const EdgeInsets
                                      .symmetric(
                                    horizontal: 5,
                                  ),
                                  child: Text(
                                    productName,
                                    maxLines: 1,
                                    overflow:
                                    TextOverflow.ellipsis,
                                    style:
                                    const TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                ),

                                Text(
                                  item["price"]!,
                                  style:
                                  const TextStyle(
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                Container(
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Column(
                    children: [

                      ClipRRect(
                        borderRadius:
                        BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/image21.png",
                          width: double.infinity,
                          height: 270,
                          fit: BoxFit.cover,
                        ),
                      ),

                      Padding(
                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: SizedBox(
                          height: 100,
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [

                              const Text(
                                "New Arrivals",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),

                              Row(
                                children: [

                                  const Text(
                                    "Summer' 25 Collections",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),

                                  const Spacer(),

                                  Container(
                                    padding:
                                    const EdgeInsets
                                        .symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),
                                    decoration:
                                    BoxDecoration(
                                      color: const Color(
                                          0xFFF83758),
                                      borderRadius:
                                      BorderRadius
                                          .circular(5),
                                    ),
                                    child: const Row(
                                      children: [

                                        Text(
                                          "view all",
                                          style: TextStyle(
                                            color:
                                            Colors.white,
                                          ),
                                        ),

                                        SizedBox(width: 5),

                                        Icon(
                                          Icons.arrow_forward,
                                          color:
                                          Colors.white,
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),



                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Text(
                    "Sponsored",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius:
                      BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/image20.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [

                      Text(
                        "UP TO 50% OFF",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Icon(
                        Icons.arrow_forward_ios,
                        size: 25,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}