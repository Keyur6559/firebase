import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class phone extends StatefulWidget {
  const phone({Key? key}) : super(key: key);

  @override
  State<phone> createState() => _phoneState();
}

class _phoneState extends State<phone> {
  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  String vid="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(controller: t1,),
          TextField(controller: t2,),
          ElevatedButton(onPressed:  () async {
            await FirebaseAuth.instance.verifyPhoneNumber(
              phoneNumber: '+91 ${t1.text}',
              verificationCompleted: (PhoneAuthCredential credential) async {
                await auth.signInWithCredential(credential);
              },
              verificationFailed: (FirebaseAuthException e) {
                if (e.code == 'invalid-phone-number') {
                  print('The provided phone number is not valid.');
                }
              },
              codeSent: (String verificationId, int? resendToken) {
                setState(() {
                  vid=verificationId;
                });
              },
              codeAutoRetrievalTimeout: (String verificationId) {},
            );
          }, child: Text("Send OTP")),
          ElevatedButton(onPressed:  () async {
            PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: vid, smsCode: t2.text);
            await auth.signInWithCredential(credential).then((value) {
              print(value);
            });
          }, child: Text("Verify OTP")),

        ],
      ),
    );
  }
}
