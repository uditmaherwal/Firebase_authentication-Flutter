import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser user;
  bool isSignedIn = false;

  checkAuth() async {
    _firebaseAuth.onAuthStateChanged.listen((event) {
      if (event == null) {
        Navigator.pushReplacementNamed(context, '/SigninPage');
      }
    });
  }

  getUser() async {
    FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
    await firebaseUser?.reload();
    firebaseUser = await _firebaseAuth.currentUser();
    if (firebaseUser != null) {
      setState(
        () {
          this.user = firebaseUser;
          this.isSignedIn = true;
        },
      );
    }
  }

  signOut() async {
    _firebaseAuth.signOut();
  }

  @override
  void initState() {
    super.initState();
    this.checkAuth();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: Center(
            child: !isSignedIn
                ? CircularProgressIndicator()
                : Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(50.0),
                        width: 100.0,
                        height: 100.0,
                        child: Image(image: AssetImage('images/logo.png')),
                      ),
                      Container(
                        padding: EdgeInsets.all(50.0),
                        child: Text(
                          'Hello ${user.displayName}, you are logged in as ${user.email}',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: RaisedButton(
                          elevation: 10.0,
                          color: Colors.black,
                          onPressed: signOut,
                          child: Text(
                            'Sign Out',
                            style:
                                TextStyle(color: Colors.blue, fontSize: 20.0),
                          ),
                          padding:
                              EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 20.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                      )
                    ],
                  )),
      ),
    );
  }
}
