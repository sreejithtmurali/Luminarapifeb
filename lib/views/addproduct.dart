import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled3/service/apiservice.dart';

class Addproduct extends StatefulWidget {
  const Addproduct({super.key});

  @override
  State<Addproduct> createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController namectlr=TextEditingController();
  TextEditingController descriptionctlr=TextEditingController();
  TextEditingController pricectlr=TextEditingController();
  TextEditingController stockctlr=TextEditingController();
  ApiService apiService=ApiService();
  num? id, price, stock;
  String? name, description, category;
  File? imageFile;

  final List<String> categories = ['Electronics', 'Clothing', 'Books', 'Toys'];

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
      });
    }
  }

  Future<void> _saveProduct() async {
    if (_formKey.currentState!.validate()) {
      await apiService.addproduct(
          name: namectlr.text.trim(),
          description: descriptionctlr.text.trim(),
          price: pricectlr.text,
          stock: stockctlr.text,
          category: category,
          image:imageFile
      );
     }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Product')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  _pickImage();
                },
                child: Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey[300],
                  child: imageFile != null
                      ? Image.file(imageFile!, fit: BoxFit.cover)
                      : Center(child: Text('Tap to pick image')),
                ),
              ),
              TextFormField(
                controller: namectlr,
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (val) => name = val,
                validator: (val) => val!.isEmpty ? 'Enter name' : null,
              ),
              TextFormField(
                controller: descriptionctlr,
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (val) => description = val,
              ),
              TextFormField(
                controller: pricectlr,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onSaved: (val) => price = num.tryParse(val ?? ''),
              ),
              TextFormField(
                controller: stockctlr,
                decoration: InputDecoration(labelText: 'Stock'),
                keyboardType: TextInputType.number,
                onSaved: (val) => stock = num.tryParse(val ?? ''),
              ),
              DropdownButtonFormField<String>(
                value: category,
                items: categories
                    .map((c) => DropdownMenuItem(
                  child: Text(c),
                  value: c,
                ))
                    .toList(),
                onChanged: (val) => setState(() => category = val),
                decoration: InputDecoration(labelText: 'Category'),
                validator: (val) => val == null ? 'Select category' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProduct,
                child: Text('Save Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
