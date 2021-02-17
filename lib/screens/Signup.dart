import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_281/screens/SignIn.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  ErrorText errorText1 = ErrorText(error: '');
  ErrorText errorText2 = ErrorText(error: "");
  @override
  Widget build(BuildContext context) {
    double mHeight = MediaQuery.of(context).size.height;
    double mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
          child: Container(
              child: Form(
        key: _formKey,
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/bkg.png"),
            ),
            SizedBox(
              height: 20,
            ),
            field(" your name", Icons.person, emailControler, false,
                mHeight / 12, errorText1),
            SizedBox(
              height: 10,
            ),
            field(" Email Adress", Icons.email, passwordControler, false,
                mHeight / 12, errorText2),
            SizedBox(
              height: 10,
            ),
            field(" Mobile number", Icons.email, passwordControler, false,
                mHeight / 12, errorText2),
            SizedBox(
              height: 10,
            ),
            field("Enter your password", Icons.email, passwordControler, false,
                mHeight / 12, errorText2),
            SizedBox(
              height: 10,
            ),
            field("Confirm password", Icons.email, passwordControler, false,
                mHeight / 12, errorText2),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: mWidth,
              height: mHeight / 12,
              child: RaisedButton(
                onPressed: () {
                  _formKey.currentState.validate();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Colors.blueAccent,
                child: Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have An Account !",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                GestureDetector(
                  child: Text(
                    " Log In ",
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  onTap: () {},
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ))),
    );
  }

  field(text, IconData icon, TextEditingController controller, bool obscureText,
      double height, ErrorText error) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              height: height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: TextFormField(
                style: TextStyle(color: Colors.black, fontSize: 18.0),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(width: .5)),
                    hintText: text,
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
                    prefixIcon: Icon(icon, color: Colors.black),
                    contentPadding: EdgeInsets.only(left: 10)),
                keyboardType: TextInputType.text,
                obscureText: obscureText,
                controller: controller,
                validator: (value) {
                  if (value == "") {
                    error.error = "Empty Field Required";
                  } else {
                    error.error = "";
                  }
                  setState(() {});
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              child: Text(
                error.error,
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 10),
            )
          ],
        ));
  }

  Future<String> _pickImage(ImageSource source) async {
    var _picked = await ImagePicker.pickImage(source: source);
    if (_picked != null) return _picked.path;
  }

  _showDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: Text(
              "Select from",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(
                    "Camera",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(
                    Icons.camera,
                    color: Colors.grey,
                    size: 20,
                  ),
                  onTap: () {
                    _pickImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: Text(
                    "Gallery",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(
                    Icons.photo_album,
                    color: Colors.grey,
                    size: 20,
                  ),
                  onTap: () {
                    _pickImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
        });
  }
}

class User {
  String name;
  String email;
  String mob_num;
  String password;
  String url;

  User({this.name, this.email, this.mob_num, this.password, this.url});

  saveUserData() async {
    SharedPreferences register = await SharedPreferences.getInstance();
    register.setString('name', name);
    register.setString('email', email);
    register.setString('mobile', mob_num);
    register.setString('password', password);
    register.setString('url', url);
  }

  Future<User> getUserData() async {
    SharedPreferences register = await SharedPreferences.getInstance();
    return User(
        name: register.getString('name'),
        email: register.getString('email'),
        mob_num: register.getString('mobile'),
        password: register.getString('password'),
        url: register.getString('url'));
  }
}
