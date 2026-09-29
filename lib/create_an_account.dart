import 'package:demo_app/services/%20auth_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateAnAccount extends StatefulWidget {
  const CreateAnAccount({super.key});

  @override
  State<CreateAnAccount> createState() =>
      _CreateAnAccountState();
}

class _CreateAnAccountState extends State<CreateAnAccount> {
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  bool isLoading = false;

  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  final TextEditingController confirmPasswordController =
  TextEditingController();

  // ============================================================
  // REGISTER USER USING FIREBASE
  // ============================================================

  Future<void> registerUser() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword =
    confirmPasswordController.text.trim();

    // Check empty fields
    if (email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please fill all fields",
      );
      return;
    }

    // Check password length
    if (password.length < 6) {
      Fluttertoast.showToast(
        msg: "Password must be at least 6 characters",
      );
      return;
    }

    // Check confirm password
    if (password != confirmPassword) {
      Fluttertoast.showToast(
        msg: "Passwords do not match",
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {


      await AuthService.register(
        email: email,
        password: password,
      );

      if (!mounted) return;

      Fluttertoast.showToast(
        msg: "Account created successfully",
      );

      // Go back to Login screen
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      String errorMessage =
      e.toString().replaceFirst(
        'Exception: ',
        '',
      );

      Fluttertoast.showToast(
        msg: errorMessage,
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
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
            ),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                const SizedBox(height: 15),



                const Text(
                  "Create An\nAccount",
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 45),



                TextField(
                  controller: emailController,

                  keyboardType:
                  TextInputType.emailAddress,

                  decoration: InputDecoration(
                    hintText: "Username or Email",

                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),

                    prefixIcon: const Icon(
                      Icons.person,
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

                      borderSide:
                      BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 25),



                TextField(
                  controller: passwordController,

                  obscureText: hidePassword,

                  decoration: InputDecoration(
                    hintText: "Password",

                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),

                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.grey,
                    ),

                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePassword =
                          !hidePassword;
                        });
                      },

                      icon: Icon(
                        hidePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,

                        color: Colors.grey,
                      ),
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

                      borderSide:
                      BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 15),



                TextField(
                  controller:
                  confirmPasswordController,

                  obscureText:
                  hideConfirmPassword,

                  decoration: InputDecoration(
                    hintText: "Confirm Password",

                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),

                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.grey,
                    ),

                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hideConfirmPassword =
                          !hideConfirmPassword;
                        });
                      },

                      icon: Icon(
                        hideConfirmPassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,

                        color: Colors.grey,
                      ),
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

                      borderSide:
                      BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 15),



                const Text(
                  "By clicking the Register button, "
                      "you agree to the public offer",

                  style: TextStyle(
                    color: Color(0xFFFF3655),
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 15),



                SizedBox(
                  width: double.infinity,
                  height: 60,

                  child: ElevatedButton(
                    onPressed:
                    isLoading
                        ? null
                        : registerUser,

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
                        BorderRadius.circular(5),
                      ),
                    ),

                    child: isLoading
                        ? const SizedBox(
                      width: 28,
                      height: 28,

                      child:
                      CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    )
                        : const Text(
                      "Register",

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),



                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },

                    child: const Text(
                      "Already I have an Account",

                      style: TextStyle(
                        color:
                        Color(0xFFFF3655),
                        fontSize: 16,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 70),



                const Center(
                  child: Text(
                    "- OR Continue with -",

                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),

                const SizedBox(height: 25),



                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,

                  children: [

                    socialButton(
                      image: 'assets/image5.png',
                    ),

                    const SizedBox(width: 12),

                    socialButton(
                      image: 'assets/image6.png',
                    ),

                    const SizedBox(width: 12),

                    socialButton(
                      image: 'assets/image7.png',
                    ),
                  ],
                ),

                const SizedBox(height: 38),

                const Center(
                  child: Text(
                    "Sign up",

                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 17,
                    ),
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



  Widget socialButton({
    required String image,
  }) {
    return Container(
      width: 70,
      height: 70,

      decoration: BoxDecoration(
        shape: BoxShape.circle,

        border: Border.all(
          color: const Color(0xFFFF3655),
          width: 1.5,
        ),
      ),

      child: Center(
        child: Image.asset(
          image,
          width: 35,
          height: 35,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}