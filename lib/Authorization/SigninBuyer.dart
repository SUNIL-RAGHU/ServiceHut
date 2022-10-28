// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _PhoneNumberController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _PhoneNumberController.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (passwordConfirmed()) {
      final UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      final String? uid = credential.user?.uid;
      final String? Roles = "Buyer";

      addUserDetails(
          _firstNameController.text.trim(),
          _lastNameController.text.trim(),
          int.parse(_PhoneNumberController.text.trim()),
          _emailController.text.trim(),
          uid!,
          Roles!);
    }
  }

  Future addUserDetails(String FirstName, String LastName, int PhoneNumber,
      String Email, String uid, String Roles) async {
    await FirebaseFirestore.instance.collection('User').doc(uid).set({
      'First Name': FirstName,
      'Last Name': LastName,
      'PhoneNumber': PhoneNumber,
      'Email': Email,
      'Uid': uid,
      'Roles': Roles,
    });
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmpasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  bool verifyotp = false;
  void sendOTP() async {
    EmailAuth emailAuth = new EmailAuth(sessionName: "Email OTP verification");
    bool result = await emailAuth.sendOtp(
        recipientMail: _emailController.value.text, otpLength: 5);
    if (result) {
      setState(() {
        verifyotp = true;
      });
    }
  }

  void verifyOTP() async {
    EmailAuth emailAuth = new EmailAuth(sessionName: "Verify OTP");
    emailAuth.validateOtp(
        recipientMail: _emailController.value.text,
        userOtp: _otpController.value.text);
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
                "REGISTER HAS NEW BUYER",
                style: GoogleFonts.bebasNeue(
                  fontSize: 52,
                ),
              ),
              SizedBox(
                height: 10,
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
                      controller: _PhoneNumberController,
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
                          hintText: "PhoneNumber"),
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
                          suffix: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: InkWell(
                              child: Text(
                                "Verify OTP",
                                style: TextStyle(color: Colors.blueAccent),
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
                height: 10,
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
                          border: InputBorder.none, hintText: "LastName"),
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
                      controller: _emailController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Email"),
                    ),
                  ),
                ),
              ),
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
}
