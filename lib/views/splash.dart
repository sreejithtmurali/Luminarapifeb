import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/service/userservice2.dart';
import 'package:untitled3/views/loginview.dart';

import 'home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Userservice2 userservice2=Userservice2();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logincheck();
  }
  Future<void> logincheck() async {
    bool status=await userservice2.islogin();
    if(status==true){
      Future.delayed(Duration(seconds: 3),(){
        Navigator.push(context,
            MaterialPageRoute(
                builder: (BuildContext context) {
                  return Home();
                }));
      });

    }
    else{
      Future.delayed(Duration(seconds: 3),(){
        Navigator.push(context,
            MaterialPageRoute(
                builder: (BuildContext context) {
                  return Loginview();
                }));
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Icon(Icons.card_travel, size: 100)
        )
    );
  }
}
