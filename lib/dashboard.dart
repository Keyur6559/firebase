import 'package:firebase/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class dashboard extends StatefulWidget {
  UserCredential value;
  dashboard(this.value);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: () async {
          await GoogleSignIn().signOut();
          await FirebaseAuth.instance.signOut();
          Navigator.push(context,MaterialPageRoute(builder: (context) {
            return MyApp();
          },));
        }, icon: Icon(Icons.logout))
      ],),
      body: Column(
        children: [
          Text("${widget.value.additionalUserInfo!.profile!['given_name']}"),
          Text("${widget.value.additionalUserInfo!.profile!['family_name']}"),
          Image.network('${widget.value.additionalUserInfo!.profile!['picture']}'),
          Text("${widget.value.additionalUserInfo!.providerId}")
        ],
      ),
    );
  }
}
