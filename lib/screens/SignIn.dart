import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  ErrorText errorText1 = ErrorText();
  ErrorText errorText2 = ErrorText();

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
            Container(
              child: Image.asset(
                "assets/bkgmovie.jpg",
                fit: BoxFit.fill,
              ),
              height: mHeight / 2.5,
              width: mWidth,
            ),
            SizedBox(
              height: 20,
            ),
            field("Enter your email address", Icons.person, emailControler,
                false, mHeight / 12, errorText1),
            SizedBox(
              height: 10,
            ),
            field("Enter your password", Icons.email, passwordControler, true,
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
                  "Log In",
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
                  "Don't have An Account ?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                GestureDetector(
                  child: Text(
                    " Sign up ",
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

  validateForm() async {
    if (emailControler.text.isNotEmpty) {;
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return; //NotesList();
      }));
    } else {
      return _scaffoldKey.currentState.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
          content: Text(
            'Some Fields Required',
            style: TextStyle(fontSize: 20),
          )));
    }
  }
}

class ErrorText {
  String error = "";
  ErrorText({this.error});
}
