import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/Model/User.dart';
import 'package:untitled3/service/apiservice.dart';
import 'package:untitled3/service/userservice2.dart';
import 'package:untitled3/views/home.dart';
import 'package:untitled3/views/registration.dart';

class Loginview extends StatefulWidget {
  const Loginview({super.key});

  @override
  State<Loginview> createState() => _LoginviewState();
}

class _LoginviewState extends State<Loginview> {
  TextEditingController username=TextEditingController();
  TextEditingController password=TextEditingController();
  final formkey=GlobalKey<FormState>();
  ApiService apiService=ApiService();
  Userservice2 userservice2=Userservice2();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Login Now",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w800),),
            SizedBox(height: 20,),
            TextFormField(
              validator: (v){
                return v!.length==0?"must fill this field":null;
              },
              controller: username,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "username",
                labelText: "username"
              ),
            ),
            SizedBox(height: 10,),
            TextFormField(
              validator: (v){
                return v!.length==0?"must fill this field":null;
              },
              controller: password,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "password",
                  labelText: "password"
              ),
            ),SizedBox(height: 10,),
            Container(
              width: double.maxFinite,
                height: 50,
                child: ElevatedButton(onPressed: () async {
                  if(formkey.currentState!.validate()){
                    User? user=await apiService.login(email: username.text.trim(), password: password.text.trim());
                    if(user!=null){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.green,
                          content: Text("Login Sucessfull")));
                      await userservice2.saveuser(user);
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (BuildContext context) {
                        return Home();
                      }));

                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red,
                          content: Text("Login Failed")));
                    }

                  }

                }, child: Text("Login"))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("Don't have account? "),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                    return Registration();
                  }));
                }, child: Text("SignUp"))
              ],)
          ],),
        ),
      ),
    );
  }
}
