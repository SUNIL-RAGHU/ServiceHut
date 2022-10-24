// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:snippet_coder_utils/multi_images_utils.dart';

class RegisterProviderPage extends StatefulWidget {
  const RegisterProviderPage({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterProviderPage> createState() => _RegisterProviderPage();
}

class _RegisterProviderPage extends State<RegisterProviderPage> {
  String _fileText = "";

  Map<String, List<String>> adj = {
    "Carpenter": [
      'General Carpentry Work',
      'Repair Work',
      'Assembly & Installation',
      'Door & Window Install',
      'sofa and other units repair'
    ],
    "Painter": [
      "Wall painting",
      "Wall paper installation",
    ]
  };

  final ImagePicker _picker = ImagePicker();

  File? image;

  Future pickprofile(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print("Failed to pick images  $e");
    }
  }

  Future selectImage(ImageSource source) async {
    try {
      final selectedImage = await ImagePicker().pickImage(source: source);
      if (selectedImage != null) {
        _imagelist.add(selectedImage);
        axis = true;
      }
      setState(() {});
    } on PlatformException catch (e) {
      print("Failed to pick images  $e");
    }
  }

  List<String> subCategoryChosen = [];
  List<String> selectedSubcategories = [];
  List<XFile> _imagelist = [];
  String? selectedCategory;
  String? selectedProvince;
  bool axis = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (passwordConfirmed()) {
      FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      addUserDetails(
          _firstNameController.text.trim(),
          _lastNameController.text.trim(),
          int.parse(_ageController.text.trim()),
          _emailController.text.trim());
    }
  }

  Future addUserDetails(
      String FirstName, String LastName, int Age, String Email) async {
    await FirebaseFirestore.instance.collection('users').add({
      'First Name': FirstName,
      'Last Name': LastName,
      'Age': Age,
      'Email': Email,
    });
  }

  bool verifyotp = false;

  void sendOTP() async {
    EmailAuth emailAuth = EmailAuth(sessionName: "Email OTP verification");
    bool result = await emailAuth.sendOtp(
        recipientMail: _emailController.value.text, otpLength: 5);
    if (result) {
      setState(() {
        verifyotp = true;
      });
    }
  }

  void verifyOTP() async {
    EmailAuth emailAuth = EmailAuth(sessionName: "Verify OTP");
    emailAuth.validateOtp(
        recipientMail: _emailController.value.text,
        userOtp: _otpController.value.text);
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmpasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "Register As Provider",
                style: GoogleFonts.bebasNeue(
                  fontSize: 52,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Register Below With Your Details",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 237, 234, 234),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          suffix: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: InkWell(
                              child: Text(
                                "Send OTP",
                                style: TextStyle(color: Colors.blueAccent),
                              ),
                              onTap: () {
                                sendOTP();
                              },
                            ),
                          ),
                          border: InputBorder.none,
                          hintText: "Email"),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 237, 234, 234),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _otpController,
                      decoration: InputDecoration(
                          enabled: true,
                          suffix: verifyotp
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Icon(
                                    Icons.done,
                                    color: Colors.green,
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: InkWell(
                                    child: Text(
                                      "Verify OTP",
                                      style:
                                          TextStyle(color: Colors.blueAccent),
                                    ),
                                    onTap: () {
                                      verifyOTP();
                                    },
                                  ),
                                ),
                          border: InputBorder.none,
                          hintText: "OTP"),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Password"),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _confirmpasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Confirm Password"),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "FirstName"),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Mobile Number"),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: DropdownButton<String>(
                      hint: Text('Choose Category'),
                      value: selectedCategory,
                      isExpanded: true,
                      items: adj.keys
                          .map((value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (category) {
                        setState(() {
                          selectedCategory = category;
                          subCategoryChosen = adj[selectedCategory]!;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: MultiSelectDialogField(
                      decoration: BoxDecoration(
                        border: null,
                      ),
                      listType: MultiSelectListType.CHIP,
                      /* buttonIcon: Icon(
                        Icons.account_box,
                        color: Colors.blue,
                      ),
                      */
                      buttonText: Text(
                        "Sub Categories",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      items: subCategoryChosen
                          .map((indiaProvince) => MultiSelectItem<String>(
                              indiaProvince, indiaProvince))
                          .toList(),
                      title: Text("Sub Categories"),
                      searchable: true,
                      onConfirm: (results) {
                        setState(() {
                          selectedSubcategories = results;
                        });
                      }),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    child: GestureDetector(
                        onTap: () {
                          /* showBottomSheet(
                              context: context,
                              builder: ((context) => bottomsheet()));
                              */
                          showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              )),
                              builder: (context) => bottomsheet(
                                  selectImage(ImageSource.camera),
                                  selectImage(ImageSource.gallery)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Text("Upload Your Works"),
                                Icon(Icons.upload_file),
                              ],
                            ),
                          ),
                        ))),
              ),
              SizedBox(
                height: 20,
              ),
              axis
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Expanded(
                        child: Container(
                          height: 100,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                            ),
                            itemCount: _imagelist.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Image.file(
                                      File(
                                        _imagelist[index].path,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      top: -2,
                                      right: -2,
                                      child: Container(
                                        child: IconButton(
                                          onPressed: () {
                                            _imagelist.removeAt(index);
                                            if (_imagelist.length == 0) {
                                              axis = false;
                                            }
                                            setState(() {});
                                          },
                                          icon: Icon(
                                            Icons.delete_outline,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, bottom: 30.0),
                    child: TextField(
                      maxLines: 5,
                      controller: _ageController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "About"),
                    ),
                  ),
                ),
              ),
              Text(_fileText),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: signUp,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              image != null
                  ? Stack(children: [
                      ClipOval(
                        child: SizedBox.fromSize(
                          child: Image.file(
                            image!,
                            width: 160,
                            height: 160,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 15,
                          right: 15,
                          child: CircleAvatar(
                            child: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: (() {
                                showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    )),
                                    builder: (context) => bottomsheet(
                                        pickprofile(ImageSource.camera),
                                        pickprofile(ImageSource.gallery)));
                              }),
                            ),
                          )),
                    ])
                  : GestureDetector(
                      child: FlutterLogo(
                        size: 160,
                      ),
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            )),
                            builder: (context) => bottomsheet(
                                pickprofile(ImageSource.camera),
                                pickprofile(ImageSource.gallery)));
                      },
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "I am A Member?",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: (() {
                      Navigator.pop(context);
                    }),
                    child: Text(
                      " Login Now",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }

  Widget bottomsheet(var a, var b) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text("Choose Photos"),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  a(ImageSource.camera);
                },
                icon: Icon(Icons.camera),
                label: Text("Camera"),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  b(ImageSource.gallery);
                },
                icon: Icon(Icons.image),
                label: Text("Gallery"),
              )
            ],
          )
        ],
      ),
    );
  }
}
