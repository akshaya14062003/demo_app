import 'package:demo_app/home_page.dart';
import 'package:demo_app/resuable_bottom.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
    canPop: false,
   onPopInvokedWithResult: ((didPop, result) {
     if (!didPop) {
       print("Back button pressed");
     }
   }
   ),



      child: Scaffold(
        body: Stack(
          children: [

      // Full screen image
            Positioned.fill(
              child: Image.asset(
                'assets/image8.png',
                fit: BoxFit.cover,

              ),
            ),
      // Text on top
            const Positioned(
              left: 30,
              right: 30,
              top: 480,
              child: Text(
                "You want \nAuthentic, here \nyou go!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),

            ),




            const Positioned(
              left: 30,
              right: 30,
              top: 640,
              child:Column(
                children: [
                  const Text(
                "Find it here, buy it now!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
      ),

                ),
                ]
                ),
            ),
            Positioned(
              left: 68,
              right: 68,
              bottom: 35,
              child:SizedBox(
                height:68,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const ResuableBottom(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF3655),

                    elevation: 0,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    "Get Started",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),



              ),
            ),

          ],

        ),
      ),
    );
  }
}
