import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/auth/auth_services.dart';
import 'package:shopping_list/auth/signInSignUpResult.dart';
import 'package:shopping_list/database/category.dart';
import 'package:shopping_list/database/product.dart';
import 'package:shopping_list/pages/login.dart';
import 'package:shopping_list/pages/product/product_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([
                  _showLogo(),
                  _form(),
                  _registerButton(),
                ]),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(bottom: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Already have account ?",
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Text(
                          "Login here",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk menampilkan logo
  Widget _showLogo() {
    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/logo.png',
            height: 300,
            width: 300,
          ),
          Text(
            "Register",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w700,
              letterSpacing: 10,
            ),
          ),
          SizedBox(height: 15),
          Divider(thickness: 3),
        ],
      ),
    );
  }

  // widget untuk menampilkan form inputan
  Widget _form() {
    return Form(
      key: _formKey,
      child: Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: "Enter Email",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Enter an Email Address';
              } else if (!value.contains('@')) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: TextFormField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(
              labelText: "Enter Password",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value.isEmpty) {
                return 'Enter Password';
              } else if (value.length < 6) {
                return 'Password must be atleast 6 characters!';
              }
              return null;
            },
          ),
        ),
      ]),
    );
  }

  // Button untuk register
  Widget _registerButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      width: double.infinity,
      child: RaisedButton(
        onPressed: () async {
          SignInSignUpResult result = await AuthService.createUser(
              email: emailController.text, pass: passwordController.text);
          if (result.user != null) {
            Categories.userUid = _auth.currentUser.uid;
            Product.userUid = _auth.currentUser.uid;
            // Go to Profile Page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductPage(),
              ),
            );
          } else {
            // Show Dialog
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Error"),
                content: Text(result.message),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK"),
                  )
                ],
              ),
            );
          }
        },
        child: Text(
          "Register",
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: Colors.teal[300],
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }
}
