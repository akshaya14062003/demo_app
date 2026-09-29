
import 'package:demo_app/services/%20auth_service.dart';
import 'package:flutter/material.dart';
import 'forgot_screen.dart';
import 'get_started.dart';
import 'create_an_account.dart';

class WelcomeBackScreen extends StatefulWidget {
  const WelcomeBackScreen({super.key});

  @override
  State<WelcomeBackScreen> createState() =>
      _WelcomeBackScreenState();
}

class _WelcomeBackScreenState extends State<WelcomeBackScreen> {
  bool hidePassword = true;
  bool isLoading = false;

  final TextEditingController usernameController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();



  Future<void> login() async {
    final enteredEmail =
    usernameController.text.trim();

    final enteredPassword =
    passwordController.text.trim();

    if (enteredEmail.isEmpty ||
        enteredPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
          Text("Please enter email and password"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await AuthService.login(
        email: enteredEmail,
        password: enteredPassword,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login successful"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const GetStarted(),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      final errorMessage =
      e.toString().replaceFirst(
        'Exception: ',
        '',
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


  Future<void> loginWithGoogle() async {
    setState(() {
      isLoading = true;
    });

    try {
      await AuthService.loginWithGoogle();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Google login successful"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const GetStarted(),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      final errorMessage =
      e.toString().replaceFirst(
        'Exception: ',
        '',
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
    usernameController.dispose();
    passwordController.dispose();
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
                  "Welcome\nBack!",
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                    height: 1.05,
                  ),
                ),

                const SizedBox(height: 45),



                TextField(
                  controller: usernameController,
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
                      const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 38),


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
                            ? Icons
                            .visibility_outlined
                            : Icons
                            .visibility_off_outlined,
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
                      const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),



                Align(
                  alignment:
                  Alignment.centerRight,
                  child: GestureDetector(
                    behavior:
                    HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                          const ForgotScreen(),
                        ),
                      );
                    },
                    child: const Padding(
                      padding:
                      EdgeInsets.all(8.0),
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color:
                          Color(0xFFFF3655),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 65),

                                SizedBox(
                  width: double.infinity,
                  height: 68,
                  child: ElevatedButton(
                    onPressed:
                    isLoading ? null : login,
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
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 92),

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

                    GestureDetector(
                      onTap: isLoading
                          ? null
                          : loginWithGoogle,
                      child: socialButton(
                        image:
                        'assets/image5.png',
                      ),
                    ),

                    const SizedBox(width: 12),


                    socialButton(
                      image: 'assets/image6.png',
                    ),

                    const SizedBox(width: 12),

                    // OTHER BUTTON
                    socialButton(
                      image: 'assets/image7.png',
                    ),
                  ],
                ),

                const SizedBox(height: 38),


                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Create An Account",
                    ),
                    const SizedBox(width: 5),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const CreateAnAccount(),
                          ),
                        );
                      },
                      child: const Text(
                        "SignUp",
                        style: TextStyle(
                          color:
                          Color(0xFFFF3655),
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
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