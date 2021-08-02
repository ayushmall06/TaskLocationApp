import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mytask/config/config.dart';

class EmailPassSignUpScreen extends StatefulWidget {


  @override
  _EmailPassSignUpScreenState createState() => _EmailPassSignUpScreenState();
}

class _EmailPassSignUpScreenState extends State<EmailPassSignUpScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
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
                  _signup();
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
                      "Sign Up Usign Email",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signup() {
    final String _email = _emailController.text.trim();
    final String _password = _passwordController.text;
    if(_email.isNotEmpty && _password.isNotEmpty)
      {
        _auth.createUserWithEmailAndPassword(email: _email, password: _password)
            .then((user) => showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text("Done"),
                content: Text("Sign Up success. Now You can Sign In"),
                actions: [
                  TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),


                ],
              );
            }
        ))
        .catchError((e) {
          if(e.code == 'weak-password')
            {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: Text("Error"),
                      content: Text("The password provided is too weak"),
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
          else if( e.code == 'email-already-in-use')
            {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: Text("Done"),
                      content: Text("The account already exists for that email."),
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
        } );
      }
    else {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Please provide email and password"),
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

}
