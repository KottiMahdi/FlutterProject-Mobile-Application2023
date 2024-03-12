// ignore_for_file: body_might_complete_normally_nullable, prefer_const_constructors, avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/component/TextFormFieldAdd.dart';
import 'package:my_app/component/customButtonAuth.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  // Form key and controller
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();

  // Loading indicator flag
  bool isLoading = false;

  // Firestore collection reference
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  // Function to add data to Firestore
  void addCategory() async {
    if (formstate.currentState!.validate()) {
      try {
        // Set loading indicator to true
        isLoading = true;
        setState(() {});

        // Add category data to Firestore
        // ignore: unused_local_variable
        DocumentReference response = await categories.add({
          'name': name.text,
          'id': FirebaseAuth.instance.currentUser!.uid,
        });

        // Navigate to the homepage and remove all previous routes
        Navigator.of(context)
            .pushNamedAndRemoveUntil('homepage', (route) => false);
      } catch (e) {
        // If an error occurs, set loading indicator to false and print the error
        isLoading = false;
        setState(() {});
        print("Error $e");
      }
    }
  }

  @override
  void dispose() {
    // Dispose of the text controller
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Add Category"),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Form(
          key: formstate,
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 25),
                      child: CustomTextFormFieldAdd(
                        hintText: "Enter name",
                        mycontroller: name,
                        validator: (val) {
                          if (val == "") {
                            return "Can't To be Empty";
                          }
                        },
                      ),
                    ),
                    customButton(
                      title: "Add",
                      onPressed: () {
                        addCategory();
                      },
                    ),
                    Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom))
                  ],
                ),
        ),
      ),
    );
  }
}
