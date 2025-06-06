import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/service/apiservice.dart';
import 'package:untitled3/service/userservice2.dart';
import 'package:untitled3/views/addproduct.dart';
import 'package:untitled3/views/loginview.dart';

import '../Model/allproducts/Data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Userservice2 userservice2 = Userservice2();
  ApiService apiService=ApiService();
  List<Products>? products=[];
  bool isloading=false;
  void toggle(){
    setState(() {
      isloading=!isloading;  
    });
  }
  Future<void> upadteproducts() async {
    toggle();
    products=await apiService.fetchproducts();
    toggle();
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    upadteproducts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await userservice2.logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Loginview();
                  },
                ),
                (Route<dynamic> route) => false,
              );
            },
            icon: Icon(Icons.settings_power_rounded),
          ),
        ],
      ),
      body: isloading?
      Center(child: CircularProgressIndicator(),):
      ListView.builder(itemCount: products!.length,
        itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text("${products![index].name}"),
          subtitle: Text('${products![index].description}'),
          trailing: Text('${products![index].price}'),
        );
      },),
      
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
            return Addproduct();
          }));
        },
        child: Icon(Icons.add),),
    );
  }
}
