import 'package:demo_app/services/%20auth_service.dart';
import 'package:flutter/material.dart';

import 'welcome_back.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final TextEditingController emailController =
  TextEditingController();

  bool isLoading = false;

  Future<void> resetPassword() async {
    final String email = emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter your email"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await AuthService.forgotPassword(
        email: email,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Password reset email sent successfully",
          ),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) =>
          const WelcomeBackScreen(),
        ),
            (route) => false,
      );
    } catch (e) {
      if (!mounted) return;

      final String errorMessage =
      e.toString().replaceFirst(
        "Exception: ",
        "",
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
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


      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [
                const SizedBox(height: 50),

                const Text(
                  "Forgot\nPassword?",
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    height: 1.05,
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Enter your registered email address. "
                      "We will send you a link to reset your password.",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 45),

                const Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: emailController,

                  keyboardType:
                  TextInputType.emailAddress,

                  decoration: InputDecoration(
                    hintText: "Enter your email",

                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: Colors.grey,
                    ),

                    filled: true,

                    fillColor:
                    const Color(0xFFF5F5F5),

                    contentPadding:
                    const EdgeInsets.symmetric(
                      vertical: 20,
                    ),

                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),

                    focusedBorder:
                    OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(12),
                      borderSide:
                      const BorderSide(
                        color: Color(0xFFFF3655),
                        width: 2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                SizedBox(
                  width: double.infinity,
                  height: 60,

                  child: ElevatedButton(
                    onPressed:
                    isLoading
                        ? null
                        : resetPassword,

                    style:
                    ElevatedButton.styleFrom(
                      backgroundColor:
                      const Color(0xFFFF3655),

                      disabledBackgroundColor:
                      const Color(0xFFFFA0AF),

                      elevation: 0,

                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(6),
                      ),
                    ),

                    child: isLoading
                        ? const SizedBox(
                      width: 26,
                      height: 26,
                      child:
                      CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    )
                        : const Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Back to Login",
                      style: TextStyle(
                        color: Color(0xFFFF3655),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}