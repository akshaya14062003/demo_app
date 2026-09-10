import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'favorite_data.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    final favorites = FavoriteData.favoriteProducts;

    return Scaffold(
      backgroundColor: const Color(0xfff8f8f8),

      appBar: AppBar(
        title: const Text(
          "Favorite",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: favorites.isEmpty
          ? const Center(
        child: Text(
          "No Favorite Products",
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
      )
          : GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: favorites.length,

        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.65,
        ),

        itemBuilder: (context, index) {
          final item = favorites[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [

                      ClipRRect(
                        borderRadius:
                        const BorderRadius.only(
                          topLeft:
                          Radius.circular(8),
                          topRight:
                          Radius.circular(8),
                        ),

                        child: Image.asset(
                          item["image"] ?? "",
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),


                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              FavoriteData
                                  .removeFavorite(
                                item["name"]!,
                              );
                              Fluttertoast.showToast(
                                msg: "${item["name"]} removed from favorites",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.black87,
                                textColor: Colors.white,
                                fontSize: 14.0,
                              );
                            });
                          },

                          child: Container(
                            width: 35,
                            height: 35,

                            decoration:
                            const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),

                            child: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 21,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 7),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: Text(
                    item["name"] ?? "",
                    maxLines: 1,
                    overflow:
                    TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight:
                      FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 4),

                // PRICE

                Padding(
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: Text(
                    item["price"] ?? "",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 8),
              ],
            ),
          );
        },
      ),
    );
  }
}