import 'package:demo_app/welcome_back.dart';
import 'package:flutter/material.dart';

class ForgotScreen extends StatelessWidget {
  const ForgotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: ((didPop, result) {
        if(!didPop){
          print("Back button pressed");

        }
      }),
      child: Scaffold(

        backgroundColor: Colors.white,
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsetsGeometry.symmetric(horizontal: 32),
                 child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     const SizedBox(height: 15,),
                     const Text(
                       "Forgot\nPassword?",
                       style: TextStyle(
                         fontSize: 44,
                         fontWeight: FontWeight.bold,
                         height: 1.05,
                       ),
                     ),
                     const SizedBox(height: 45,),
                     TextField(
                       decoration: InputDecoration(
                         hintText: "Enter the email  address",

                         hintStyle: const TextStyle(
                           color: Colors.grey,
                           fontSize: 16,
                         ),

                         prefixIcon: const Icon(
                           Icons.email,
                           color: Colors.grey,
                         ),

                         filled: true,
                         fillColor: const Color(0xFFF5F5F5),

                         contentPadding: const EdgeInsets.symmetric(
                           vertical: 20,
                         ),

                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(12),
                           borderSide: const BorderSide(
                             color: Colors.grey,
                           ),
                         ),
                       ),
                     ),
                     const SizedBox(height: 30,),
                     const Center(
                       child: Text(
                         "* We will send you a message to set or reset your new.dart password",
                         style: TextStyle(
                           color: Colors.grey,
                           fontSize: 16,
                         ),
                       ),


                     ),
                     const SizedBox(height: 50,),
                     SizedBox(
                       width: double.infinity,
                       height: 78,

                       child: ElevatedButton(
                         onPressed: () {
                           Navigator.pushAndRemoveUntil(
                             context,
                             MaterialPageRoute(
                               builder: (context) => const WelcomeBackScreen(),
                             ),
                                 (route) => false,
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
                           "Submit",
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: 24,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                       ),
                     ),
                     const SizedBox(height: 50,)


                   ],
                 ),
            )
        ),







      ),
    );
  }
}
