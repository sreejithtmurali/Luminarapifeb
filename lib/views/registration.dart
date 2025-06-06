import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/Model/User.dart';
import 'package:untitled3/service/apiservice.dart';
import 'package:untitled3/service/userservice2.dart';
import 'package:untitled3/views/home.dart';
import 'package:untitled3/views/loginview.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  //{
  //   "name": "string",
  //   "phone": 9223372036854776000,
  //   "place": "string",
  //   "pincode": 2147483647,
  //   "email": "user@example.com",
  //   "password": "string"
  // }
  TextEditingController email=TextEditingController();
  TextEditingController name=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController place=TextEditingController();
  TextEditingController pincode=TextEditingController();
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
              Text("Register Now",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w800),),
              SizedBox(height: 20,),
              TextFormField(
                validator: (v){
                  return v!.length==0?"must fill this field":null;
                },
                controller: name,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "name",
                    labelText: "name"
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                validator: (v){
                  return v!.length==0?"must fill this field":null;
                },
                controller: email,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "email",
                    labelText: "email"
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                validator: (v){
                  return v!.length==0?"must fill this field":null;
                },
                controller: phone,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "phone",
                    labelText: "phone"
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                validator: (v){
                  return v!.length==0?"must fill this field":null;
                },
                controller: place,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "place",
                    labelText: "place"
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                validator: (v){
                  return v!.length==0?"must fill this field":null;
                },
                controller: pincode,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "pincod",
                    labelText: "pincode"
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
                   bool ?status=await apiService.register(email: email.text.trim(), password: password.text.trim(),name:name.text.trim(),place:place.text.trim(),phone:phone.text.trim(),pincode:pincode.text.trim());
                      if(status!=null){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.green,
                            content: Text("Registration Sucessfull")));

                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return Loginview();
                                }));

                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red,
                            content: Text("Registration Failed")));
                      }

                    }

                  }, child: Text("SignIn"))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have account? "),
                  TextButton(onPressed: (){}, child: Text("Login"))
                ],)
            ],),
        ),
      ),
    );
  }
}
