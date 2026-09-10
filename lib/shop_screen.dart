
import 'package:flutter/material.dart' hide Size;

class ShopScreen extends StatefulWidget {
  final Map<String, String> product;

  const ShopScreen({
    super.key,
    required this.product,
  });

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  static const Color pink = Color(0xFFFF3655);

  String selectedSize = '7 UK';

  @override
  Widget build(BuildContext context) {
    final Map<String, String> product = widget.product;



    final List<Map<String, String>> dress = [
      {
        "image": "assets/image17.png",
        "name": "Saree",
        "description": "Stylish saree for your everyday walk",
        "price": "₹5500",
        "oldPrice": "₹7500",
        "discount": "60%Off",
        "rating": "45678",
      },
      {
        "image": "assets/image18.png",
        "name": "Leghnga",
        "description": "Latest fashion dress at affordable price",
        "price": "₹4500",
        "oldPrice": "₹2499",
        "discount": "40%Off",
        "rating": "25690",
      },
    ];

    return Scaffold(
      appBar:AppBar(




      ),
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [



              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    // BACK BUTTON
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 20,
                      ),
                    ),

                    // CART ICON
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.15),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: const Icon(
                          Icons.shopping_cart_outlined,
                          size: 19,
                        ),
                      ),
                    ),
                  ],
                ),
              ),



              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    product['image']!,
                    width: double.infinity,
                    height: 213,
                    fit: BoxFit.cover,
                  ),
                ),
              ),



              Padding(
                padding: const EdgeInsets.fromLTRB(
                  12,
                  10,
                  12,
                  0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [



                    Text(
                      'Size: $selectedSize',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 7),



                    Row(
                      children: [
                        _sizeButton('6 UK'),
                        _sizeButton('7 UK'),
                        _sizeButton('8 UK'),
                        _sizeButton('9 UK'),
                        _sizeButton('10 UK'),
                      ],
                    ),

                    const SizedBox(height: 11),



                    Text(
                      product['name'] ?? 'Product',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 3),



                    Text(
                      product['description'] ?? '',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 4),



                    Row(
                      children: [
                        _star(),
                        _star(),
                        _star(),
                        _star(),
                        _starHalf(),

                        const SizedBox(width: 5),

                        Text(
                          product['rating'] ?? '0',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    

                    Row(
                      children: [

                        Text(
                          product['oldPrice'] ?? '',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade600,
                            decoration:
                            TextDecoration.lineThrough,
                          ),
                        ),

                        const SizedBox(width: 7),

                        Text(
                          product['price'] ?? '₹999',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(width: 7),

                        Text(
                          product['discount'] ?? '',
                          style: const TextStyle(
                            fontSize: 13,
                            color: pink,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    

                    const Text(
                      'Product Details',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 3),

                    const Text(
                      'Perhaps the most iconic product of all-time. '
                          'This beautiful product is designed with quality '
                          'materials and excellent comfort. It is suitable '
                          'for everyday use and fashion collections.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        height: 1.25,
                      ),
                    ),

                    const SizedBox(height: 8),

                    

                    Row(
                      children: [

                        _infoButton(
                          Icons.location_on_outlined,
                          'Nearest Store',
                        ),

                        const SizedBox(width: 5),

                        _infoButton(
                          Icons.card_membership_outlined,
                          'VIP',
                        ),

                        const SizedBox(width: 5),

                        _infoButton(
                          Icons.replay_outlined,
                          'Return policy',
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

         

                    Row(
                      children: [

                   

                        Expanded(
                          child: _cartButton(),
                        ),

                        const SizedBox(width: 15),


                        Expanded(
                          child: _buyNowButton(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),



                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFC9D3),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [

                          Text(
                            'Delivery in',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),

                          Text(
                            '1 within Hour',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),



                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.remove_red_eye_outlined, size: 16),
                            SizedBox(width: 4),
                            Text(
                              'View Similar',
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Row(
                          children: const [
                            Icon(Icons.compare_arrows, size: 16),
                            SizedBox(width: 4),
                            Text(
                              'Add to compare',
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),



                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Similar To',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Row(
                          children: [
                            _filterButton('Sort'),
                            const SizedBox(width: 5),

                            _filterButton('Filter'),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 2),

                    const Text(
                      '282+ Items',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),



                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: dress.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        final item = dress[index];

                        return _similarProduct(
                          item['image']!,
                          item['name']!,
                          item['description']!,
                          item['price']!,
                          item['rating'] ?? '0',
                        );
                      },
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _cartButton() {
    return SizedBox(
      height: 50,
      child: Stack(
        children: [

          // BLUE RECTANGLE
          Positioned(
            left: 22,
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF1662BD),

                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
              ),

              child: const Center(
                child: Text(
                  "Go to cart",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),


          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 50,
              height: 50,

              decoration: const BoxDecoration(
                color: Colors.indigo,
                shape: BoxShape.circle,
              ),

              child: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget _buyNowButton() {
    return SizedBox(
      height: 50,
      child: Stack(
        children: [


          Positioned(
            left: 22,
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF3DD481),

                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
              ),

              child: const Center(
                child: Text(
                  "Buy Now",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),


          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 50,
              height: 50,

              decoration: const BoxDecoration(
                color: Color(0xFF32B96E),
                shape: BoxShape.circle,
              ),

              child: const Icon(
                Icons.touch_app_outlined,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget _sizeButton(String text) {
    final bool isSelected = selectedSize == text;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSize = text;
        });
      },

      child: Container(
        margin: const EdgeInsets.only(right: 6),

        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 5,
        ),

        decoration: BoxDecoration(
          color: isSelected
              ? pink
              : Colors.white,

          border: Border.all(
            color: pink,
          ),

          borderRadius: BorderRadius.circular(3),
        ),

        child: Text(
          text,

          style: TextStyle(
            color: isSelected
                ? Colors.white
                : pink,

            fontSize: 9,
          ),
        ),
      ),
    );
  }



  Widget _star() {
    return const Icon(
      Icons.star,
      color: Colors.amber,
      size: 15,
    );
  }

  Widget _starHalf() {
    return const Icon(
      Icons.star_half,
      color: Colors.amber,
      size: 15,
    );
  }



  Widget _infoButton(
      IconData icon,
      String text,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 4,
      ),

      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
        ),

        borderRadius: BorderRadius.circular(4),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          Icon(
            icon,
            size: 11,
            color: Colors.grey,
          ),

          const SizedBox(width: 3),

          Text(
            text,
            style: const TextStyle(
              fontSize: 7,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }



  Widget _filterButton(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 4,
      ),

      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
        ),

        borderRadius: BorderRadius.circular(4),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          Text(
            text,
            style: const TextStyle(
              fontSize: 8,
            ),
          ),

          const SizedBox(width: 2),

          const Icon(
            Icons.keyboard_arrow_down,
            size: 12,
          ),
        ],
      ),
    );
  }



  Widget _similarProduct(
      String image,
      String name,
      String description,
      String price,
      String rating,
      ) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [

        ClipRRect(
          borderRadius: BorderRadius.circular(6),

          child: Image.asset(
            image,
            width: double.infinity,
            height: 105,
            fit: BoxFit.cover,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          name,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 2),

        Text(
          description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,

          style: const TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
        ),

        const SizedBox(height: 2),

        Text(
          price,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),



        Row(
          children: [
            _star(),
            _star(),
            _star(),
            _star(),
            _starHalf(),

            const SizedBox(width: 5),

            Text(
              rating,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),

        const SizedBox(height: 5),
        
      ],
    );
  }
}