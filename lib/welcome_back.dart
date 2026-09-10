import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'get_started.dart';
import 'create_an_account.dart';

class WelcomeBackScreen extends StatefulWidget {
  const WelcomeBackScreen({super.key});

  @override
  State<WelcomeBackScreen> createState() =>
      _WelcomeBackScreenState();
}

class _WelcomeBackScreenState
    extends State<WelcomeBackScreen> {

  bool hidePassword = true;

  final TextEditingController usernameController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();



  Future<void> login() async {
    final prefs = await SharedPreferences.getInstance();

    // Get saved email and password
    final savedEmail = prefs.getString("email");
    final savedPassword = prefs.getString("password");

    // Get entered values
    final enteredEmail =
    usernameController.text.trim();

    final enteredPassword =
    passwordController.text.trim();

    // Check empty fields
    if (enteredEmail.isEmpty || enteredPassword.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter email and password"),
        ),
      );
      return;
    }

    // Check if account exists
    if (savedEmail == null || savedPassword == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No account found. Please register first."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Check email and password
    if (enteredEmail == savedEmail && enteredPassword == savedPassword) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login successful")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const GetStarted(),
        ),
      );
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Incorrect email or password"),
          backgroundColor: Colors.red,
        ),
      );
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
            padding:
            const EdgeInsets.symmetric(horizontal: 32),

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

                // =================================================
                // USERNAME / EMAIL
                // =================================================

                TextField(
                  controller: usernameController,

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

                // =================================================
                // PASSWORD
                // =================================================

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

                  child: InkWell(
                    onTap: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                          const GetStarted(),
                        ),
                      );

                    },

                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color:
                        Color(0xFFFF3655),
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),



                const SizedBox(height: 65),

                SizedBox(
                  width: double.infinity,
                  height: 68,

                  child: ElevatedButton(
                    onPressed: login,

                    style:
                    ElevatedButton.styleFrom(
                      backgroundColor:
                      const Color(0xFFFF3655),

                      elevation: 0,

                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(5),
                      ),
                    ),

                    child: const Text(
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