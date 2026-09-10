import 'package:demo_app/favorite.dart';
import 'package:demo_app/home_page.dart';
import 'package:demo_app/profile.dart';
import 'package:demo_app/trending_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResuableBottom extends StatefulWidget {
  const ResuableBottom({super.key});

  @override
  State<ResuableBottom> createState() => _ReusableBottomState();

}
class _ReusableBottomState extends State<ResuableBottom> {

  int selectedIndex=0;
  final List<Widget>pages= [
    const HomePage(),
    const FavoritePage(),
    const HomePage(),
    const TrendingProduct(),
    const ProfilePage(),

    ];

  @override

Widget build(BuildContext context) {
return PopScope(
canPop: false,
onPopInvokedWithResult: (didPop, result) {
if (!didPop) {

}
},
child:  Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme:const IconThemeData(size: 25),
        unselectedIconTheme: const IconThemeData(size: 25),
        currentIndex: selectedIndex,

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },

        type: BottomNavigationBarType.fixed,

        selectedItemColor: Colors.redAccent,

        unselectedItemColor: Colors.black,

        selectedFontSize: 13,

        // unselectedFontSize: 13,

        items: [
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(10),
              child: const Icon(
                Icons.home_outlined,
              ),
            ),
            activeIcon: Container(
              padding: const EdgeInsets.all(10),
              child: const Icon(Icons.home_outlined),
            ),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(10),
              child: const Icon(
                Icons.favorite_border_outlined,
              ),
            ),
            activeIcon: Container(
              padding: const EdgeInsets.all(10),
              child: const Icon(Icons.favorite_border_outlined),
            ),
            label: "Wishlist",
          ),
          BottomNavigationBarItem(
            icon: Transform.translate(
              offset:const Offset(0, -12) ,
              child:Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.shopping_cart_outlined),

              ),

            ),

            activeIcon:Transform.translate(
              offset:const Offset(0,- 18) ,
              child:Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.shopping_cart_outlined,color: Colors.white,),

              ),

            ),

            label: "",

          ),

          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(10),
              child: const Icon(
                Icons.search_outlined,
              ),
            ),
            activeIcon: Container(
              padding: const EdgeInsets.all(5),
              child: const Icon(Icons.search_outlined),
            ),
            label: "Searching",
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(10),
              child: const Icon(
                Icons.person,
              ),
            ),
            activeIcon: Container(
              padding: const EdgeInsets.all(10),
              child: const Icon(Icons.person_rounded),
            ),
            label: "Profile",
          ),
        ],
      )
),

    );
  }
}


