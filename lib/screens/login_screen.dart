import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import 'package:google_sign_in/google_sign_in.dart';
import 'package:mytask/config/config.dart';
import 'package:mytask/screens/email_pass_signup.dart';
import 'package:mytask/screens/phone_signin_screen.dart';


class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {








    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [

            Container(
              margin: EdgeInsets.only(top: 80),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0x4400FD8D),
                    blurRadius: 30,
                    offset: Offset(10,10),
                    spreadRadius: 0,
                  )
                ]
              ),
              child: Image(
                image: AssetImage("assets/logo_round.png"),
                width: 200,
                height: 200,
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),

            Container(

              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 40),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email",
                  hintText: "Write Email Here",
                ),
                keyboardType: TextInputType.emailAddress,

              ),
            ),

            Container(

              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 10),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Password",
                  hintText: "Write Password Here",
                ),
                obscureText: true,

              ),
            ),

            InkWell(
              onTap: () {
                _signIn();
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      primaryColor,
                      secondaryColor,
                    ]
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                width: MediaQuery.of(context).size.width,
                margin:EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Center(
                  child: Text(
                    "Login with Email",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmailPassSignUpScreen()
                  )
                );
              },
              child: Text(
                "SignUp using Email",
              ),
            ),

            Container(
              margin: EdgeInsets.only(
                top: 30,
              ),
              child: Wrap(
                children: [

                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhoneSignInScreen()
                        )
                      );
                    },
                    icon: Icon(Icons.phone),
                    label: Text("Sign-In Using Phone "),
                  ),

                  TextButton.icon(
                    onPressed: () {
                      _signInUsingGoogle();
                    },
                    icon: Icon(
                      FontAwesomeIcons.google,
                      color: Colors.red,
                    ),
                    label: Text(
                      "Sign-In Using Gmail",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _signIn() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text;

    if(email.isNotEmpty && password.isNotEmpty)
      {
        _auth.signInWithEmailAndPassword(
          email: email,
          password: password
        ).then((user) => {

          showDialog(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  title: Text("Done"),
                  content: Text("Sign in success..."),
                  actions: [
                    TextButton(
                      child: Text("Cancel"),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                    ),
                    TextButton(
                      child: Text("OK"),
                      onPressed: () {
                        _emailController.text =  "";
                        _passwordController.text = "";
                        Navigator.of(ctx).pop();
                      },
                    ),

                  ],
                );
              }
          )


        }).catchError((e){
          if(e.code == 'user-not-found')
            {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: Text("Error"),
                      content: Text("No user found for that email..."),
                      actions: [
                        TextButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                        ),
                        TextButton(
                          child: Text("OK"),
                          onPressed: () {
                            _emailController.text =  "";
                            _passwordController.text = "";
                            Navigator.of(ctx).pop();
                          },
                        ),

                      ],
                    );
                  }
              );
            }
          else if(e.code == 'wrong-password')
            {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: Text("Error"),
                      content: Text("Wrong password provided for that user"),
                      actions: [
                        TextButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                        ),
                        TextButton(
                          child: Text("OK"),
                          onPressed: () {
                            _emailController.text =  "";
                            _passwordController.text = "";
                            Navigator.of(ctx).pop();
                          },
                        ),

                      ],
                    );
                  }
              );
            }
        });

      } else {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Please provide email and password..."),
            actions: [
              TextButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  _emailController.text =  "";
                  _passwordController.text = "";
                  Navigator.of(ctx).pop();
                },
              ),

            ],
          );
        }



      );
    }

  }
  void _signInUsingGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final User? user = (await _auth.signInWithCredential(credential))
      .user;
      print('Sign in ' + user!.displayName.toString());

    } catch (error) {
      print(error);
    }
  }
}
