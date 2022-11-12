import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Providereditview extends StatefulWidget {
  const Providereditview({super.key});

  @override
  State<Providereditview> createState() => _ProvidereditviewState();
}

class _ProvidereditviewState extends State<Providereditview> {
  double val = 0;
  Position? _currentPosition;
  String? Latitude;
  String? Longitude;
  String? _currentAddress;
  File? Profileimage;

  String? ProfileFileName;

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    setState(() {
      _currentPosition = position;
      Latitude = _currentPosition?.latitude.toString();
      Longitude = _currentPosition?.longitude.toString();

      _getAddressFromLatLng();
    });
    print(position);

    return await Geolocator.getCurrentPosition();
  }

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

  Map<String, String> BuyerDashboardImage = {
    "Carpenter": "https://unsplash.com/photos/IvzvlKQwjk8",
    "Ac Repair Services":
        "https://www.freepik.com/free-photo/hvac-technician-working-capacitor-part-condensing-unit-male-worker-repairman-uniform-repairing-adjusting-conditioning-system-diagnosing-looking-technical-issues_10444780.htm#query=air%20conditioner%20repair&position=9&from_view=keyword",
    "Painting":
        "https://www.freepik.com/free-photo/portrait-repairer-woman-with-painting-roller-isolated_4410817.htm#query=PAINTER&position=0&from_view=search&track=sph",
    "Pest Control Services": "https://unsplash.com/photos/wz3ijPHvL54",
    "Housekeeping services": "",
    "Welding/fabricator": "",
    "Plumber services": "",
    "CCTV installation": "",
    "Electrician": "",
    "Beauty & Makeup": "",
    "Civil Works/Interior decorator": "",
    "Scrap Collection": "",
    "Yoga & Fitness": "",
    "Home Chefs": "",
    "Home tutors": "",
    "Dance & Music trainers": "",
    "Language trainers": "",
    "Computer (IT trainers)": "",
    "Hamal(General Labor) ": "",
    "Packer & Movers": "",
    "Healthcare": "",
    "Real Estate": "",
    "Appliances repair ": "",
    "Cook/Chef/Aayah": ""
  };

  @override
  void initState() {
    super.initState();

    determinePosition();
  }

  Future<List<String?>?> uploadFile(
      List<XFile> payload, String directory) async {
    List<String?> workImageUrls = [];
    for (var imgFile in payload) {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child(directory)
          .child(DateTime.now().toIso8601String() + imgFile.name);

      await ref.putFile(Profileimage);
      String? imageUrl;
      imageUrl = await ref.getDownloadURL();
      workImageUrls.add(imageUrl);
    }
    return workImageUrls;
  }

  Future<void> selectImage(ImageSource source) async {
    try {
      final selectedImage = await ImagePicker().pickImage(source: source);
      if (selectedImage != null) {
        _ProviderWorkimagelist.add(selectedImage);
        axis = true;
      }
      setState(() {});
    } on PlatformException catch (e) {
      print("Failed to pick images  $e");
    }
  }

  List<String> subCategoryChosen = [];
  List<String> selectedSubcategories = [];
  List<XFile> _ProviderWorkimagelist = [];
  List<XFile> _Providerdocimagelist = [];
  String? selectedCategory;

  bool axis = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _NameController = TextEditingController();
  final _otpController = TextEditingController();
  final _PhoneNumberController = TextEditingController();
  final _AboutController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _NameController.dispose();
    _PhoneNumberController.dispose();
    _AboutController.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (passwordConfirmed()) {
      String? profilePicUrl = await uploadProfileFile();
      List<String?>? workImageUrls =
          await uploadFile(_ProviderWorkimagelist, "Work Images");
      List<String?>? documentImageUrls =
          await uploadFile(_Providerdocimagelist, "Document Images");

      final UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final String? uid = credential.user?.uid;
      final String? Roles = "Provider";
      final bool? isAccepted = false;
      final bool? BuyerAccepted = false;

      UpdateUserDetails(
        _NameController.text.trim(),
        _AboutController.text.trim(),
        int.parse(_PhoneNumberController.text.trim()),
        selectedCategory!,
        _emailController.text.trim(),
        selectedSubcategories,
        workImageUrls!,
        documentImageUrls!,
        profilePicUrl!,
        uid,
        Latitude,
        Longitude,
        Roles,
        isAccepted,
      );
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  Future<String?> uploadProfileFile() async {
    if (Profileimage == null) {
      // show toast -> pls select image
    }

    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child("Profile Images")
          .child(DateTime.now().toIso8601String());
      await ref.putFile(Profileimage!);
      String? imageUrl;

      imageUrl = await ref.getDownloadURL();

      return imageUrl;
    } catch (e) {
      print(e);
    }
  }

  Future UpdateUserDetails(
    String Name,
    String About,
    int PhoneNumber,
    String SelectedCategory,
    String Email,
    List<String?> Subcategory,
    List<String?>? picsOfWorks,
    List<String?>? idProofs,
    String ProfilePic,
    String? uid,
    String? longitude,
    String? Latitude,
    String? Roles,
    bool? isAccepted,
  ) async {
    await FirebaseFirestore.instance.collection('User').doc(uid).set({
      'Name': Name,
      'About': About,
      'PhoneNumber': PhoneNumber,
      'Email': Email,
      'SelectedCategory': SelectedCategory,
      'SubCategory': Subcategory,
      'WorkdoneImages': picsOfWorks,
      'Id_proofs': idProofs,
      'Profile_Pics': ProfilePic,
      'Uid': uid,
      'Latitude': Latitude,
      'Longitude': longitude,
      'Roles': Roles,
      'isAccepted': isAccepted,
    });
  }

  bool verifyotp = false;

  void sendOTP() async {}

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
                height: 20,
              ),
              Profileimage != null
                  ? Stack(children: [
                      ClipOval(
                        child: SizedBox.fromSize(
                          child: Image.file(
                            Profileimage!,
                            width: 160,
                            height: 160,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 10,
                          right: 30,
                          child: CircleAvatar(
                            child: IconButton(
                              icon: Profileimage == null
                                  ? Icon(Icons.add)
                                  : Icon(Icons.edit),
                              onPressed: (() {
                                showModalBottomSheet(
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    )),
                                    builder: (context) => Profilebottomsheet());
                              }),
                            ),
                          )),
                    ])
                  : GestureDetector(
                      child: ClipOval(
                        child: Stack(children: [
                          Container(
                            color: Colors.white,
                            width: 160,
                            height: 160,
                            child: IconButton(
                              icon: Icon(
                                Icons.person,
                                size: 150,
                              ),
                              onPressed: () {},
                            ),
                          ),
                          Positioned(
                              bottom: 10,
                              right: 30,
                              child: CircleAvatar(
                                child: IconButton(
                                  icon: Profileimage == null
                                      ? Icon(Icons.add)
                                      : Icon(Icons.edit),
                                  onPressed: (() {
                                    showModalBottomSheet(
                                        context: context,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(1),
                                        )),
                                        builder: (context) =>
                                            Profilebottomsheet());
                                  }),
                                ),
                              )),
                        ]),
                      ),
                    ),
              SizedBox(
                height: 10,
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
                              onTap: () {},
                            ),
                          ),
                          border: InputBorder.none,
                          hintText: "Phone Number"),
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
                                    onTap: () {},
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
                      controller: _NameController,
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
                      controller: _emailController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "E-mail"),
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
                          .map((SubcategoriesProvince) =>
                              MultiSelectItem<String>(
                                  SubcategoriesProvince, SubcategoriesProvince))
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
                          showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              )),
                              builder: (context) =>
                                  Providerbottomsheet(_ProviderWorkimagelist));
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
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _ProviderWorkimagelist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        leading: Image.file(
                          File(_ProviderWorkimagelist[index].path),
                          height: 100,
                          width: 40,
                        ),
                        title: Text(_ProviderWorkimagelist[index].name),
                        trailing: IconButton(
                            onPressed: () {
                              _ProviderWorkimagelist.removeAt(index);
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ),
                    );
                  },
                ),
              ),
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
                      controller: _AboutController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "About"),
                    ),
                  ),
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
                          builder: (context) =>
                              Providerbottomsheet(_Providerdocimagelist));
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
                            Text("Upload Aadhar Card/Pan Card"),
                            Icon(Icons.upload_file),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _Providerdocimagelist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        leading: Image.file(
                          File(_Providerdocimagelist[index].path),
                          height: 100,
                          width: 40,
                        ),
                        title: Text(_Providerdocimagelist[index].name),
                        trailing: IconButton(
                            onPressed: () {
                              _Providerdocimagelist.removeAt(index);
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ),
                    );
                  },
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
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget Providerbottomsheet(var _imagelist) {
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
                  icon: Icon(Icons.camera),
                  label: Text("Camera"),
                  onPressed: () async {
                    try {
                      final selectedImage = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      if (selectedImage != null) {
                        if (_imagelist.length == 4) {
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Can choose only 4 images"),
                          ));
                        } else {
                          _imagelist.add(selectedImage);
                          setState(() {
                            axis = true;
                          });
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                        }
                      }
                    } on PlatformException catch (e) {
                      print("Failed to pick images  $e");
                    }
                  }),
              ElevatedButton.icon(
                onPressed: () async {
                  try {
                    final selectedImage = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (selectedImage != null) {
                      _imagelist.add(selectedImage);
                      axis = true;
                    }
                    setState(() {});
                  } on PlatformException catch (e) {
                    print("Failed to pick images  $e");
                  }
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

  Widget Profilebottomsheet() {
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
                  icon: Icon(Icons.camera),
                  label: Text("Camera"),
                  onPressed: () async {
                    try {
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      if (image == null) return;

                      final imageTemporary = File(image.path);
                      setState(() {
                        Profileimage = imageTemporary;
                      });
                      Navigator.of(context).pop();
                    } on PlatformException catch (e) {
                      print("Failed to pick images  $e");
                    }
                  }),
              ElevatedButton.icon(
                onPressed: () async {
                  try {
                    final image = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (image == null) return;

                    final imageTemporary = File(image.path);
                    final imageTemporaryfilename = File(image.name);
                    setState(() {
                      this.Profileimage = imageTemporary;
                      ProfileFileName = imageTemporaryfilename.toString();
                    });
                    Navigator.of(context).pop();
                  } on PlatformException catch (e) {
                    print("Failed to pick images  $e");
                  }
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

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }
}
