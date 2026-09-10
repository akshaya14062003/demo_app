import 'dart:io';

import 'package:demo_app/welcome_back.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:demo_app/resuable_bottom.dart';

class ProfilePage extends StatefulWidget {
  final bool fromCheckout;

  const ProfilePage({
    super.key,
    this.fromCheckout = false,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  final TextEditingController nameController =
  TextEditingController();

  final TextEditingController addressController =
  TextEditingController();

  final TextEditingController cityController =
  TextEditingController();

  final TextEditingController zipController =
  TextEditingController();

  final TextEditingController countryController =
  TextEditingController();

  final TextEditingController businessNameController =
  TextEditingController();

  final TextEditingController businessController =
  TextEditingController();

  final TextEditingController businessCityController =
  TextEditingController();

  final TextEditingController businessZipController =
  TextEditingController();

  bool hidePassword = true;

  File? profileImage;

  final ImagePicker picker = ImagePicker();

  String selectedCountry = "United Kingdom";



  @override
  void initState() {
    super.initState();

    loadUserData();
    loadProfileImage();
  }


  Future<void> loadUserData() async {
    final prefs =
    await SharedPreferences.getInstance();

    final savedEmail =
        prefs.getString("email") ?? "";

    final savedPassword =
        prefs.getString("password") ?? "";

    final savedName =
        prefs.getString("name") ?? "";

    final savedAddress =
        prefs.getString("address") ?? "";

    final savedCity =
        prefs.getString("city") ?? "";

    final savedZip =
        prefs.getString("zip") ?? "";

    final savedCountry =
        prefs.getString("country") ??
            "United Kingdom";

    final savedBusinessName =
        prefs.getString("businessName") ?? "";

    final savedBusinessAddress =
        prefs.getString("businessAddress") ?? "";

    final savedBusinessCity =
        prefs.getString("businessCity") ?? "";

    final savedBusinessZip =
        prefs.getString("businessZip") ?? "";

    if (!mounted) return;

    const allowedCountries = [
      "United Kingdom",
      "India",
      "United States",
    ];

    final String validatedCountry =
    allowedCountries.contains(savedCountry)
        ? savedCountry
        : "United Kingdom";

    setState(() {

      // Personal details

      emailController.text =
          savedEmail;

      passwordController.text =
          savedPassword;

      nameController.text =
          savedName;

      // Personal address

      addressController.text =
          savedAddress;

      cityController.text =
          savedCity;

      zipController.text =
          savedZip;

      countryController.text =
          validatedCountry;

      selectedCountry =
          validatedCountry;

      // Business address

      businessNameController.text =
          savedBusinessName;

      businessController.text =
          savedBusinessAddress;

      businessCityController.text =
          savedBusinessCity;

      businessZipController.text =
          savedBusinessZip;
    });
  }



  Future<void> pickProfileImage() async {

    final XFile? image =
    await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {

      setState(() {
        profileImage =
            File(image.path);
      });

      // Save image path
      await saveProfileImage();
    }
  }



  Future<void> saveProfileImage() async {

    if (profileImage == null) {
      return;
    }

    final prefs =
    await SharedPreferences.getInstance();

    await prefs.setString(
      "profileImagePath",
      profileImage!.path,
    );
  }



  Future<void> loadProfileImage() async {

    final prefs =
    await SharedPreferences.getInstance();

    final savedImagePath =
    prefs.getString(
      "profileImagePath",
    );

    if (savedImagePath == null ||
        savedImagePath.isEmpty) {
      return;
    }

    final file =
    File(savedImagePath);

    if (await file.exists()) {

      if (!mounted) return;

      setState(() {
        profileImage = file;
      });
    }
  }



  Widget profileTextField({
    required String hintText,
    required TextEditingController controller,
    bool obscureText = false,
    TextInputType keyboardType =
        TextInputType.text,
  }) {

    return SizedBox(
      height: 42,

      child: TextField(
        controller: controller,

        obscureText: obscureText,

        keyboardType: keyboardType,

        style: const TextStyle(
          fontSize: 12,
          color: Colors.black,
        ),

        decoration: InputDecoration(

          hintText: hintText,

          hintStyle:
          const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),

          contentPadding:
          const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),

          filled: true,

          fillColor: Colors.white,

          border:
          OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(4),

            borderSide: BorderSide(
              color:
              Colors.grey.shade300,
            ),
          ),

          enabledBorder:
          OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(4),

            borderSide: BorderSide(
              color:
              Colors.grey.shade300,
            ),
          ),

          focusedBorder:
          OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(4),

            borderSide:
            const BorderSide(
              color:
              Color(0xffff3655),
            ),
          ),
        ),
      ),
    );
  }



  Widget sectionTitle(String title) {

    return Padding(
      padding:
      const EdgeInsets.only(
        top: 18,
        bottom: 8,
      ),

      child: Text(
        title,

        style: const TextStyle(
          fontSize: 15,
          fontWeight:
          FontWeight.w900,
          color: Colors.black,
        ),
      ),
    );
  }



  Future<void> saveData() async {

    final prefs =
    await SharedPreferences.getInstance();


    await prefs.setString(
      "email",
      emailController.text.trim(),
    );

    await prefs.setString(
      "password",
      passwordController.text.trim(),
    );

    await prefs.setString(
      "name",
      nameController.text.trim(),
    );


    await prefs.setString(
      "address",
      addressController.text.trim(),
    );

    await prefs.setString(
      "city",
      cityController.text.trim(),
    );

    await prefs.setString(
      "zip",
      zipController.text.trim(),
    );

    await prefs.setString(
      "country",
      selectedCountry,
    );



    await prefs.setString(
      "businessName",
      businessNameController.text.trim(),
    );

    await prefs.setString(
      "businessAddress",
      businessController.text.trim(),
    );

    await prefs.setString(
      "businessCity",
      businessCityController.text.trim(),
    );

    await prefs.setString(
      "businessZip",
      businessZipController.text.trim(),
    );


    if (profileImage != null) {
      await prefs.setString(
        "profileImagePath",
        profileImage!.path,
      );
    }

    if (!mounted) return;



    if (widget.fromCheckout) {

      Navigator.pop(
        context,
        true,
      );

      return;
    }



    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          "Profile saved successfully",
        ),
        duration:
        Duration(seconds: 1),
      ),
    );

    await Future.delayed(
      const Duration(
        milliseconds: 500,
      ),
    );

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,

      MaterialPageRoute(
        builder: (context) =>
        const ResuableBottom(),
      ),

          (route) => false,
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xfff8f8f8),



      appBar: AppBar(

        backgroundColor:
        Colors.white,

        elevation: 0,

        leading: IconButton(

          icon: const Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: Colors.black,
          ),

          onPressed: () {

            Navigator.pushReplacement(
              context,

              MaterialPageRoute(
                builder: (context) =>
                const ResuableBottom(),
              ),
            );
          },
        ),

        titleSpacing: 0,

        title: Row(

          mainAxisAlignment:
          MainAxisAlignment
              .spaceBetween,

          children: [

            const Text(
              "Profile",

              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight:
                FontWeight.w500,
              ),
            ),
          ],
        ),

        centerTitle: false,
      ),



      body: SafeArea(

        child:
        SingleChildScrollView(

          padding:
          const EdgeInsets.symmetric(
            horizontal: 16,
          ),

          child: Column(

            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              const SizedBox(
                height: 10,
              ),



              Center(

                child: Stack(

                  children: [

                    Container(

                      width: 70,
                      height: 70,

                      decoration:
                      const BoxDecoration(
                        shape:
                        BoxShape.circle,

                        color:
                        Color(0xffff3655),
                      ),

                      child: ClipOval(

                        child:
                        profileImage !=
                            null

                            ? Image.file(
                          profileImage!,

                          width: 70,
                          height: 70,

                          fit: BoxFit.cover,
                        )

                            : const Icon(
                          Icons.person,

                          color:
                          Colors.white,

                          size: 42,
                        ),
                      ),
                    ),

                    // EDIT IMAGE BUTTON

                    Positioned(

                      right: 0,
                      bottom: 0,

                      child:
                      GestureDetector(

                        onTap:
                        pickProfileImage,

                        child: Container(

                          width: 20,
                          height: 20,

                          decoration:
                          const BoxDecoration(
                            shape:
                            BoxShape.circle,

                            color:
                            Colors.blue,
                          ),

                          child:
                          const Icon(
                            Icons.edit,
                            size: 11,
                            color:
                            Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 5,
              ),

              const Center(

                child: Text(
                  "Profile Picture",

                  style: TextStyle(
                    fontSize: 10,
                    color:
                    Colors.grey,
                  ),
                ),
              ),



              sectionTitle(
                "Personal details",
              ),

              const Text(
                "Email",

                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(
                height: 4,
              ),

              profileTextField(
                hintText:
                "Email Address",

                controller:
                emailController,

                keyboardType:
                TextInputType
                    .emailAddress,
              ),

              const SizedBox(
                height: 10,
              ),


              sectionTitle(
                "Personal Address",
              ),

              const Text(
                "Name",

                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(
                height: 4,
              ),

              profileTextField(
                hintText: "Name",
                controller:
                nameController,
              ),

              const SizedBox(
                height: 10,
              ),

              const Text(
                "Address",

                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(
                height: 4,
              ),

              profileTextField(
                hintText: "Address",
                controller:
                addressController,
              ),

              const SizedBox(
                height: 10,
              ),

              const Text(
                "City",

                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(
                height: 4,
              ),

              profileTextField(
                hintText: "City",
                controller:
                cityController,
              ),

              const SizedBox(
                height: 10,
              ),

              const Text(
                "ZIP",

                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(
                height: 4,
              ),

              profileTextField(
                hintText: "ZIP",

                controller:
                zipController,

                keyboardType:
                TextInputType.number,
              ),

              const SizedBox(
                height: 10,
              ),



              const Text(
                "Country",

                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(
                height: 4,
              ),

              Container(

                height: 42,

                padding:
                const EdgeInsets
                    .symmetric(
                  horizontal: 10,
                ),

                decoration:
                BoxDecoration(

                  color:
                  Colors.white,

                  borderRadius:
                  BorderRadius
                      .circular(4),

                  border:
                  Border.all(
                    color:
                    Colors.grey
                        .shade300,
                  ),
                ),

                child:
                DropdownButtonHideUnderline(

                  child:
                  DropdownButton<String>(

                    value:
                    selectedCountry,

                    isExpanded:
                    true,

                    icon:
                    const Icon(
                      Icons
                          .keyboard_arrow_down,
                      size: 18,
                    ),

                    style:
                    const TextStyle(
                      fontSize: 12,
                      color:
                      Colors.black,
                    ),

                    items: const [

                      DropdownMenuItem(
                        value:
                        "United Kingdom",

                        child:
                        Text(
                          "United Kingdom",
                        ),
                      ),

                      DropdownMenuItem(
                        value:
                        "India",

                        child:
                        Text(
                          "India",
                        ),
                      ),

                      DropdownMenuItem(
                        value:
                        "United States",

                        child:
                        Text(
                          "United States",
                        ),
                      ),
                    ],

                    onChanged:
                        (value) {

                      if (value !=
                          null) {

                        setState(() {

                          selectedCountry =
                              value;

                          countryController
                              .text =
                              value;
                        });
                      }
                    },
                  ),
                ),
              ),



              sectionTitle(
                "Business Address",
              ),

              const Text(
                "Name",

                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(
                height: 4,
              ),

              profileTextField(
                hintText: "Name",

                controller:
                businessNameController,
              ),

              const SizedBox(
                height: 10,
              ),

              const Text(
                "Address",

                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(
                height: 4,
              ),

              profileTextField(
                hintText: "Address",

                controller:
                businessController,
              ),

              const SizedBox(
                height: 10,
              ),

              const Text(
                "City",

                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(
                height: 4,
              ),

              profileTextField(
                hintText: "City",

                controller:
                businessCityController,
              ),

              const SizedBox(
                height: 10,
              ),

              const Text(
                "ZIP",

                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(
                height: 4,
              ),

              profileTextField(
                hintText: "ZIP",

                controller:
                businessZipController,

                keyboardType:
                TextInputType.number,
              ),

              const SizedBox(
                height: 20,
              ),



              SizedBox(

                width:
                double.infinity,

                height: 45,

                child:
                ElevatedButton(

                  onPressed: () async {

                    await saveData();
                  },

                  style:
                  ElevatedButton
                      .styleFrom(

                    backgroundColor:
                    const Color(
                      0xffff3655,
                    ),

                    elevation: 0,

                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius
                          .circular(4),
                    ),
                  ),

                  child: Text(

                    widget.fromCheckout
                        ? "Save Address"
                        : "Save",

                    style:
                    const TextStyle(
                      color:
                      Colors.white,

                      fontSize: 14,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  void dispose() {

    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    addressController.dispose();
    cityController.dispose();
    zipController.dispose();
    countryController.dispose();

    businessNameController.dispose();
    businessController.dispose();
    businessCityController.dispose();
    businessZipController.dispose();

    super.dispose();
  }
}