import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name, _email, _password;

  checkAuth() async {
    _firebaseAuth.onAuthStateChanged.listen((event) {
      if (event != null) {
        Navigator.pushReplacementNamed(context, '/');
      }
    });
  }

  navigateToSigninPage() {
    Navigator.pushReplacementNamed(context, '/SigninPage');
  }

  @override
  void initState() {
    super.initState();
    this.checkAuth();
  }

  showError(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok'),
            )
          ],
        );
      },
    );
  }

  signup() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        FirebaseUser user = (await _firebaseAuth.createUserWithEmailAndPassword(
                email: _email, password: _password))
            .user;
        if (user != null) {
          UserUpdateInfo updateInfo = UserUpdateInfo();
          updateInfo.displayName = _name;
          user.updateProfile(updateInfo);
        }
      } catch (e) {
        showError(e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Text(
              'Let\'s create an account !',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28.0,
              ),
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Container(
        child: Center(
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 50.0),
                child: Image(
                  image: AssetImage('images/logo.png'),
                  width: 100.0,
                  height: 100.0,
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          smartQuotesType: SmartQuotesType.enabled,
                          validator: (value) {
                            if (value == 'empty') {
                              return 'Provide a name';
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onSaved: (value) => _name = value,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == 'empty') {
                              return 'Provide an email';
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'yourname@mail.com',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onSaved: (value) => _email = value,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == 'empty') {
                              return 'Provide a password';
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          obscureText: true,
                          onSaved: (value) => _password = value,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 40, 0, 40),
                        margin: EdgeInsets.all(10.0),
                        child: RaisedButton(
                          elevation: 10.0,
                          splashColor: Colors.grey,
                          animationDuration: Duration(microseconds: 200),
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0,
                                color: Colors.blue),
                          ),
                          padding: EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          onPressed: signup,
                        ),
                      ),
                      GestureDetector(
                        child: Icon(Icons.keyboard_backspace),
                        onTap: navigateToSigninPage,
                      )
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
}
