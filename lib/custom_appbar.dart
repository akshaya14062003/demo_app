import 'package:demo_app/cart_data.dart';
import 'package:demo_app/cart_page.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {

  Widget cartIcon() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartPage(),
              ),
            );

            if (mounted) {
              setState(() {});
            }
          },
          icon: const Icon(
            Icons.shopping_cart_outlined,
            size: 28,
            color: Colors.black,
          ),
        ),

        if (CartData.itemCount > 0)
          Positioned(
            right: 2,
            top: 0,
            child: Container(
              width: 20,
              height: 20,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                CartData.itemCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,

      automaticallyImplyLeading: false,

      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),

      centerTitle: true,

      title: Image.asset(
        "assets/stylish.png",
        width: 100,
        height: 35,
        fit: BoxFit.contain,
      ),

      actions: [
        cartIcon(),
        const SizedBox(width: 8),
      ],
    );
  }
}